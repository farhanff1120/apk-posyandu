import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widget/theme.dart';

class HistoryIbuHamil extends StatefulWidget {
  const HistoryIbuHamil({super.key});

  @override
  State<HistoryIbuHamil> createState() => _HistoryIbuHamilState();
}

class _HistoryIbuHamilState extends State<HistoryIbuHamil> {

  String token = "";
  var user_id = 0;
  var layanan_id = 0;
  var jenis_imunisasi = "";
  var jenis_vitamin = "";
  var tanggal_pelayanan = "";
  var tinggi_badan = "";
  var berat_badan = "";
  var deskripsi = "";
  var catatan_dokter = "";
  List<dynamic> layananList = [];
  List<dynamic> timbangList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getDataLayanan();
  }

  void getDataLayanan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id = prefs.getInt('id')!;
      token = prefs.getString('token')!;
    });

    try {
      var response = await get(
        Uri.parse('https://posyandu-admin.harysusilo.my.id/api/layanan/get-ibuHamil/$user_id'),
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        setState(() {
          layananList = responseData['data'];  // Save entire data list
          isLoading = false;
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: layananList.length,
        itemBuilder: (context, index) {
          var layanan = layananList[index];
          // var timbang = timbangList[index];
          return Column(
            children: [
              Container(
                height: 130,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('Layanan Ibu Hamil', style: TextStyle(fontSize: 16)),
                        const Icon(Icons.numbers, color: Colors.black),
                        Text(layanan['id'].toString(), style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text('Tanggal : ${layanan['tanggal_pelayanan']}'),
                    Text('Keluhan : ${layanan['deskripsi']}'),
                    Text('Catatan : ${layanan['catatan_dokter']}'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}
