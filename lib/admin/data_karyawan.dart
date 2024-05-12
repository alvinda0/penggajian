import 'package:flutter/material.dart';
import 'package:penggajian/admin/drawer_admin.dart';

class DataKaryawanDetail extends StatelessWidget {
  final List<Map<String, dynamic>> dataKaryawan;

  const DataKaryawanDetail({
    Key? key,
    required this.dataKaryawan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Karyawan Detail',
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
                return ListTile(
                  title: Text('User ID: ${karyawan['user_id']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nama: ${karyawan['nama']}'),
                      Text('Divisi: ${karyawan['divisi']}'),
                      // Tambahkan informasi lainnya di sini
                    ],
                  ),
                  onTap: () {
                    // Tambahkan logika navigasi atau tindakan lainnya di sini
                  },
                );
              },
            ),
      drawer: AppDrawerAdmin(
        nama: '',
        role: '',
        userId: '',
      ),
    );
  }
}
