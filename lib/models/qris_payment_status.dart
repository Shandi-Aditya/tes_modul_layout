import 'package:equatable/equatable.dart';

enum QRISPaymentStatus {
  menungguPembayaran,
  pembayaranDiproses,
  pembayaranBerhasil,
  pembayaranGagal,
  pembayaranKadaluarsa
}

class QRISPaymentState extends Equatable {
  final QRISPaymentStatus status;
  final String? message;
  final String? transactionId;
  final DateTime? timestamp;

  const QRISPaymentState({
    this.status = QRISPaymentStatus.menungguPembayaran,
    this.message,
    this.transactionId,
    this.timestamp,
  });

  QRISPaymentState copyWith({
    QRISPaymentStatus? status,
    String? message,
    String? transactionId,
    DateTime? timestamp,
  }) {
    return QRISPaymentState(
      status: status ?? this.status,
      message: message ?? this.message,
      transactionId: transactionId ?? this.transactionId,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  String get statusText {
    switch (status) {
      case QRISPaymentStatus.menungguPembayaran:
        return 'Menunggu Pembayaran';
      case QRISPaymentStatus.pembayaranDiproses:
        return 'Pembayaran Diproses';
      case QRISPaymentStatus.pembayaranBerhasil:
        return 'Pembayaran Berhasil';
      case QRISPaymentStatus.pembayaranGagal:
        return 'Pembayaran Gagal';
      case QRISPaymentStatus.pembayaranKadaluarsa:
        return 'Pembayaran Kadaluarsa';
    }
  }

  @override
  List<Object?> get props => [status, message, transactionId, timestamp];
} 