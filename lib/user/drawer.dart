// File: drawer.dart

import 'package:flutter/material.dart';
import 'package:penggajian/user/biodata.dart';
import 'package:penggajian/login.dart';
import 'package:penggajian/user/slip_gaji_page.dart';

class AppDrawer extends StatelessWidget {
  final String userId;
  final String role;

  AppDrawer({required this.userId, required this.role});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Nama Pengguna"),
            accountEmail: Text("NIP"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/user_image.jpg"),
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 50, 97, 52),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Slip gaji'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Biodata(
                    userId: userId,
                    role: role,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.receipt),
            title: Text('Biodata'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SlipGajiPage(
                    userId: userId,
                    role:
                        role, // Memperbaiki inisialisasi SlipGajiPage dengan parameter role
                  ),
                ),
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
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
