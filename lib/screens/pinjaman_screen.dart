import 'package:flutter/material.dart';

typedef OnPinjam = void Function(double jumlah, String lama);

class PinjamanScreen extends StatelessWidget {
  final OnPinjam onPinjam;
  const PinjamanScreen({super.key, required this.onPinjam});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nominalController = TextEditingController();
    final TextEditingController lamaController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pinjaman'),
        backgroundColor: const Color(0xFF1A237E),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Form Pinjaman', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: nominalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nominal Pinjaman',
                border: OutlineInputBorder(),
                prefixText: 'Rp ',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: lamaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Lama Pinjaman (bulan)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final jumlah = double.tryParse(nominalController.text) ?? 0;
                  final lama = lamaController.text;
                  if (jumlah > 0) {
                    onPinjam(jumlah, lama);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pengajuan pinjaman berhasil!'), backgroundColor: Colors.green),
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A237E),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Ajukan Pinjaman'),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 