import 'package:flutter/material.dart';
import 'package:penggajian/admin/drawer_admin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataKaryawanDetail extends StatefulWidget {
  final List<Map<String, dynamic>> dataKaryawan;

  const DataKaryawanDetail({
    Key? key,
    required this.dataKaryawan,
    required userId,
    required String role,
    required Map karyawan,
  }) : super(key: key);

  @override
  _DataKaryawanDetailState createState() => _DataKaryawanDetailState();
}

class _DataKaryawanDetailState extends State<DataKaryawanDetail> {
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
      body: ListView.builder(
        itemCount: widget.dataKaryawan.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> karyawan = widget.dataKaryawan[index];
          final userId = karyawan['user_id'];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailKaryawan(userId: userId),
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
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User ID: ${karyawan['user_id']}',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          Text(
                            'Nama: ${karyawan['nama']}',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
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

class DetailKaryawan extends StatefulWidget {
  final String userId;

  const DetailKaryawan({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  _DetailKaryawanState createState() => _DetailKaryawanState();
}

class _DetailKaryawanState extends State<DetailKaryawan> {
  Map<String, dynamic> karyawan = {};

  @override
  void initState() {
    super.initState();
    _getKaryawanDetail();
  }

  Future<void> _getKaryawanDetail() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.116.105/api/crud.php?user_id=${widget.userId}'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          setState(() {
            karyawan = data.first;
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Karyawan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 50, 97, 52),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigasi ke halaman tambah karyawan dengan meneruskan userId
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TambahDataKaryawan(
                    userId: widget.userId,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: karyawan.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                Card(
                  child: ListTile(
                    title: Text(
                      'Nama: ${karyawan['nama']}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    subtitle: Text(
                      'Divisi: ${karyawan['divisi']}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
                // Tambahkan informasi lainnya sesuai kebutuhan
              ],
            ),
    );
  }
}

class TambahDataKaryawan extends StatefulWidget {
  final String userId;

  const TambahDataKaryawan({Key? key, required this.userId}) : super(key: key);

  @override
  _TambahDataKaryawanState createState() => _TambahDataKaryawanState();
}

class _TambahDataKaryawanState extends State<TambahDataKaryawan> {
  TextEditingController hariKerjaController = TextEditingController();
  TextEditingController izinAlfaController = TextEditingController();
  TextEditingController izinCutiController = TextEditingController();
  TextEditingController izinSakitController = TextEditingController();
  TextEditingController lemburController = TextEditingController();
  TextEditingController gajiPokokController = TextEditingController();

  final TextEditingController _bulanTahunController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nipController = TextEditingController();
  final TextEditingController _jabatanController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _gajiPokokController = TextEditingController();
  final TextEditingController _tunjanganJabatanController =
      TextEditingController();
  final TextEditingController _konsumsiController = TextEditingController();
  final TextEditingController _tunjanganHarianController =
      TextEditingController();
  final TextEditingController _potonganBpjsController = TextEditingController();
  final TextEditingController _jhtController = TextEditingController();
  final TextEditingController _pensiunController = TextEditingController();
  final TextEditingController _pph21Controller = TextEditingController();
  final TextEditingController _totalPendapatanController =
      TextEditingController();
  final TextEditingController _totalPotonganController =
      TextEditingController();
  final TextEditingController _jumlahBersihController = TextEditingController();
  final TextEditingController _divisiController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();

  double gaji = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Tambah Data Karyawan'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: hariKerjaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Hari Kerja'),
            ),
            TextField(
              controller: izinAlfaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Izin Alfa'),
            ),
            TextField(
              controller: izinCutiController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Izin Cuti'),
            ),
            TextField(
              controller: izinSakitController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Izin Sakit'),
            ),
            TextField(
              controller: lemburController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Lembur (jam)'),
            ),
            TextField(
              controller: _gajiPokokController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Gaji Pokok'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  gaji = calculateSalary(
                    hariKerjaController.text,
                    izinAlfaController.text,
                    izinCutiController.text,
                    izinSakitController.text,
                    lemburController.text,
                    _gajiPokokController.text,
                  );
                  // Menghitung total pendapatan
                  double tunjanganJabatan =
                      double.parse(_tunjanganJabatanController.text);
                  double tunjanganHarian =
                      double.parse(_tunjanganHarianController.text);
                  double konsumsi = double.parse(_konsumsiController.text);
                  double totalPendapatan =
                      gaji + tunjanganJabatan + tunjanganHarian + konsumsi;
                  _totalPendapatanController.text =
                      totalPendapatan.toStringAsFixed(2);

                  // Menghitung total potongan
                  double potonganBpjs =
                      double.parse(_potonganBpjsController.text);
                  double jht = double.parse(_jhtController.text);
                  double pensiun = double.parse(_pensiunController.text);
                  double pph21 = double.parse(_pph21Controller.text);
                  double totalPotongan = potonganBpjs + jht + pensiun + pph21;
                  _totalPotonganController.text =
                      totalPotongan.toStringAsFixed(2);

                  // Menghitung jumlah bersih
                  double jumlahBersih = totalPendapatan - totalPotongan;
                  _jumlahBersihController.text =
                      jumlahBersih.toStringAsFixed(2);
                });
              },
              child: Text('Hitung Gaji'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: TextEditingController(text: gaji.toStringAsFixed(2)),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Gaji Pokok'),
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: _bulanTahunController,
              decoration: InputDecoration(labelText: 'Bulan Tahun'),
            ),
            TextField(
              controller: _namaController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: _nipController,
              keyboardType: TextInputType.number,
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
              controller: _tunjanganJabatanController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Tunjangan Jabatan'),
            ),
            TextField(
              controller: _konsumsiController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Konsumsi'),
            ),
            TextField(
              controller: _tunjanganHarianController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Tunjangan Harian'),
            ),
            TextField(
              controller: _potonganBpjsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Potongan BPJS'),
            ),
            TextField(
              controller: _jhtController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'JHT'),
            ),
            TextField(
              controller: _pensiunController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Pensiun'),
            ),
            TextField(
              controller: _pph21Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'PPH21'),
            ),
            TextField(
              controller: _totalPendapatanController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Total Pendapatan'),
            ),
            TextField(
              controller: _totalPotonganController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Total Potongan'),
            ),
            TextField(
              controller: _jumlahBersihController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Jumlah Bersih'),
            ),
            TextField(
              controller: _divisiController,
              decoration: InputDecoration(labelText: 'Divisi'),
            ),
            TextField(
              controller: _userIdController,
              decoration: InputDecoration(labelText: 'user_id'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            _tambahData();
          },
          child: Text('Simpan'),
        ),
      ],
    );
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.116.105/api/crud.php?user_id=${widget.userId}'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          final karyawan = data[0];
          _bulanTahunController.text = karyawan['bulan_tahun'];
          _namaController.text = karyawan['nama'];
          _nipController.text = karyawan['nip'];
          _jabatanController.text = karyawan['jabatan'];
          _statusController.text = karyawan['status'];
          // Gaji pokok disimpan sebagai string
          _gajiPokokController.text = karyawan['gaji_pokok'];
          _tunjanganJabatanController.text = karyawan['tunjangan_jabatan'];
          _konsumsiController.text = karyawan['konsumsi'];
          _tunjanganHarianController.text = karyawan['tunjangan_harian'];
          _potonganBpjsController.text = karyawan['potongan_bpjs'];
          _jhtController.text = karyawan['jht'];
          _pensiunController.text = karyawan['pensiun'];
          _pph21Controller.text = karyawan['pph21'];
          _totalPendapatanController.text = karyawan['total_pendapatan'];
          _totalPotonganController.text = karyawan['total_potongan'];
          _jumlahBersihController.text = karyawan['jumlah_bersih'];
          _divisiController.text = karyawan['divisi'];
          _userIdController.text = karyawan['user_id'];
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _tambahData() async {
    String apiUrl = 'http://192.168.116.105/api/tambah.php';
    Map<String, dynamic> data = {
      'bulan_tahun': _bulanTahunController.text,
      'nama': _namaController.text,
      'nip': _nipController.text,
      'jabatan': _jabatanController.text,
      'status': _statusController.text,
      // Gaji pokok dikirim sebagai string
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
}

double calculateSalary(
    String hariKerjaStr,
    String izinAlfaStr,
    String izinCutiStr,
    String izinSakitStr,
    String lemburStr,
    String gajiPokokStr) {
  try {
    int hariKerja = int.parse(hariKerjaStr);
    int izinAlfa = int.parse(izinAlfaStr);
    int izinCuti = int.parse(izinCutiStr);
    int izinSakit = int.parse(izinSakitStr);
    int lembur = int.parse(lemburStr);
    double gajiPokok = double.parse(gajiPokokStr);

    var potonganAlfa = izinAlfa * 150000;
    var potonganSakit = izinSakit * 50000;
    var bonusLembur =
        lembur * 40000; // asumsi bonus lembur adalah 40000 per jam

    var gaji = gajiPokok - potonganAlfa - potonganSakit + bonusLembur;

    return gaji;
  } catch (e) {
    // Penanganan kesalahan jika input tidak valid
    print('Error: $e');
    return 0;
  }
}
