import 'package:flutter/material.dart';

class Payroll {
  final String userId;
  final String nama;
  final String bulanTahun;
  // Tambahkan atribut lainnya sesuai dengan kolom-kolom di tabel payroll

  Payroll({
    required this.userId,
    required this.nama,
    required this.bulanTahun,
    // Tambahkan atribut lainnya sesuai dengan kolom-kolom di tabel payroll
  });

  static fromJson(data) {}
}

class SlipGajiDetailPage extends StatelessWidget {
  final String userId;
  final List<Payroll> payrolls;

  SlipGajiDetailPage({required this.userId, required this.payrolls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Slip Gaji'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Data Payroll untuk User ID: $userId',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: payrolls.length,
              itemBuilder: (context, index) {
                var payroll = payrolls[index];
                return ListTile(
                  title: Text('Nama: ${payroll.nama}'),
                  subtitle: Text('Bulan Tahun: ${payroll.bulanTahun}'),
                  // Tampilkan atribut lainnya sesuai dengan kebutuhan
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
