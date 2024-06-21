// ignore_for_file: use_build_context_synchronously, file_names, avoid_print, unused_element, unused_local_variable

// import 'dart:convert';
// import 'dart:convert';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:tugas_project4_giziqu/user_auth/FirebaseAuth.dart';
import 'package:flutter/material.dart';
import 'user_auth/LoginService.dart';
import 'user_auth/RegisterService.dart';

class LoginPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  // ignore: unused_field
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  late TabController _tabController;

  void _showDialog(String message, {bool isAdmin = false}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Informasi'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(children: [
          const SizedBox(height: 70.0),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        width: 100,
                        height: 100,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Gizi',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.green,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Qu',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Text("Keep Happy And Healthy")
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.green,
                      ),
                      labelColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.tab,
                      unselectedLabelColor:
                          const Color.fromARGB(255, 255, 182, 52),
                      tabs: const [
                        Tab(
                          text: "Masuk",
                        ),
                        Tab(
                          text: "Daftar",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        SingleChildScrollView(
                          child: _buildLoginForm(),
                        ),
                        SingleChildScrollView(
                          child: _buildRegisterForm(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          )
        ]),
      ),
    );
  }

  Future<void> _registerUser() async {
    String name = _nameController.text;
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String result = await RegisterService.registerUser(
        context, name, username, email, password, _tabController);

    if (result == "berhasil") {
      _showDialog('Registrasi berhasil. Silakan masuk.');
      _nameController.clear();
      _usernameController.clear();
      _emailController.clear();
      _passwordController.clear();
    } else {
      _showDialog('Registrasi gagal.');
    }
  }

  void _signIn(BuildContext context) {
    String email = _emailController.text;
    String password = _passwordController.text;
    LoginService.signIn(context, email, password, _tabController, _showDialog);
  }

  Widget _buildLoginForm() {
    return Container(
      padding: const EdgeInsets.all(10),
      // margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: "Username/email"),
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: "Password"),
          ),
          const SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _signIn(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  "Masuk",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRegisterForm() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: "Nama Lengkap"),
          ),
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: "Username"),
          ),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: "Password"),
            obscureText: true,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: _registerUser,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text(
              "Daftar",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
