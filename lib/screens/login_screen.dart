import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: _LoginContent(),
          ),
        ),
      ),
    );
  }
}

class _LoginContent extends StatelessWidget {
  const _LoginContent();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        _HeaderContainer(),
        SizedBox(height: 40),
        _LogoImage(),
        SizedBox(height: 50),
        _UsernameField(),
        SizedBox(height: 20),
        _PasswordField(),
        SizedBox(height: 30),
        _LoginButton(),
        SizedBox(height: 20),
        _ActionButtons(),
        SizedBox(height: 40),
        Text(
          'Hak Cipta ©2025 oleh Shandi-Undiksha',
          style: LoginScreen._copyrightStyle,
        ),
      ],
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
        color: LoginScreen.primaryColor,
        borderRadius: LoginScreen._inputBorder,
      ),
      child: const Text(
        'Koperasi Undiksha',
        style: LoginScreen._titleStyle,
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

class _UsernameField extends StatelessWidget {
  const _UsernameField();

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: LoginScreen._usernameDecoration,
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField();

  @override
  Widget build(BuildContext context) {
    return const TextField(
      obscureText: true,
      decoration: LoginScreen._passwordDecoration,
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        style: LoginScreen._elevatedButtonStyle,
        child: const Text('Masuk', style: LoginScreen._buttonStyle),
      ),
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
      style: LoginScreen._textButtonStyle,
      child: Text(text, style: LoginScreen._boldStyle),
    );
  }
} 