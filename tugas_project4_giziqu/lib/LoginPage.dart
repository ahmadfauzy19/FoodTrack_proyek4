import 'package:flutter/material.dart';
import 'LandingPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
          const SizedBox(height: 150.0),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(30), // Menambahkan BorderRadius
                border: Border.all(
                  color: Colors.grey, // Warna border
                  width: 1, // Lebar border
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // const Text("Logo"),
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
                                    color: Colors
                                        .green, // Warna hijau untuk "Gizi"
                                  ),
                                ),
                                TextSpan(
                                  text: 'Qu',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors
                                        .orange, // Warna orange untuk "Qu"
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
                            color: Colors.green // Creates border
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
                        ]),
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
        ]),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          const TextField(
            decoration: InputDecoration(labelText: "Username/Email"),
          ),
          const TextField(
            decoration: InputDecoration(labelText: "Password"),
            obscureText: true,
          ),
          const SizedBox(
            height: 170,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LandingPage()),
                  );
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
          const TextField(
            decoration: InputDecoration(labelText: "Nama Lengkap"),
          ),
          const TextField(
            decoration: InputDecoration(labelText: "Username/Email"),
          ),
          const TextField(
            decoration: InputDecoration(labelText: "Password"),
            obscureText: true,
          ),
          const TextField(
            decoration: InputDecoration(labelText: "Validasi Password"),
            obscureText: true,
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
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
          )
        ],
      ),
    );
  }
}
