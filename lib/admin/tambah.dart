import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(TambahDataKaryawanPage());
}

class TambahDataKaryawanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tambah Data Karyawan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TambahDataKaryawan(),
    );
  }
}

class TambahDataKaryawan extends StatefulWidget {
  @override
  _TambahDataKaryawanState createState() => _TambahDataKaryawanState();
}

class _TambahDataKaryawanState extends State<TambahDataKaryawan> {
  TextEditingController _bulanTahunController = TextEditingController();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _nipController = TextEditingController();
  TextEditingController _jabatanController = TextEditingController();
  TextEditingController _statusController = TextEditingController();
  TextEditingController _gajiPokokController = TextEditingController();
  TextEditingController _tunjanganJabatanController = TextEditingController();
  TextEditingController _konsumsiController = TextEditingController();
  TextEditingController _tunjanganHarianController = TextEditingController();
  TextEditingController _potonganBpjsController = TextEditingController();
  TextEditingController _jhtController = TextEditingController();
  TextEditingController _pensiunController = TextEditingController();
  TextEditingController _pph21Controller = TextEditingController();
  TextEditingController _totalPendapatanController = TextEditingController();
  TextEditingController _totalPotonganController = TextEditingController();
  TextEditingController _jumlahBersihController = TextEditingController();
  TextEditingController _divisiController = TextEditingController();
  TextEditingController _userIdController = TextEditingController();

  Future<void> _tambahData() async {
    String apiUrl = 'http://192.168.43.105/api/tambah.php';
    Map<String, dynamic> data = {
      'bulan_tahun': _bulanTahunController.text,
      'nama': _namaController.text,
      'nip': _nipController.text,
      'jabatan': _jabatanController.text,
      'status': _statusController.text,
      'gaji_pokok': _gajiPokokController.text,
      'tunjangan_jabatan': _tunjanganJabatanController.text,
      'konsumsi': _konsumsiController.text,
      'tunjangan_harian': _tunjanganHarianController.text,
      'potongan_bpjs': _potonganBpjsController.text,
      'jht': _jhtController.text,
      'pensiun': _pensiunController.text,
      'pph21': _pph21Controller.text,
      'total_pendapatan': _totalPendapatanController.text,
      'total_potongan': _totalPotonganController.text,
      'jumlah_bersih': _jumlahBersihController.text,
      'divisi': _divisiController.text,
      'user_id': _userIdController.text,
    };

    try {
      var response =
          await http.post(Uri.parse(apiUrl), body: json.encode(data));
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Sukses'),
                content: Text(responseData['message']),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text(responseData['message']),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        throw Exception('Gagal terhubung ke server');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Data Karyawan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: _bulanTahunController,
              decoration: InputDecoration(labelText: 'Bulan Tahun (YYYY-MM)'),
            ),
            TextField(
              controller: _namaController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: _nipController,
              decoration: InputDecoration(labelText: 'NIP'),
            ),
            TextField(
              controller: _jabatanController,
              decoration: InputDecoration(labelText: 'Jabatan'),
            ),
            TextField(
              controller: _statusController,
              decoration: InputDecoration(labelText: 'Status'),
            ),
            TextField(
              controller: _gajiPokokController,
              decoration: InputDecoration(labelText: 'Gaji Pokok'),
            ),
            TextField(
              controller: _tunjanganJabatanController,
              decoration: InputDecoration(labelText: 'Tunjangan Jabatan'),
            ),
            TextField(
              controller: _konsumsiController,
              decoration: InputDecoration(labelText: 'Konsumsi'),
            ),
            TextField(
              controller: _tunjanganHarianController,
              decoration: InputDecoration(labelText: 'Tunjangan Harian'),
            ),
            TextField(
              controller: _potonganBpjsController,
              decoration: InputDecoration(labelText: 'Potongan BPJS'),
            ),
            TextField(
              controller: _jhtController,
              decoration: InputDecoration(labelText: 'JHT'),
            ),
            TextField(
              controller: _pensiunController,
              decoration: InputDecoration(labelText: 'Pensiun'),
            ),
            TextField(
              controller: _pph21Controller,
              decoration: InputDecoration(labelText: 'PPH21'),
            ),
            TextField(
              controller: _totalPendapatanController,
              decoration: InputDecoration(labelText: 'Total Pendapatan'),
            ),
            TextField(
              controller: _totalPotonganController,
              decoration: InputDecoration(labelText: 'Total Potongan'),
            ),
            TextField(
              controller: _jumlahBersihController,
              decoration: InputDecoration(labelText: 'Jumlah Bersih'),
            ),
            TextField(
              controller: _divisiController,
              decoration: InputDecoration(labelText: 'Divisi'),
            ),
            TextField(
              controller: _userIdController,
              decoration: InputDecoration(labelText: 'User ID'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _tambahData();
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
