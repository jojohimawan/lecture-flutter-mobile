import 'package:flutter/material.dart';
import 'package:minggu_8_miniproj/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool _isLoading = true;
  final _usernameController = TextEditingController();

  Future<void> _getProfile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userId = supabase.auth.currentUser!.id;
      final data = await supabase.from('profiles').select().eq('id', userId).single();

      _usernameController.text = (data['username'] ?? '') as String;
    } on PostgrestException catch(err) {
      SnackBar(
        content: Text(err.message),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } catch(err) {
      SnackBar(
        content: const Text('Error occured, please retry!'),
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

  Future<void> _updateProfile() async {
    setState(() {
      _isLoading = true;
    });
    
    final userName = _usernameController.text.trim();
    final user = supabase.auth.currentUser;
    final updates = {
      'id': user!.id,
      'username': userName,
      'updated_at': DateTime.now().toIso8601String()
    };

    try {
      await supabase.from('profiles').upsert(updates);

      if(mounted) {
        const SnackBar(
          content: Text('Successfully updated profile.'),
        );
      }
    } on PostgrestException catch(err) {
      SnackBar(
        content: Text(err.message),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } catch(err) {
      SnackBar(
        content: const Text('Error occured, please retry!'),
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

  Future<void> _logout() async {
    try {
      await supabase.auth.signOut();
    } on AuthException catch(err) {
      SnackBar(
        content: Text(err.message),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } catch(err) {
      SnackBar(
        content: const Text('Error occured, please retry!'),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } finally {
      if(mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  @override
  void dispose() {
    _usernameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: _isLoading
        ? const Center(
          child: CircularProgressIndicator(),
        )
        : ListView(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: _isLoading ? null : _updateProfile,
              child: Text(_isLoading ? 'Updating...' : 'Update')
            ),
            const SizedBox(height: 18),
            TextButton(
              onPressed: _logout,
              child: const Text('Logout')
            )
          ],
        )
    );
  }
}