import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penggajian/admin/drawer_admin.dart';
import 'dart:convert';

import 'package:penggajian/admin/tabel_karyawan_detail.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: MonthlyReport(),
));

class MonthlyReport extends StatefulWidget {
  @override
  _MonthlyReportState createState() => _MonthlyReportState();
}

class _MonthlyReportState extends State<MonthlyReport> {
  String _apiUrl = 'http://192.168.192.103/api/crud.php';
  Map<String, double> _monthlyTotal = {};

  @override
  void initState() {
    super.initState();
    _fetchMonthlyData();
  }

  Future<void> _fetchMonthlyData() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> rawData = json.decode(response.body);

        _monthlyTotal.clear();

        rawData.forEach((entry) {
          String bulanTahun = entry['bulan_tahun'];
          double gajiBersih =
          double.tryParse(entry['jumlah_bersih'] ?? '0.0') ?? 0.0;

          if (_monthlyTotal.containsKey(bulanTahun)) {
            _monthlyTotal[bulanTahun] = _monthlyTotal[bulanTahun]! + gajiBersih;
          } else {
            _monthlyTotal[bulanTahun] = gajiBersih;
          }
        });

        setState(() {});
      } else {
        print('Gagal mengambil data dari API');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan Bulanan'),
        backgroundColor: Colors.green,
      ),
      body: _monthlyTotal.isEmpty
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            columns: [
              DataColumn(label: Text('Bulan Tahun')),
              DataColumn(label: Text('Total Gaji Bersih')),
            ],
            rows: _monthlyTotal.entries.map((entry) {
              return DataRow(
                cells: [
                  DataCell(
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailPage(bulanTahun: entry.key)),
                        );
                      },
                      child: Text(entry.key),
                    ),
                  ),
                  DataCell(
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailPage(bulanTahun: entry.key)),
                        );
                      },
                      child: Text('\Rp${entry.value.toStringAsFixed(0)}'),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
      drawer: AppDrawerAdmin(
        nama: '',
        role: '',
        userId: '',
      ),
    );
  }
}


class DetailPage extends StatefulWidget {
  final String bulanTahun;

  DetailPage({required this.bulanTahun});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String _apiUrl = 'http://192.168.192.103/api/crud.php';

  List<Map<String, dynamic>> _detailDataList = [];

  @override
  void initState() {
    super.initState();
    _fetchDetailData(widget.bulanTahun); // Mengirimkan bulanTahun ke _fetchDetailData
  }

  Future<void> _fetchDetailData(String bulanTahun) async { // Menambahkan parameter bulanTahun
    try {
      final response = await http.get(Uri.parse('$_apiUrl?bulan_tahun=$bulanTahun')); // Menggunakan bulanTahun dari parameter
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);

        if (responseData is List<dynamic>) {
          // Response berupa list, atur _detailDataList
          setState(() {
            _detailDataList = List<Map<String, dynamic>>.from(responseData.where((data) => data['bulan_tahun'] == bulanTahun)); // Filter data berdasarkan bulan_tahun yang dipilih
          });
        } else {
          print('Respon API tidak valid: Bukan list');
        }
      } else {
        print('Gagal mengambil data detail dari API. Kode status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching detail data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Gaji Bulan ${widget.bulanTahun}'),
      ),
      body: _detailDataList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          :  ListView.builder(
              itemCount: _detailDataList.length,
              itemBuilder: (context, index) {
                final detailData = _detailDataList[index];
                return InkWell(
                  onTap: () {
                    // Handle onTap event here
                    // For example, you can navigate to another detail page or show a dialog
                    Navigator.push(
                    context,
                       MaterialPageRoute(builder: (context) => AnotherDetailPage(detailData: detailData)),
                     );
                  },
                  child: ListTile(
                    title: Text(detailData['nama']),
                    subtitle: Text('Gaji: ${detailData['total_pendapatan']}, Potongan: ${detailData['total_potongan']}'),
                    // Anda dapat menyesuaikan ListTile berdasarkan struktur data Anda
                  ),
                );
              },
            ),
            
    );
  }
}
