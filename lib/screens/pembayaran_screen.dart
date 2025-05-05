import 'package:flutter/material.dart';

typedef OnPay = void Function(double jumlah, String keterangan);

class PembayaranScreen extends StatefulWidget {
  final OnPay onPay;
  final double saldo;
  const PembayaranScreen({super.key, required this.onPay, required this.saldo});

  @override
  State<PembayaranScreen> createState() => _PembayaranScreenState();
}

class _PembayaranScreenState extends State<PembayaranScreen> {
  final TextEditingController nominalController = TextEditingController();
  final List<String> jenisPembayaran = [
    'Listrik',
    'Air',
    'Internet',
    'Pulsa',
    'BPJS',
    'TV Kabel',
    'PBB',
  ];
  String? selectedJenis;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
        backgroundColor: const Color(0xFF1A237E),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Form Pembayaran', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedJenis,
              items: jenisPembayaran
                  .map((jenis) => DropdownMenuItem(
                        value: jenis,
                        child: Text(jenis),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedJenis = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Jenis Pembayaran',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Pilih jenis pembayaran';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nominalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nominal',
                border: OutlineInputBorder(),
                prefixText: 'Rp ',
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final jumlah = double.tryParse(nominalController.text) ?? 0;
                  final ket = selectedJenis ?? '';
                  if (ket.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pilih jenis pembayaran!'), backgroundColor: Colors.red),
                    );
                    return;
                  }
                  if (jumlah > widget.saldo) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Saldo tidak mencukupi!'), backgroundColor: Colors.red),
                    );
                    return;
                  }
                  if (jumlah > 0) {
                    widget.onPay(jumlah, ket);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pembayaran berhasil!'), backgroundColor: Colors.green),
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A237E),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Bayar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 