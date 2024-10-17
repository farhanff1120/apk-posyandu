import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:posyandu/presentation/navbarBottom.dart';
import 'package:posyandu/presentation/pages/signup.dart';
import 'package:posyandu/presentation/widget/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  _LoginState();
  bool _ObsecureText = true;
  bool isLoading = false;

  final TextEditingController inputUsername = TextEditingController();
  final TextEditingController inputPassword = TextEditingController();

  void login(String username, String password) async {
    setState(() {
      isLoading = true;
    });
    try {
      var response = await post(
          Uri.parse('https://posyandu-admin.harysusilo.my.id/api/auth/login'),
          body: {
            'username': username,
            'password' : password
          });

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        isLoading = true;
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => NavbarBot()),
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', 'Bearer ' + responseData['token']);
        prefs.setInt('id', responseData['data']['id']);
        prefs.setString('username', responseData['data']['username']);
        prefs.setString('alamat', responseData['data']['alamat']);
        prefs.setString('no_hp', responseData['data']['no_hp']);
        prefs.setString('nama_ibu', responseData['data']['nama_ibu']);
        prefs.setString('tgl_lahir_ibu', responseData['data']['tgl_lahir_ibu']);
        prefs.setString('nama_anak', responseData['data']['nama_anak']);
        prefs.setString('tgl_lahir', responseData['data']['tgl_lahir']);
        prefs.setString('usia', responseData['data']['usia']);
        prefs.setString('jenis_kelamin', responseData['data']['jenis_kelamin']);


        AlertDialog alert = AlertDialog(
          title: Text(responseData['message']),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );

        showDialog(context: context, builder: (context) => alert);
      } else {
        AlertDialog alert = AlertDialog(
          title: const Text("Pastikan username dan password di isi dengan benar"),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
        showDialog(context: context, builder: (context) => alert);
      }
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 350,
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(95),
                bottomRight: Radius.circular(95),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Login',
                      style: semiboldwhitetext.copyWith(fontSize: 22),
                    ),
                  ),
                  Image.asset('assets/images/login-img.png', height: 270,),
                ],
              ),
            ),
          ),
          Container(
            height: 440,
            width: double.maxFinite,
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    const Text(
                      "Email",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 12),
                    // ignore: avoid_unnecessary_containers
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset:
                            const Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: inputUsername,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Contoh: budi@gmail.com',
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      "Password",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 12),
                    // ignore: avoid_unnecessary_containers
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset:
                            const Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: inputPassword,
                        decoration: InputDecoration(
                          hintText: 'Masukan Password',
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: false,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(_ObsecureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _ObsecureText = !_ObsecureText;
                              });
                            },
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        obscureText: _ObsecureText,
                      ),
                    ),
                  ]
                ),

                Column(
                  children:[
                    ElevatedButton(
                      onPressed: ()=> {
                          login(
                           inputUsername.text.toString(),
                            inputPassword.text.toString(),
                          )
                        },
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          elevation: 4,
                          shadowColor: Colors.black,
                          backgroundColor: Colors.purple,
                          minimumSize: const Size.fromHeight(45)),
                      child: Text(
                        "Masuk",
                        textAlign: TextAlign.center,
                        style: semiboldwhitetext.copyWith(fontSize: 18),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Apakah kamu belum memiliki akun?",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Signup()));
                          },
                          child: const Text(
                            "Daftar",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14,color: Colors.blue, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ]
                )
              ],
            ),
          )
        ],
      )
    ));
  }
}
