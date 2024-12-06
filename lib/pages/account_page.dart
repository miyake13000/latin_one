import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {
  // Registration Field Email Address
  String registerUserEmail = "";
  // Registration Field Password
  String registerUserPassword = "";
  // Login field email address
  String loginUserEmail = "";
  // Login field password (login)
  String loginUserPassword = "";
  // View information about registration and login
  String debugMessage = "";
  // Current User Name
  String? userName = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 8),
              TextFormField(
                // Set labels for text input
                decoration: const InputDecoration(labelText: "Mail Address"),
                onChanged: (String value) {
                  setState(() {
                    registerUserEmail = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "6 character long Password"),
                // Mask not to show password
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    registerUserPassword = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // User Registration
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final UserCredential result =
                    await auth.createUserWithEmailAndPassword(
                      email: registerUserEmail,
                      password: registerUserPassword,
                    );
                    // Registered User Information
                    final User user = result.user!;
                    setState(() {
                      debugMessage = "Register OK：${user.email}";
                      userName = user.email;
                    });
                  } catch (e) {
                    // Failed User Information
                    setState(() {
                      debugMessage = "Register Fail：${e.toString()}";
                    });
                  }
                },
                child: const Text("User Registration"),
              ),

              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: "Mail Address"),
                onChanged: (String value) {
                  setState(() {
                    loginUserEmail = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    loginUserPassword = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // Try login
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final UserCredential result =
                      await auth.signInWithEmailAndPassword(
                        email: loginUserEmail,
                        password: loginUserPassword,
                      );
                    // Succeeded to login
                    final User user = result.user!;
                    setState(() {
                      debugMessage = "Succeeded to Login：${user.email}";
                      userName = user.email;
                    });
                  } catch (e) {
                    // Failed to login
                    setState(() {
                      debugMessage = "Failed to Login：${e.toString()}";
                    });
                  }
                },
                child: const Text("Login"),
              ),
              const SizedBox(height: 20),
              if (userName != null) ElevatedButton(
                onPressed: () async {
                  try {
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    await auth.signOut();
                    setState(() {
                      debugMessage = "Succeeded to Logout";
                      userName = null;
                    });
                  } catch (e) {
                    setState(() {
                      debugMessage = "Failed to Logout：${e.toString()}";
                    });
                  }
                },
                child: const Text("Logout"),
              ),
              const SizedBox(height: 8),
              Text(debugMessage),
            ],
          ),
        ),
      ),
    );
  }
}
