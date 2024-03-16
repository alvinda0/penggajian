import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(SlipGajiDetail());

class SlipGajiDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slip Gaji Detail',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> _data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var url = Uri.parse('http://192.168.179.105/api/crud.php');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          _data = json.decode(response.body);
        });
      } else {
        print('Gagal mengambil data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Slip Gaji Detail',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 50, 97, 52),
      ),
      body: _data.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        Center(
                          child: Image.asset(
                            'assets/images/icon.png', // ganti dengan path logo perusahaan
                            width: 200, // sesuaikan ukuran logo
                            height: 100,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Jl.Jend. Gatot Subroto Kav.29 14th Floor, RT.4/RW.3, Kuningan, Kuningan Tim.,Kuningan, Jakarta,Daerah Khusus Ibukota Jakarta 12950',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: 400,
                          height: 2,
                          color: Colors.black, // warna garis pembatas
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Slip Gaji',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Periode - ',
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                _data[index]['bulan_tahun'] ??
                                    'Data Tidak Tersedia',
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Nama:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('NIP:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(
                                  'Jabatan:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Status:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(_data[index]['nama']),
                                Text(_data[index]['nip']),
                                Text(_data[index]['divisi']),
                                Text(_data[index]['status']),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'PENGHASILAN',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Gaji Pokok:',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  'Tj Jabatan:',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  'Tj Konsumsi:',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  'Tj Harian:',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  'Total Penghasilan:',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  _data[index]['gaji_pokok'],
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  _data[index]['tunjangan_jabatan'],
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  _data[index]['konsumsi'],
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  _data[index]['tunjangan_harian'],
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  _data[index]['total_pendapatan'],
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'POTONGAN:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'BPJS Kesehatan:',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  'JHT:',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  'Jaminan Pensiun:',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  'PPH 21:',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  'Total Deduction:',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  _data[index]['potongan_bpjs'],
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  _data[index]['jht'],
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  _data[index]['pensiun'],
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  _data[index]['pph21'],
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  _data[index]['total_potongan'],
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Jumlah Bersih ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                _data[index]['jumlah_bersih'] ??
                                    'Data Tidak Tersedia',
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mengetahui',
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Manager HRD',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        FadeInUp(
                            duration: Duration(milliseconds: 1600),
                            child: MaterialButton(
                              onPressed: () {},
                              height: 50,
                              color: Colors.green[900],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
