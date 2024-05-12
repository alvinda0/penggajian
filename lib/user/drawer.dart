import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penggajian/user/biodata.dart';
import 'package:penggajian/login.dart';
import 'package:penggajian/user/slip_gaji_page.dart';

class AppDrawer extends StatelessWidget {
  final String userId;
  final String role;

  AppDrawer({required this.userId, required this.role});

  Future<List<dynamic>> fetchUserInfo(String userId) async {
    final response = await http.get(
      Uri.parse('http://192.168.192.103/api/crud.php?user_id=$userId'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load user info');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          FutureBuilder<List<dynamic>>(
            future: fetchUserInfo(userId),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                var userInfo = snapshot.data![0]; // Ambil data pertama dari daftar
                return UserAccountsDrawerHeader(
                  accountName: Text(userInfo['nama']),
                  accountEmail: Text(userInfo['nip']),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/user.jfif"),
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 50, 97, 52),
                  ),
                );
              }
            },
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
                    role: role,
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
