// ignore_for_file: use_build_context_synchronously, file_names, avoid_print, unused_element, unused_local_variable

// import 'dart:convert';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:tugas_project4_giziqu/user_auth/FirebaseAuth.dart';
import 'global/link.dart';
import 'global/LoadingProgress.dart';
import 'package:flutter/material.dart';
import 'Admin/AdminPage.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const LoginPage({Key? key});

  static Future<DataUser?> getDataUser(String email) async {
    final Uri uri = Uri.parse('${link}api/getDataUser');
    print(email);

    try {
      final response = await http.post(
        uri,
        body: {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final dataUser = DataUser.fromJson(responseData['user']);
        return dataUser;
      } else {
        return null;
      }
    } catch (error) {
      print('Error fetching user data: $error');
      return null;
    }
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class DataUser {
  final String name;
  final String email;
  final String role;
  final String username;
  final String foto;

  DataUser(
      {required this.name,
      required this.email,
      required this.role,
      required this.username,
      required this.foto});

  factory DataUser.fromJson(Map<String, dynamic> json) {
    return DataUser(
      name: json['name'],
      email: json['email'],
      role: json['role'],
      username: json['username'],
      foto: json['foto'],
    );
  }

  @override
  String toString() {
    return 'User{name: $name, email: $email, role: $role, username: $username, foto: $foto}';
  }
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  // ignore: unused_field
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // ignore: unused_field
  bool _isLoading = true;

  late TabController _tabController;

  Future<String> registerUser(
      String name, String username, String email, String password) async {
    final Uri uri = Uri.parse("${link}api/daftar");

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const LoadingDialog(pesan: "Sedang mendaftar...");
        },
      );
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
        Navigator.of(context).pop();
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
        Navigator.of(context).pop();
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
      Navigator.of(context).pop();
      print('Kesalahan saat melakukan registrasi: $error');
    }
    return "gagal";
  }

  Future<DataUser?> getDataUser(String email) async {
    // Deklarasi variabel response di luar blok try untuk bisa digunakan di blok catch
    var response;

    final Uri uri = Uri.parse('${link}api/getDataUser');
    print(email);

    setState(() {
      _isLoading = true;
    });

    try {
      if (email == '') {
        _showDialog('email kosong');
        return null;
      } else {
        response = await http.post(
          uri,
          body: {
            'email': email,
          },
        );
      }

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final dataUser = DataUser.fromJson(responseData['user']);
        setState(() {
          _isLoading = false;
        });
        return dataUser;
      } else {
        setState(() {
          _isLoading = false;
        });
        _showDialog('Login gagal: ${response.body}');
        return null;
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      _showDialog('Kesalahan saat melakukan login: $error');
      return null;
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

  void _signIn(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;
    setState(() {
      _isLoading = true; // Atur status loading menjadi true
    });
    showDialog(
      context: context,
      barrierDismissible: false, // agar tidak bisa dismissed saat loading
      builder: (BuildContext context) {
        return const LoadingDialog(pesan: "Sedang login...");
      },
    );
    DataUser? dataUser = await getDataUser(email);

    if (dataUser != null) {
      try {
        // Masuk dengan menggunakan email dan password yang diperoleh dari DataUser
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: dataUser.email,
          password: password,
        );

        if (dataUser.role == "admin") {
          Navigator.of(context).pop(); // Tutup dialog loading
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminPage(adminData: dataUser),
            ),
          );
        } else {
          Navigator.pushNamed(context, "/landingpage");
        }
      } catch (e) {
        // Tangani kesalahan masuk
        setState(() {
          _isLoading =
              false; // Atur status loading menjadi false setelah proses selesai
        });
        Navigator.of(context).pop(); // Tutup dialog loading
        _showDialog('Kesalahan saat melakukan login: $e');
      }
    } else {
      Navigator.of(context).pop();
      _showDialog("email kosong");
    }
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
