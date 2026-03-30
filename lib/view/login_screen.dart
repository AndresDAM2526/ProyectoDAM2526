import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/ribera.png',
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 5,
              ),
            ),
            Form(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top:10,left: 40,right: 40,bottom: 10),
                    child: TextFormField(
                      decoration: InputDecoration(label: Text("Usuario")),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:10,left: 40,right: 40,bottom: 30),
                    child: TextFormField(
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        label: Text("Contraseña"),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          icon: Icon(
                            Icons.remove_red_eye,
                            semanticLabel: "Mostrar contraseña",
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(onPressed: (){}, child: Text("Iniciar sesión"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
