import 'package:flutter/material.dart';

class MutasiScreen extends StatelessWidget {
  final List<Map<String, dynamic>> mutasi;
  const MutasiScreen({super.key, required this.mutasi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mutasi Rekening'),
        backgroundColor: const Color(0xFF1A237E),
        foregroundColor: Colors.white,
      ),
      body: mutasi.isEmpty
          ? const Center(child: Text('Belum ada mutasi transaksi'))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: mutasi.length,
              itemBuilder: (context, index) {
                final item = mutasi[index];
                final isMinus = (item['jumlah'] as num).toDouble() < 0;
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Icon(
                      isMinus ? Icons.arrow_upward : Icons.arrow_downward,
                      color: isMinus ? Colors.red : Colors.green,
                    ),
                    title: Text(item['keterangan'] ?? '-'),
                    subtitle: Text(item['tanggal'] ?? ''),
                    trailing: Text(
                      (isMinus ? '- ' : '+ ') + 'Rp ' + (item['jumlah'].abs()).toString(),
                      style: TextStyle(
                        color: isMinus ? Colors.red : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
} 