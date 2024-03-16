import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:penggajian/admin/data_karyawan_detail.dart';
import 'package:penggajian/admin/drawer_admin.dart';

class DataDivisi extends StatefulWidget {
  const DataDivisi(
      {Key? key,
      required userId,
      required String role,
      required List dataKaryawan})
      : super(key: key);

  @override
  State<DataDivisi> createState() => _DataDivisiState();
}

class _DataDivisiState extends State<DataDivisi> {
  Map<String, Set<String>> _dataDivisi = {};
  bool _isLoading = true;

  Future<void> _getData() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.116.105/api/crud.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        for (var item in data) {
          String divisi = item['divisi'];
          String userId = item['user_id'];

          // Tambahkan user_id ke set divisi yang sesuai
          _dataDivisi.putIfAbsent(divisi, () => {});
          _dataDivisi[divisi]!.add(userId);
        }
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Divisi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 50, 97, 52),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _dataDivisi.isEmpty
              ? Center(
                  child: Text('Tidak ada data'),
                )
              : ListView.builder(
                  itemCount: _dataDivisi.length,
                  itemBuilder: (context, index) {
                    String divisi = _dataDivisi.keys.toList()[index];
                    int jumlahKaryawan = _dataDivisi[divisi]!.length;
                    return GestureDetector(
                      onTap: () {
                        Set<String>? dataKaryawan = _dataDivisi[divisi];
                        if (dataKaryawan != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DataKaryawanDetail(
                                dataKaryawan: dataKaryawan
                                    .map((e) => {'user_id': e})
                                    .toList(),
                                userId: null,
                                role: '',
                                karyawan: {},
                              ),
                            ),
                          );
                        }
                      },
                      child: Card(
                        color: Colors.green,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: Image.asset(
                                  'assets/images/karyawan.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 50),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Divisi: $divisi',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white)),
                                    Text('Jumlah Karyawan: $jumlahKaryawan',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
      drawer: AppDrawerAdmin(
        nama: '',
        role: '',
      ),
    );
  }
}
