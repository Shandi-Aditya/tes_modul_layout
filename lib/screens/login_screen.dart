import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  static const Color primaryColor = Color(0xFF1A237E);
  
  static const _inputBorder = BorderRadius.all(Radius.circular(10));
  
  static const _defaultBorder = OutlineInputBorder(
    borderRadius: _inputBorder,
    borderSide: BorderSide(color: primaryColor),
  );
  
  static const _focusedBorder = OutlineInputBorder(
    borderRadius: _inputBorder,
    borderSide: BorderSide(
      color: primaryColor,
      width: 2,
    ),
  );

  static const _buttonShape = RoundedRectangleBorder(
    borderRadius: _inputBorder,
  );

  static const _buttonStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const _titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const _copyrightStyle = TextStyle(
    color: Colors.grey,
    fontSize: 12,
  );

  static const _boldStyle = TextStyle(
    fontWeight: FontWeight.bold,
  );

  static const _usernameDecoration = InputDecoration(
    labelText: 'Nama Pengguna',
    prefixIcon: Icon(Icons.person, color: primaryColor),
    border: _defaultBorder,
    focusedBorder: _focusedBorder,
  );

  static const _passwordDecoration = InputDecoration(
    labelText: 'Kata Sandi',
    prefixIcon: Icon(Icons.lock, color: primaryColor),
    border: _defaultBorder,
    focusedBorder: _focusedBorder,
  );

  static final _elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    shape: _buttonShape,
    elevation: 2,
  );

  static final _textButtonStyle = TextButton.styleFrom(
    foregroundColor: primaryColor,
  );

  void _handleLogin() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Username dan password tidak boleh kosong';
      });
      return;
    }

    if (username != 'shandi' || password != 'shandi123') {
      setState(() {
        _errorMessage = 'Username atau password salah';
      });
      return;
    }

    setState(() {
      _errorMessage = null;
    });
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const _HeaderContainer(),
                const SizedBox(height: 40),
                const _LogoImage(),
                const SizedBox(height: 50),
                TextField(
                  controller: _usernameController,
                  decoration: _usernameDecoration,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: _passwordDecoration,
                ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _handleLogin,
                    style: _elevatedButtonStyle,
                    child: const Text('Masuk', style: _buttonStyle),
                  ),
                ),
                const SizedBox(height: 20),
                const _ActionButtons(),
                const SizedBox(height: 40),
                const Text(
                  'Hak Cipta ©2025 oleh Shandi-Undiksha',
                  style: _copyrightStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderContainer extends StatelessWidget {
  const _HeaderContainer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: _LoginScreenState.primaryColor,
        borderRadius: _LoginScreenState._inputBorder,
      ),
      child: const Text(
        'Koperasi Undiksha',
        style: _LoginScreenState._titleStyle,
      ),
    );
  }
}

class _LogoImage extends StatelessWidget {
  const _LogoImage();

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage('assets/images/logo.png'),
      height: 150,
      width: 150,
      fit: BoxFit.contain,
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _ActionButton(text: 'Daftar M-Banking'),
        _ActionButton(text: 'Lupa Kata Sandi?'),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: _LoginScreenState._textButtonStyle,
      child: Text(text, style: _LoginScreenState._boldStyle),
    );
  }
} 