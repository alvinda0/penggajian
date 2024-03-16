import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:penggajian/user/drawer.dart';

class Biodata extends StatefulWidget {
  final String userId;

  Biodata({required this.userId, required String role});

  @override
  _BiodataState createState() => _BiodataState();
}

class _BiodataState extends State<Biodata> {
  List<dynamic> biodataList = [];

  @override
  void initState() {
    super.initState();
    fetchBiodata();
  }

  Future<void> fetchBiodata() async {
    final response = await http.get(Uri.parse(
        'http://192.168.116.105/api/crud.php?user_id=${widget.userId}'));

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
          'Slip Gaji - User ID: ${widget.userId}', // Tambahkan User ID di AppBar
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
                itemCount: biodataList.length,
                itemBuilder: (context, index) {
                  final biodata = biodataList[index];
                  return InkWell(
                    onTap: () {
                      // Panggil fungsi untuk navigasi ke halaman detail saat item diklik
                      _navigateToDetail(biodata);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          color: Colors
                              .green, // Atur warna latar belakang card menjadi hijau
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/uang.png', // Ganti dengan path gambar Anda
                                  width: 100.0, // Atur lebar gambar
                                  height: 100.0, // Atur tinggi gambar
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
                                      'Tanggal: ${biodata['bulan_tahun']}',
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

class DetailData extends StatelessWidget {
  final dynamic biodata;

  DetailData({required this.biodata});

  Future<Uint8List> generatePdf() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Center(
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text(
                'PT.ANDALAN K3 ',
                style: pw.TextStyle(fontSize: 20),
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                'Bukit Mampang Residence Blok KI No.5 ',
                style: pw.TextStyle(fontSize: 10),
              ),
              pw.Text(
                'Jl.Cemara, Grogol Limo - Depok',
                style: pw.TextStyle(fontSize: 10),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                '================================',
                style: pw.TextStyle(fontSize: 18),
              ),
              pw.Text(
                'Slip Gaji',
                style: pw.TextStyle(fontSize: 18),
              ),
              pw.Text(
                'Periode: ${biodata['bulan_tahun']}',
                style: pw.TextStyle(fontSize: 18),
              ),
              pw.SizedBox(height: 8),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'PENGHASILAN',
                          style: pw.TextStyle(fontSize: 15),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text(
                          'Gaji Pokok: ${biodata['gaji_pokok']}',
                          style: pw.TextStyle(fontSize: 10),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text(
                          'Tj Jabatan: ${biodata['tunjangan_jabatan']}',
                          style: pw.TextStyle(fontSize: 10),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text(
                          'Tj Konsumsi: ${biodata['konsumsi']}',
                          style: pw.TextStyle(fontSize: 10),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text(
                          'Tj Harian: ${biodata['tunjangan_harian']}',
                          style: pw.TextStyle(fontSize: 10),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text(
                          'Total Penghasilan: ${biodata['total_penghasilan']}',
                          style: pw.TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'POTONGAN',
                          style: pw.TextStyle(fontSize: 15),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text(
                          'BPJS Kesehatan: ${biodata['potongan_bpjs']}',
                          style: pw.TextStyle(fontSize: 10),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text(
                          'JHT: ${biodata['jht']}',
                          style: pw.TextStyle(fontSize: 10),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text(
                          'Jaminan Pensiun: ${biodata['pensiun']}',
                          style: pw.TextStyle(fontSize: 10),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text(
                          'PPH21: ${biodata['pph21']}',
                          style: pw.TextStyle(fontSize: 10),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text(
                          'Total Deduction: ${biodata['jumlah_bersih']}',
                          style: pw.TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Penerima Bersih: ${biodata['jumlah_bersih']}',
                style: pw.TextStyle(fontSize: 12),
              ),
              pw.SizedBox(height: 30),
              pw.Text(
                'Mengetahui ',
                style: pw.TextStyle(fontSize: 12),
              ),
              pw.SizedBox(height: 60),
              pw.Text(
                'Manager HRD',
                style: pw.TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
    return pdf.save();
  }

  Future<void> saveAndLaunchPdf() async {
    final pdfBytes = await generatePdf();
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/biodata.pdf');
    await file.writeAsBytes(pdfBytes);
    await OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Data ', // Tambahkan User ID di AppBar
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 50, 97, 52),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/icon.png', // Ganti dengan path gambar Anda
              width: 150.0, // Atur lebar gambar
              height: 100.0, // Atur tinggi gambar
            ),
            Text(
              'Bukit Mampang Residence Blok KI No.5 ',
              style: TextStyle(
                fontSize: 10.0,
              ),
            ),
            Text(
              'Jl. Cemara, Grogol Limo - Depok',
              style: TextStyle(
                fontSize: 10.0,
              ),
            ),
            Text(
              '================================',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            Text(
              'Slip Gaji',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            Text(
              'Periode: ${biodata['bulan_tahun']}',
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PENGHASILAN',
                      style: TextStyle(fontSize: 15.0, color: Colors.black),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Gaji Pokok: ${biodata['gaji_pokok']}',
                      style: TextStyle(fontSize: 10.0, color: Colors.black),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Tj Jabatan: ${biodata['tunjangan_jabatan']}',
                      style: TextStyle(fontSize: 10.0, color: Colors.black),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Tj Konsumsi: ${biodata['konsumsi']}',
                      style: TextStyle(fontSize: 10.0, color: Colors.black),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Tj Harian: ${biodata['tunjangan_harian']}',
                      style: TextStyle(fontSize: 10.0, color: Colors.black),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Total Penghasilan: ${biodata['total_pendapatan']}',
                      style: TextStyle(fontSize: 10.0, color: Colors.black),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'POTONGAN',
                      style: TextStyle(fontSize: 15.0, color: Colors.black),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'BPJS Kesehatan: ${biodata['potongan_bpjs']}',
                      style: TextStyle(fontSize: 10.0, color: Colors.black),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'JHT: ${biodata['jht']}',
                      style: TextStyle(fontSize: 10.0, color: Colors.black),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Jaminan Pensiun: ${biodata['pensiun']}',
                      style: TextStyle(fontSize: 10.0, color: Colors.black),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'PPH21: ${biodata['pph21']}',
                      style: TextStyle(fontSize: 10.0, color: Colors.black),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Total Deduction: ${biodata['jumlah_bersih']}',
                      style: TextStyle(fontSize: 10.0, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              'Penerima Bersih: ${biodata['jumlah_bersih']}',
              style: TextStyle(fontSize: 12.0, color: Colors.black),
            ),
            SizedBox(height: 30.0),
            Text(
              'Mengetahui ',
              style: TextStyle(fontSize: 12.0, color: Colors.black),
            ),
            SizedBox(height: 60.0),
            Text(
              'Manager HRD',
              style: TextStyle(fontSize: 12.0, color: Colors.black),
            ),
            SizedBox(height: 30.0),
            Card(
              color: Colors.green, // Warna latar belakang hijau

              child: InkWell(
                onTap: () async {
                  await saveAndLaunchPdf();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Download PDF',
                    style: TextStyle(color: Colors.white), // Warna teks putih
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
