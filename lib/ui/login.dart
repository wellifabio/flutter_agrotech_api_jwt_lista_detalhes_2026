import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../root/api.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "";
  String password = "";

  Future<void> autenticar() async {
    final url = Uri.parse(Api.login);
    try {
      final resp = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: '{"email":$email, "password":$password}',
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(resp.toString())));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro: $e")));
    }
  }

  void toHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              Image.asset('assets/icone.png', width: 150),
              TextField(
                decoration: InputDecoration(labelText: "E-mail"),
                onChanged: (value) => setState(() {
                  email = value;
                }),
              ),
              TextField(
                decoration: InputDecoration(labelText: "password"),
                onChanged: (value) => setState(() {
                  password = value;
                }),
              ),
              ElevatedButton(onPressed: autenticar, child: Text("Entrar")),
            ],
          ),
        ),
      ),
    );
  }
}
