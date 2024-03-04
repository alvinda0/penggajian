import 'package:flutter/material.dart';
import 'package:penggajian/admin/datadivisi.dart';
import 'package:penggajian/login.dart';
import 'package:penggajian/admin/register.dart';
import 'package:penggajian/admin/tabel_karyawan.dart';

class AppDrawerAdmin extends StatelessWidget {
  final String nama;
  final String role;

  AppDrawerAdmin({required this.nama, required this.role});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("ADMIN $role"),
            accountEmail: Text("HRD"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/user_image.jpg"),
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 50, 97, 52),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Data Karyawan'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DataDivisi(
                          userId: null,
                          role: '',
                          dataKaryawan: [],
                        )),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.description_outlined,
            ),
            title: Text('Monthly Report'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MonthlyReport()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person_add,
            ),
            title: Text('Karyawan Baru'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Register()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Keluar'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Konfirmasi'),
                    content: Text('Apakah Anda yakin ingin keluar dari akun?'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Batal'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Keluar'),
                        onPressed: () {
                          // Kembali ke halaman login atau halaman sebelumnya (sesuai kebutuhan)
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
