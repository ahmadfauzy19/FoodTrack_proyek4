import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(children: [
          const SizedBox(height: 200.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Logo"),
              // Image.asset(name),
              const SizedBox(width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text("GiziQu"), Text("Keep Happy And Healthy")],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text("Masuk"),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Daftar"),
              ),
            ],
          ),
          TextField(
            decoration: InputDecoration(labelText: "Username/Email"),
          ),
          TextField(
            decoration: InputDecoration(labelText: "Password"),
            obscureText: true,
          ),
          const SizedBox(
            height: 150,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text("Masuk"),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
