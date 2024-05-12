import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class AnotherDetailPage extends StatelessWidget {
  final Map<String, dynamic> detailData;

  AnotherDetailPage({required this.detailData});

  Future<void> saveAndLaunchPdf() async {
    final pdfBytes = await generatePdf();
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/Faktur_Gaji.pdf');
    await OpenFile.open(file.path);
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Faktur Gaji ${detailData['nama']}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
                        Center(
                          child: Image.asset(
                            'assets/images/icon.png', // ganti dengan path logo perusahaan
                            width: 200, // sesuaikan ukuran logo
                            height: 100,
                          ),
                        ),
                                    SizedBox(height:10),

                        Text(
                          'Bukit Mampang Residence Blok KI No.5-6 Jl.Cemara',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5),
                        Text(
                          ' Kel.Grogol kec.Limo, Kota Depok',
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
                          'Faktur Gaji',
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
                                ' ${detailData['bulan_tahun']}',
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
                                Text(' ${detailData['nama']}'),
                                Text(' ${detailData['nip']}'),
                                Text(' ${detailData['divisi']}'),
                                Text(' ${detailData['status']}'),
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
                                  ' ${detailData['gaji_pokok']}',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  ' ${detailData['tunjangan_jabatan']}',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  ' ${detailData['konsumsi']}',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  ' ${detailData['tunjangan_harian']}',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  ' ${detailData['total_pendapatan']}',
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
                                  ' ${detailData['potongan_bpjs']}',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  ' ${detailData['jht']}',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  ' ${detailData['pensiun']}',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  ' ${detailData['pph21']}',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  ' ${detailData['total_potongan']}',
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
                                'Penerima bersih: ${detailData['jumlah_bersih']}',
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
           

            // Tambahkan informasi lainnya sesuai kebutuhan
          ],
        ),
      ),
    );
  }
  
  generatePdf() {}
}
