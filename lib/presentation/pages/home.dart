import 'package:flutter/material.dart';
import 'package:posyandu/data/models/layanan_models.dart';
import 'package:posyandu/presentation/widget/formImunisasi.dart';
import 'package:posyandu/presentation/widget/formKehamilan.dart';
import 'package:posyandu/presentation/widget/formTimbang.dart';
import 'package:posyandu/presentation/widget/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String token = "";
  var id = 0;
  String nama_anak = "";
  String nik_anak = "";
  String alamat = "";
  String usia = "";
  String jenis_kelamin = "";
  final List<Surat> layananSurat = [
    Surat(name: 'Imunisasi & Vitamin'),
    Surat(name: 'Timbang Balita & Anak'),
    Surat(name: 'Ibu Hamil'),
  ];

  @override
  void initState() {
    super.initState();
    getToken();
    getUser();
  }

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getInt('id')!;
      nama_anak = prefs.getString('nama_anak')!;
      jenis_kelamin = prefs.getString('jenis_kelamin')!;
      usia = prefs.getString('usia')!;
    });
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token')!;
      print(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Aplikasi Posyandu Terpadu',
                    style: mediumPURPLETextStyle.copyWith(fontSize: 20),
                  ),
                  Text(
                    'Ajukan keluhan anda bersama kami',
                    style: regularBlackTextStyle.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24,24,32,24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 160,
                  width: 355,
                  decoration: BoxDecoration(
                    color: const Color(0xff1e3883),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              foregroundImage:
                                  AssetImage('assets/images/Pria.jpeg'),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  nama_anak,
                                  style:

                                  mediumblueTextStyle.copyWith(fontSize: 16),
                                ),
                                Text('$usia Tahun', style: TextStyle(color: Colors.white),)
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                            ),
                            child: Text('Lihat', style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  'Layanan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, ),
                ),
                const Divider(),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FormImunisasi(),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        shadowColor: Colors.grey,

                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Imunisasi dan Vitamin',
                                    style: mediumWhiteTextStyle.copyWith(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.deepPurple),
                                  ),
                                  const SizedBox(height: 8,),
                                  const Text('Daftar Imunisasi sekarang, \njaga daya tahan tubuh \nanak anda.', style: TextStyle(fontSize: 12),)
                                ],
                              ),
                              const SizedBox(width: 12),
                              Image.asset('assets/images/imunisasi.jpg', width: 86,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),

                    //timbang
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FormTimbang(),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        shadowColor: Colors.grey,

                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Timbang Anak',
                                    style: mediumWhiteTextStyle.copyWith(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.deepPurple),
                                  ),
                                  SizedBox(height: 8,),
                                  const Text('Program timbang anak/balita \ndan konsultasi masalah pada \nberat badan dan nafsu makan.', style: TextStyle(fontSize: 12),)
                                ],
                              ),
                              const SizedBox(width: 12),
                              Image.asset('assets/images/timbang.jpg', width: 86,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),

                    // kehamilan
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FormKehamilan(),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        shadowColor: Colors.grey,

                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ibu Hamil',
                                    style: mediumWhiteTextStyle.copyWith(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.deepPurple),
                                  ),
                                  const SizedBox(height: 8,),
                                  const Text('Program untuk membantu ibu \nmemantau perkembangan \nkandungan dan janin.', style: TextStyle(fontSize: 12),)
                                ],
                              ),
                              const SizedBox(width: 12),
                              Image.asset('assets/images/ibu-hamil.jpg', width: 86,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
