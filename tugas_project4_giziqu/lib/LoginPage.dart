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
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(children: [
          const SizedBox(height: 150.0),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Logo"),
                      // Image.asset(name),
                      const SizedBox(width: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("GiziQu"),
                          Text("Keep Happy And Healthy")
                        ],
                      )
                    ],
                  ),
                  TabBar(controller: _tabController, tabs: const [
                    Tab(
                      text: "Masuk",
                    ),
                    Tab(
                      text: "Daftar",
                    ),
                  ]),
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
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: "Username/Email"),
          ),
          TextField(
            decoration: InputDecoration(labelText: "Password"),
            obscureText: true,
          ),
          const SizedBox(
            height: 200,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LandingPage()),
                  );
                },
                child: Text("Masuk"),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRegisterForm() {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: "Nama Lengkap"),
          ),
          TextField(
            decoration: InputDecoration(labelText: "Username/Email"),
          ),
          TextField(
            decoration: InputDecoration(labelText: "Password"),
            obscureText: true,
          ),
          TextField(
            decoration: InputDecoration(labelText: "Validasi Password"),
            obscureText: true,
          ),
          const SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text("Daftar"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
