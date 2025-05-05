import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
import 'cek_saldo_screen.dart';
import 'transfer_screen.dart';
import 'deposito_screen.dart';
import 'pembayaran_screen.dart';
import 'pinjaman_screen.dart';
import 'mutasi_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const Color primaryColor = Color(0xFF1A237E);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double saldo = 2500000.0; // Saldo awal
  List<Map<String, dynamic>> mutasi = [];

  void updateSaldo(double jumlah, String keterangan) {
    setState(() {
      saldo += jumlah;
      mutasi.insert(0, {
        'tanggal': DateTime.now().toString().substring(0, 16),
        'keterangan': keterangan,
        'jumlah': jumlah,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Koperasi Undiksha',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: HomeScreen.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileCard(),
              const SizedBox(height: 24),
              _buildMenuGrid(),
              const SizedBox(height: 24),
              _buildHelpSection(),
              const SizedBox(height: 24),
              _buildBottomNavigation(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EAF6),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: HomeScreen.primaryColor,
                width: 2,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/profile.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nasabah',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const Text(
                  'Shandi Arif Aditya',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: HomeScreen.primaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Total Saldo Anda',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  'Rp ${saldo.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: HomeScreen.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        MenuItemWidget(
          icon: Icons.account_balance_wallet,
          label: 'Cek Saldo',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CekSaldoScreen(saldo: saldo),
              ),
            );
          },
        ),
        MenuItemWidget(
          icon: Icons.swap_horiz,
          label: 'Transfer',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TransferScreen(
                  saldo: saldo,
                  onTransfer: (jumlah) => updateSaldo(jumlah, 'Transfer'),
                ),
              ),
            );
          },
        ),
        MenuItemWidget(
          icon: Icons.savings,
          label: 'Deposito',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DepositoScreen(
                  onDeposit: (jumlah) => updateSaldo(jumlah, 'Deposito'),
                ),
              ),
            );
          },
        ),
        MenuItemWidget(
          icon: Icons.payment,
          label: 'Pembayaran',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PembayaranScreen(
                  onPay: (jumlah, ket) => updateSaldo(-jumlah, 'Pembayaran: $ket'),
                  saldo: saldo,
                ),
              ),
            );
          },
        ),
        MenuItemWidget(
          icon: Icons.monetization_on,
          label: 'Pinjaman',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PinjamanScreen(
                  onPinjam: (jumlah, lama) => updateSaldo(jumlah, 'Pinjaman $lama bulan'),
                ),
              ),
            );
          },
        ),
        MenuItemWidget(
          icon: Icons.trending_up,
          label: 'Mutasi',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MutasiScreen(mutasi: mutasi),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildHelpSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Butuh Bantuan???',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0878-1234-1024',
                style: TextStyle(
                  fontSize: 28,
                  color: HomeScreen.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.phone, color: HomeScreen.primaryColor, size: 40),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: const BottomMenuItem(
                icon: Icons.settings,
                label: 'Pengaturan',
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: const BottomMenuItem(
                icon: Icons.qr_code_scanner,
                label: 'Kode QR',
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: const BottomMenuItem(
                icon: Icons.person,
                label: 'Profil',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItemWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const MenuItemWidget({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: HomeScreen.primaryColor),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: HomeScreen.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const BottomMenuItem({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final bool isQRCode = icon == Icons.qr_code_scanner;

    Widget iconWidget = Icon(
      icon,
      size: isQRCode ? 32 : 28,
      color: isQRCode ? Colors.white : HomeScreen.primaryColor,
    );

    if (isQRCode) {
      iconWidget = Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: HomeScreen.primaryColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: iconWidget,
      );
    }

    return InkWell(
      onTap: () {
        if (icon == Icons.person) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProfileScreen(),
            ),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          iconWidget,
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: HomeScreen.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
} 