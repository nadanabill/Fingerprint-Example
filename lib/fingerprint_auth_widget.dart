import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class FingerprintAuth extends StatefulWidget {
  const FingerprintAuth({super.key});

  @override
  State<FingerprintAuth> createState() => _FingerprintAuthState();
}

class _FingerprintAuthState extends State<FingerprintAuth> {
  final LocalAuthentication _auth = LocalAuthentication();
  bool _isAuthenticated = false;

  Future<void> _authenticate() async {
    try {
      bool authenticated = await _auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );

      setState(() {
        _isAuthenticated = authenticated;
      });
    } catch (e) {
      debugPrint('Error using biometric authentication: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fingerprint Authentication')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isAuthenticated ? "Authenticated!" : "Tap below to authenticate",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _authenticate,
              child: const Text("Authenticate with Fingerprint"),
            ),
          ],
        ),
      ),
    );
  }
}
