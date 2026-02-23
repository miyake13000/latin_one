import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import '../models/user.dart';

class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  @override
  ConsumerState<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage> {
  final _newEmailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _newNameController = TextEditingController();
  final _newAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userFuture = ref.watch(userProvider);
    final userNotifier = ref.watch(userProvider.notifier);

    final User? user = userFuture.when(
      data: (data) => data,
      error: (error, stack) {
        Fluttertoast.showToast(msg: "エラーが発生しました: ${error.toString()}");
        return null;
      },
      loading: () {
        // ローディング中はスピナーを表示
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        });
        return null;
      },
    );

    // ローディングが終わったらダイアログを閉じる
    if (!userFuture.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context, rootNavigator: true).pop();
      });
    }

    if (user == null) {
      Fluttertoast.showToast(msg: "不正な操作です");
      GoRouter.of(context).go('/signin');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('アカウント情報'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${user!.email}'),
            const SizedBox(height: 8),
            Text('名前: ${user.name}'),
            const SizedBox(height: 8),
            Text('住所: ${user.address}'),
            const SizedBox(height: 24),

            _buildInfoChanger(
              target: 'E-mail',
              controller: _newEmailController,
              changer: (text) async {
                userNotifier.updateEmail(_newEmailController.text);
              },
            ),

            _buildInfoChanger(
              target: 'Password',
              controller: _newPasswordController,
              needMusk: true,
              changer: (text) async {
                userNotifier.updatePassword(_newPasswordController.text);
              }
            ),

            _buildInfoChanger(
              target: '名前',
              controller: _newNameController,
              changer: (text) async {
                userNotifier.updateName(_newNameController.text);
              }
            ),

              _buildInfoChanger(
              target: '住所',
              controller: _newAddressController,
              changer: (text) async {
                userNotifier.updateAddress(_newAddressController.text);
              }
            ),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await userNotifier.signout();
                    if (mounted) {
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
