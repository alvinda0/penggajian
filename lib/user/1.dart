import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hitung Gaji Karyawan'),
        ),
        body: HitungGajiForm(),
      ),
    );
  }
}

class HitungGajiForm extends StatefulWidget {
  @override
  _HitungGajiFormState createState() => _HitungGajiFormState();
}

class _HitungGajiFormState extends State<HitungGajiForm> {
  TextEditingController hariKerjaController = TextEditingController();
  TextEditingController izinAlfaController = TextEditingController();
  TextEditingController izinCutiController = TextEditingController();
  TextEditingController izinSakitController = TextEditingController();
  TextEditingController lemburController = TextEditingController();
  TextEditingController gajiPokokController = TextEditingController();

  double gaji = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
            controller: gajiPokokController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Gaji Pokok'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                gaji = calculateSalary(
                  int.parse(hariKerjaController.text),
                  int.parse(izinAlfaController.text),
                  int.parse(izinCutiController.text),
                  int.parse(izinSakitController.text),
                  int.parse(lemburController.text),
                  double.parse(gajiPokokController.text),
                );
              });
            },
            child: Text('Hitung Gaji'),
          ),
          SizedBox(height: 20),
          Text(
            'Gaji Karyawan: ${gaji.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

double calculateSalary(int hariKerja, int izinAlfa, int izinCuti, int izinSakit,
    int lembur, double gajiPokok) {
  var potonganAlfa = izinAlfa * 150000;
  var potonganSakit = izinSakit * 50000;
  var bonusLembur = lembur * 40000; // asumsi bonus lembur adalah 40000 per jam

  var gaji = gajiPokok - potonganAlfa - potonganSakit + bonusLembur;

  return gaji;
}
