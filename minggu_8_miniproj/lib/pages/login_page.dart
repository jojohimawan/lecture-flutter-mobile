import 'dart:async';

import 'package:flutter/material.dart';
import 'package:minggu_8_miniproj/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  bool _redirecting = false;
  late final TextEditingController _emailController = TextEditingController();
  late final StreamSubscription<AuthState> _authStateSubscription;

  Future<void> _login() async {
    try {
      setState(() {
        _isLoading = true;
      });

      await supabase.auth.signInWithOtp(
        email: _emailController.text.trim(),
        emailRedirectTo: 'io.supabase.flutterquickstart://login-callback/'
      );

      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Check your email!') 
          )
        );

        _emailController.clear();
      }
    } on AuthException catch (err) {
      SnackBar(
        content: Text(err.message),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } catch (err) {
      SnackBar(
        content: const Text("Error occured, please retry!"),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } finally {
      if(mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      if(_redirecting) return;

      final session = data.session;

      if(session != null) {
        _redirecting = true;
        Navigator.of(context).pushReplacementNamed('/account');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _authStateSubscription.cancel();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login'
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          const Text('Login via magic link'),
          const SizedBox(height: 18),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email'
            ),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: _isLoading ? null : _login,
            child: Text(
              _isLoading ?
                'Loading' :
                  'Send Magic Link'
            )
          )
        ],
      ),
    );
  }
}