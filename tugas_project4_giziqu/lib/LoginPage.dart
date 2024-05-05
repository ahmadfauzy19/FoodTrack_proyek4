// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'global/link.dart';
import 'package:flutter/material.dart';
import 'Admin/AdminPage.dart';
import 'user/LandingPage.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  Future<String> registerUser(
      String name, String username, String email, String password) async {
    final Uri uri = Uri.parse("${link}api/daftar");

    try {
      final response = await http.post(
        uri,
        body: {
          'name': name,
          'username': username,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        _tabController.animateTo(0);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Informasi'),
              content: const Text('Registrasi berhasil. Silakan masuk.'),
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
        return "berhasil";
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Informasi'),
              content: Text('Registrasi gagal: ${response.body}'),
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
        return "gagal";
      }
    } catch (error) {
      print('Kesalahan saat melakukan registrasi: $error');
    }
    return "gagal";
  }

  Future<void> loginUser(String username, String password) async {
    final Uri uri = Uri.parse('${link}api/login');
    print(username);
    try {
      final response = await http.post(
        uri,
        body: {
          'username': username,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        String role = responseData['user']['role'];
        String name = responseData['user']['name'];

        // Periksa jika 'name' tidak null sebelum digunakan
        String welcomeMessage = role == "admin"
            ? 'Login Berhasil, Selamat datang Admin'
            : 'Login Berhasil, Selamat datang, $name';
        if (role == 'admin') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Informasi'),
                content: Text(welcomeMessage),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminPage(
                                  username: name,
                                )),
                      );
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Informasi'),
                  content: Text(welcomeMessage),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LandingPage(
                                    username: name,
                                  )),
                        );
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              });
        }
      } else {
        _showDialog('Login gagal: ${response.body}');
      }
    } catch (error) {
      _showDialog('Kesalahan saat melakukan login: $error');
    }
  }

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
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(children: [
          const SizedBox(height: 70.0),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
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
          SizedBox(
            height: 100,
          )
        ]),
      ),
    );
  }

  Widget _buildLoginForm() {
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Username/email"),
          ),
          TextField(
            controller: passwordController,
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
                  loginUser(nameController.text, passwordController.text);
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
    TextEditingController nameController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Nama Lengkap"),
          ),
          TextField(
            controller: usernameController,
            decoration: const InputDecoration(labelText: "Username"),
          ),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: "Password"),
            obscureText: true,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              registerUser(nameController.text, usernameController.text,
                      emailController.text, passwordController.text)
                  .then((result) {
                if (result == "berhasil") {
                  nameController.clear();
                  usernameController.clear();
                  emailController.clear();
                  passwordController.clear();
                }
              });
            },
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
