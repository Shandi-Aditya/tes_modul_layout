import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/qris_payment_cubit.dart';
import '../models/qris_payment_status.dart';

class QRISPaymentScreen extends StatefulWidget {
  final double amount;
  final String orderId;

  const QRISPaymentScreen({
    Key? key,
    required this.amount,
    required this.orderId,
  }) : super(key: key);

  @override
  State<QRISPaymentScreen> createState() => _QRISPaymentScreenState();
}

class _QRISPaymentScreenState extends State<QRISPaymentScreen> {
  @override
  void initState() {
    super.initState();
    // Mulai proses pembayaran saat screen dibuka
    context.read<QRISPaymentCubit>().processPayment(widget.orderId, widget.amount);
  }

  // Format QRIS string (ini hanya contoh, sesuaikan dengan format QRIS yang sebenarnya)
  String get qrisString => '00020101021226630016COM.MERCHANT.WWW01189360001234567890215COM.MERCHANT.WWW0303UMI51440014ID.CO.QRIS.WWW01189360001234567890215COM.MERCHANT.WWW0303UMI520459995802ID5913MERCHANT NAME6007JAKARTA61051234562070703A016304';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pembayaran QRIS',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<QRISPaymentCubit, QRISPaymentState>(
        listener: (context, state) {
          if (state.status == QRISPaymentStatus.pembayaranBerhasil) {
            _showSuccessDialog();
          } else if (state.status == QRISPaymentStatus.pembayaranGagal) {
            _showErrorDialog(state.message ?? 'Pembayaran gagal');
          } else if (state.status == QRISPaymentStatus.pembayaranKadaluarsa) {
            _showErrorDialog('Pembayaran kadaluarsa');
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  // QR Code
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        QrImageView(
                          data: qrisString,
                          version: QrVersions.auto,
                          size: 250.0,
                          backgroundColor: Colors.white,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Scan QR Code untuk pembayaran',
                          style: GoogleFonts.poppins(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Informasi Pembayaran
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Informasi Pembayaran',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildInfoRow('ID Pesanan', widget.orderId),
                        const Divider(),
                        _buildInfoRow('Total Pembayaran', 
                          'Rp ${widget.amount.toStringAsFixed(0)}'),
                        const Divider(),
                        _buildInfoRow('Status', state.statusText),
                        if (state.transactionId != null) ...[
                          const Divider(),
                          _buildInfoRow('ID Transaksi', state.transactionId!),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Petunjuk Pembayaran
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Petunjuk Pembayaran:',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildInstructionStep(
                          '1. Buka aplikasi e-wallet atau mobile banking Anda',
                        ),
                        _buildInstructionStep(
                          '2. Pilih menu "Scan QR" atau "Bayar dengan QRIS"',
                        ),
                        _buildInstructionStep(
                          '3. Scan QR Code yang ditampilkan di atas',
                        ),
                        _buildInstructionStep(
                          '4. Periksa detail pembayaran dan konfirmasi',
                        ),
                        _buildInstructionStep(
                          '5. Pembayaran selesai',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          'Pembayaran Berhasil',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Pembayaran Anda telah berhasil diproses.',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Tutup dialog
              Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
            },
            child: Text(
              'OK',
              style: GoogleFonts.poppins(
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Pembayaran Gagal',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.red,
          ),
        ),
        content: Text(
          message,
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Tutup dialog
              context.read<QRISPaymentCubit>().resetPayment(); // Reset state
            },
            child: Text(
              'Coba Lagi',
              style: GoogleFonts.poppins(
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionStep(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: GoogleFonts.poppins(
              color: Colors.blue.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                color: Colors.blue.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 