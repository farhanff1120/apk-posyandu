import 'package:flutter/material.dart';
import 'package:posyandu/presentation/pages/login.dart';
import 'package:posyandu/presentation/widget/theme.dart';

class LandingPgone extends StatelessWidget {
  const LandingPgone({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/sp1.png'),
                  ],
                ),
              ),
            ),

            Container(
              height: 420,
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Selamat datang di \n Posyandu Anggrek 1',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    maxLines: 3,
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        elevation: 4,
                        shadowColor: Colors.black,
                        backgroundColor: Colors.purple,
                        minimumSize: const Size.fromHeight(45)),
                    child: Text(
                      "Next",
                      textAlign: TextAlign.center,
                      style: semiboldwhitetext.copyWith(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
