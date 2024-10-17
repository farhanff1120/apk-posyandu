// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:posyandu/presentation/pages/ladingpg.dart';

class SplashSc extends StatefulWidget {
  const SplashSc({super.key});

  @override
  State<SplashSc> createState() => _SplashScState();
}

class _SplashScState extends State<SplashSc> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5)).then((value) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LandingPgone(),
        )));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 106, 11, 164),
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 115,
                width: 275,
                decoration: const BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(18),
                      bottomRight: Radius.circular(18)),
                ),
              ),
            ),
            // const Align(
            //   alignment: ,
            // )
            const Align(
              alignment: Alignment(-0, 0),
              child: Text(
                'Posyandu \n Angrek1',
                style: TextStyle(
                    fontSize: 42,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: 80,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue[700],
                    borderRadius:
                        const BorderRadius.only(topRight: Radius.circular(18))),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(),
                      SizedBox(width: 20),
                      CircleAvatar(),
                      SizedBox(width: 20),
                      CircleAvatar(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
