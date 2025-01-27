import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fireauth;
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';

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

  @override
  Widget build(BuildContext context) {
    return Consumer<User>(
      builder: (context, user, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('アカウント情報'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email: ${user.email}'),
                const SizedBox(height: 8),
                Text('名前: ${user.name ?? "未設定"}'),
                const SizedBox(height: 8),
                Text('住所: ${user.address ?? "未設定"}'),
                const SizedBox(height: 24),

                _buildInfoChanger(
                  target: 'E-mail',
                  controller: _newEmailController,
                  changer: (text) async {
                    await fireauth.FirebaseAuth.instance.currentUser
                      ?.verifyBeforeUpdateEmail(text);
                  },
                ),

                _buildInfoChanger(
                  target: 'Password',
                  controller: _newPasswordController,
                  needMusk: true,
                  changer: (text) async {
                    await fireauth.FirebaseAuth.instance.currentUser
                      ?.updatePassword(text);
                  }
                ),

                _buildInfoChanger(
                  target: '名前',
                  controller: _newNameController,
                  changer: (text) async {
                    user.updateName(text);
                  }
                ),

                  _buildInfoChanger(
                  target: '住所',
                  controller: _newAddressController,
                  changer: (text) async {
                    user.updateAddress(text);
                  }
                ),

                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await fireauth.FirebaseAuth.instance.signOut();
                        if (context.mounted) {
                          Fluttertoast.showToast(msg: "ログアウトしました");
                          GoRouter.of(context).go('/');
                        }
                      } catch (e) {
                        if (mounted) {
                          Fluttertoast.showToast(msg: "エラー: ${e.toString()}");
                        }
                      }
                    },
                    child: const Text("ログアウト"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoChanger({
    required String target,
    required TextEditingController controller,
    required Future<void> Function(String) changer,
    bool needMusk = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$target を変更",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: "新しい $target",
            border: const OutlineInputBorder(),
          ),
          obscureText: needMusk,
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              try {
                await changer(controller.text);
                if (mounted) {
                  Fluttertoast.showToast(msg: "$targetを更新しました");
                }
              } catch (e) {
                if (mounted) {
                  Fluttertoast.showToast(msg: "エラー: ${e.toString()}");
                }
              }
            },
            child: Text("$targetを変更"),
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
