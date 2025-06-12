import 'package:flutter/material.dart';
import 'package:primeiroapp/home.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback toggleTheme;

  const LoginPage({super.key, required this.toggleTheme});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Image.asset("assets/logoUpf.png"),
            ),
            TextField(
              maxLength: 50,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Informe o email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(37),
                  borderSide: BorderSide(style: BorderStyle.none),
                ),
              ),
            ),
            TextField(
              obscureText: showPassword,
              maxLength: 15,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon:
                      showPassword == false
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                ),
                hintText: "Informe a Senha",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(37),
                  borderSide: BorderSide(style: BorderStyle.none),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              HomePage(toggleTheme: widget.toggleTheme),
                    ),
                  );
                },
                child: const Text("Entrar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
