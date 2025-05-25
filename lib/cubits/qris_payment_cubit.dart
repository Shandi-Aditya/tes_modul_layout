import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/qris_payment_status.dart';

class QRISPaymentCubit extends Cubit<QRISPaymentState> {
  QRISPaymentCubit() : super(const QRISPaymentState());

  // Simulasi proses pembayaran
  Future<void> processPayment(String orderId, double amount) async {
    try {
      // Simulasi delay untuk proses pembayaran
      await Future.delayed(const Duration(seconds: 2));
      
      // Simulasi status pembayaran diproses
      emit(state.copyWith(
        status: QRISPaymentStatus.pembayaranDiproses,
        message: 'Pembayaran sedang diproses',
        timestamp: DateTime.now(),
      ));

      // Simulasi delay untuk konfirmasi pembayaran
      await Future.delayed(const Duration(seconds: 3));

      // Simulasi pembayaran berhasil (dalam implementasi nyata, 
      // ini akan bergantung pada callback dari payment gateway)
      emit(state.copyWith(
        status: QRISPaymentStatus.pembayaranBerhasil,
        message: 'Pembayaran berhasil',
        transactionId: 'TRX-${DateTime.now().millisecondsSinceEpoch}',
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: QRISPaymentStatus.pembayaranGagal,
        message: 'Pembayaran gagal: ${e.toString()}',
        timestamp: DateTime.now(),
      ));
    }
  }

  // Reset state pembayaran
  void resetPayment() {
    emit(const QRISPaymentState());
  }

  // Simulasi pembayaran kadaluarsa
  void expirePayment() {
    emit(state.copyWith(
      status: QRISPaymentStatus.pembayaranKadaluarsa,
      message: 'Pembayaran kadaluarsa',
      timestamp: DateTime.now(),
    ));
  }
} 