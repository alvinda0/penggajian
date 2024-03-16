import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:penggajian/admin/drawer_admin.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MonthlyReport(),
    ));

class MonthlyReport extends StatefulWidget {
  @override
  _MonthlyReportState createState() => _MonthlyReportState();
}

class _MonthlyReportState extends State<MonthlyReport> {
  String _apiUrl = 'http://192.168.116.105/api/crud.php';
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

        // Reset monthly total data
        _monthlyTotal.clear();

        // Calculate total net salary for each month
        rawData.forEach((entry) {
          String bulanTahun = entry['bulan_tahun'];
          double netSalary =
              double.tryParse(entry['jumlah_bersih'] ?? '0.0') ?? 0.0;

          if (_monthlyTotal.containsKey(bulanTahun)) {
            _monthlyTotal[bulanTahun] = _monthlyTotal[bulanTahun]! + netSalary;
          } else {
            _monthlyTotal[bulanTahun] = netSalary;
          }
        });

        setState(() {
          // Trigger UI update
        });
      } else {
        print('Failed to fetch data from API');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Report'),
        backgroundColor: Colors.green, // Mengubah warna AppBar menjadi hijau
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
                        color: Colors.grey), // Menambahkan garis tepi
                  ),
                  columns: [
                    DataColumn(label: Text('Bulan Tahun')),
                    DataColumn(label: Text('Total Net Salary')),
                  ],
                  rows: _monthlyTotal.entries.map((entry) {
                    return DataRow(
                      cells: [
                        DataCell(Text(entry.key)),
                        DataCell(Text('\$${entry.value.toStringAsFixed(2)}')),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
      drawer: AppDrawerAdmin(
        nama: '',
        role: '',
      ),
    );
  }
}
