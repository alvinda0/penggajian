import 'package:flutter/material.dart';
import 'package:penggajian/admin/data_karyawan_detail.dart';
import 'package:penggajian/admin/drawer_admin.dart';

class DataKaryawan extends StatelessWidget {
  final List<Map<String, dynamic>> dataKaryawan;

  const DataKaryawan(
      {Key? key,
      required this.dataKaryawan,
      required userId,
      required String role})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Karyawan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 50, 97, 52),
      ),
      body: dataKaryawan.isEmpty
          ? Center(
              child: Text('Tidak ada data'),
            )
          : ListView.builder(
              itemCount: dataKaryawan.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> karyawan = dataKaryawan[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DataKaryawanDetail(
                          dataKaryawan: dataKaryawan,
                          userId: null,
                          role: '',
                          karyawan: {},
                        ),
                      ),
                    );
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
                            child: Icon(
                              Icons.person,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 50),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(karyawan['nama'],
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white)),
                                Text(karyawan['divisi'],
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
