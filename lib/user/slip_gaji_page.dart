import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penggajian/user/biodata.dart';
import 'package:penggajian/user/drawer.dart';

class SlipGajiPage extends StatefulWidget {
  final String userId;

  SlipGajiPage({required this.userId, required String role});

  @override
  _BiodataState createState() => _BiodataState();
}

class _BiodataState extends State<SlipGajiPage> {
  List<dynamic> biodataList = [];

  @override
  void initState() {
    super.initState();
    fetchBiodata();
  }

  Future<void> fetchBiodata() async {
    final response = await http.get(Uri.parse(
        'http://192.168.43.105/api/crud.php?user_id=${widget.userId}'));

    if (response.statusCode == 200) {
      setState(() {
        biodataList = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load biodata');
    }
  }

  void _navigateToDetail(dynamic biodata) {
    // Navigasi ke halaman detail dengan membawa data biodata yang dipilih
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailData(biodata: biodata)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Biodata - User ID: ${widget.userId}', // Tambahkan User ID di AppBar
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 50, 97, 52),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: biodataList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: 1, // Menampilkan hanya satu item
                itemBuilder: (context, index) {
                  final biodata = biodataList[index];
                  return InkWell(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          color: Colors.green,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person, // Menggunakan ikon person
                                  size: 100.0,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 16.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Nama: ${biodata['nama']}',
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.white),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      'NIP: ${biodata['nip']}',
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.white),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      'Divisi: ${biodata['divisi']}',
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
      drawer: AppDrawer(
        userId: widget.userId,
        role: '',
      ),
    );
  }
}
