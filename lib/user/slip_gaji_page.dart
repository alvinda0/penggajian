import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penggajian/user/drawer.dart';

class SlipGajiPage extends StatefulWidget {
  final String userId;

  SlipGajiPage({required this.userId, required String role});

  @override
  _SlipGajiPageState createState() => _SlipGajiPageState();
}

class _SlipGajiPageState extends State<SlipGajiPage> {
  List<dynamic> slipGajiList = [];

  @override
  void initState() {
    super.initState();
    fetchSlipGaji();
  }

  Future<void> fetchSlipGaji() async {
    final response = await http.get(
        Uri.parse('http://192.168.192.103/api/api.php?user_id=${widget.userId}'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final filteredSlipGaji = jsonData.where((slipGaji) => slipGaji['user_id'] == widget.userId).toList();

      setState(() {
        slipGajiList = filteredSlipGaji;
      });
    } else {
      throw Exception('Failed to load slip gaji');
    }
  }

  Future<void> updateData(dynamic slipGaji) async {
    final Map<String, dynamic> requestBody = {
      'id': slipGaji['id'],
      'email': slipGaji['email'],
      'phone': slipGaji['phone'],
    };

    final response = await http.put(
      Uri.parse('http://192.168.192.103/api/api.php'),
      body: json.encode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Data berhasil diperbarui');
      fetchSlipGaji(); // Ambil ulang data setelah berhasil diperbarui
      showSuccessSnackbar(context, 'Data berhasil diperbarui');
    } else {
      print('Gagal memperbarui data');
    }
  }

  void showSuccessSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Biodata - User ID: ${widget.userId}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 50, 97, 52),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: slipGajiList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: slipGajiList.length,
                itemBuilder: (context, index) {
                  final slipGaji = slipGajiList[index];
                  return InkWell(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          readOnly: true,
                          controller: TextEditingController(text: slipGaji['name']),
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Nama',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextField(
                          readOnly: true,
                          controller: TextEditingController(text: slipGaji['nip']),
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'NIP',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextField(
                          controller: TextEditingController(text: slipGaji['email']),
                          onChanged: (newValue) {
                            setState(() {
                              slipGaji['email'] = newValue;
                            });
                          },
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'EMAIL',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextField(
                          controller: TextEditingController(text: slipGaji['phone']),
                          onChanged: (newValue) {
                            setState(() {
                              slipGaji['phone'] = newValue;
                            });
                          },
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Phone',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 8.0),
                       
                      ],
                    ),
                  );
                },
              ),
      ),
      drawer: AppDrawer(
        userId: widget.userId, role: '',
      ),
    );
  }
}
