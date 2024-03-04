import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penggajian/user/Slip_Gaji_Detail.dart';
import 'package:penggajian/user/drawer.dart';

class SlipGaji extends StatefulWidget {
  const SlipGaji({Key? key}) : super(key: key);

  @override
  State<SlipGaji> createState() => _DataKaryawanState();
}

class _DataKaryawanState extends State<SlipGaji> {
  List _listdata = [];
  bool _isloading = true;

  Future<void> _getdata() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.43.105/api/crud.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data;
          _isloading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Slip Gaji',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 50, 97, 52),
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _listdata.isEmpty
              ? Center(
                  child: Text('Tidak ada data'),
                )
              : ListView.builder(
                  itemCount: _listdata.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SlipGajiDetail()), // Navigasi ke halaman EkSlipGajiDetail.dart
                        );
                      },
                      child: Card(
                        color: Color.fromARGB(255, 50, 97, 52),
                        child: ListTile(
                          leading:
                              Icon(Icons.person, size: 70, color: Colors.white),
                          title: Text(
                            _listdata[index]['bulan_tahun'],
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            _listdata[index]['divisi'],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
      drawer: AppDrawer(
        userId: '',
        role: '',
      ),
    );
  }
}
