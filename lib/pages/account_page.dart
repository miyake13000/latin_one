import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _newEmailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _newNameController = TextEditingController();
  final _newAddressController = TextEditingController();

  String? _name;
  String? _address;
  final String? _email = FirebaseAuth.instance.currentUser?.email;
  final String? _uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (_uid != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          _name = userDoc.data()?['name'] as String?;
          _address = userDoc.data()?['address'] as String?;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('アカウント情報'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${_email ?? "未設定"}'),
            const SizedBox(height: 8),
            Text('名前: ${_name ?? "未設定"}'),
            const SizedBox(height: 8),
            Text('住所: ${_address ?? "未設定"}'),
            const SizedBox(height: 24),

            _buildSection(
              title: 'E-mail を変更する',
              controller: _newEmailController,
              labelText: '新しい E-mail',
              buttonText: 'E-mail を変更',
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.currentUser
                      ?.updateEmail(_newEmailController.text);
                  setState(() {});
                  if (mounted) {
                    Fluttertoast.showToast(msg: "メールアドレスを更新しました");
                  }
                } catch (e) {
                  if (mounted) {
                    Fluttertoast.showToast(msg: "エラー: ${e.toString()}");
                  }
                }
              },
            ),

            _buildSection(
              title: 'Password を変更する',
              controller: _newPasswordController,
              labelText: '新しい Password',
              buttonText: 'Password を変更',
              isPassword: true,
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.currentUser
                      ?.updatePassword(_newPasswordController.text);
                  if (mounted) {
                    Fluttertoast.showToast(msg: "パスワードを更新しました");

                  }
                } catch (e) {
                  if (mounted) {
                    Fluttertoast.showToast(msg: "エラー: ${e.toString()}");
                  }
                }
              },
            ),

            _buildSection(
              title: '名前を変更する',
              controller: _newNameController,
              labelText: '新しい名前',
              buttonText: '名前を変更',
              onPressed: () async {
                try {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(_uid)
                      .update({'name': _newNameController.text});
                  await _loadUserData();
                  if (mounted) {
                    Fluttertoast.showToast(msg: "名前を更新しました");
                  }
                } catch (e) {
                  if (mounted) {
                    Fluttertoast.showToast(msg: "エラー: ${e.toString()}");
                  }
                }
              },
            ),

            _buildSection(
              title: '住所を変更する',
              controller: _newAddressController,
              labelText: '新しい住所',
              buttonText: '住所を変更',
              onPressed: () async {
                try {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(_uid)
                      .update({'address': _newAddressController.text});
                  await _loadUserData();
                  if (mounted) {
                    Fluttertoast.showToast(msg: "住所を更新しました");
                  }
                } catch (e) {
                  if (mounted) {
                    Fluttertoast.showToast(msg: "エラー: ${e.toString()}");
                  }
                }
              },
            ),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  if (mounted) {
                    context.go('/');
                  }
                },
                child: const Text('ログアウト'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required TextEditingController controller,
    required String labelText,
    required String buttonText,
    required VoidCallback onPressed,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            border: const OutlineInputBorder(),
          ),
          obscureText: isPassword,
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(buttonText),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  void dispose() {
    _newEmailController.dispose();
    _newPasswordController.dispose();
    _newNameController.dispose();
    _newAddressController.dispose();
    super.dispose();
  }
}
