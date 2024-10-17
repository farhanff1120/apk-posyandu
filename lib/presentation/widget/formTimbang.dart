import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:posyandu/presentation/widget/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormTimbang extends StatefulWidget {
  const FormTimbang({super.key});

  @override
  State<FormTimbang> createState() => _FormTimbangState();
}

class _FormTimbangState extends State<FormTimbang> {
  var id = 0;
  double containerHeight = 60.0;
  double containerWidth = double.infinity;
  String token = "";
  var nama_anak = "";
  var jenis_kelamin = "";
  var tanggal_pelayanan = "";
  var keluhan = "";
  var usia = "";
  var isLoading = false;
  Dio dio = Dio();
  DateTime? _selectedDate;
  final DateFormat formatter =
      DateFormat('yyyy-MM-dd'); // Inisialisasi formatter

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getInt('id')!;
      nama_anak = prefs.getString('nama_anak')!;
      usia = prefs.getString('usia')!;
      jenis_kelamin = prefs.getString('jenis_kelamin')!;
    });
  }

  void _presentStartDatePicker() async {
    final now = DateTime.now();

    // Mengatur firstDate dan lastDate tanpa waktu
    final firstDate = DateTime(now.year - 10, now.month, now.day);
    final lastDate = DateTime(now.year + 5, now.month, now.day);

    final pickDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    // Jika tanggal dipilih, waktu diatur menjadi 00:00:00 (tanpa waktu)
    if (pickDate != null) {
      setState(() {
        _selectedDate = DateTime(pickDate.year, pickDate.month, pickDate.day);
      });
    }
  }

  final TextEditingController inputBeratBadan = TextEditingController();
  final TextEditingController inputLingkarKepala = TextEditingController();
  final TextEditingController inputTinggiBadan = TextEditingController();
  final TextEditingController inputTanggal = TextEditingController();
  final TextEditingController inputKeluhan = TextEditingController();

  void AddTimbang(String berat_badan, String lingkar_kepala,
      String tinggi_badan, String tanggal_pelayanan, String keluhan) async {
    setState(() {
      isLoading = true;
    });
    try {
      var response = await dio.post(
          'https://posyandu-admin.harysusilo.my.id/api/layanan/timbang',
          data: {
            'user_id': id.toString(),
            'berat_badan': berat_badan,
            'lingkar_kepala': lingkar_kepala,
            'tinggi_badan': tinggi_badan,
            'tanggal_pelayanan': tanggal_pelayanan,
            'keluhan': keluhan,
          });
      print('user_id');
      if (response.data['success'] == true) {
        print(response.data['id']);
        Navigator.pop(context);
        AlertDialog alert = AlertDialog(
          icon: const Icon(
            CupertinoIcons.checkmark_seal_fill,
            size: 20,
            color: Color(0xff009382),
          ),
          title: Text("Berhasil \n" + "#"+response.data['id'].toString()),

          content: const Text("Di atas adalah nomor pendaftaran anda, silahkan screenshoot dan tunjukan ke bagian pelayanan posyandu"),
        );

        showDialog(context: context, builder: (context) => alert);
      } else {
        AlertDialog alert = const AlertDialog(
          icon: Icon(
            CupertinoIcons.checkmark_seal_fill,
            size: 20,
            color: Color(0xff009382),
          ),
          title: Text("Gagal"),
          content: Text("Pastikan data di isi dengan benar"),
        );
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Formulir Timbang Anak',
            style: semibolddeepblueextStyle.copyWith(fontSize: 14)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: deepblueColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // nama anak
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nama',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    height: 48,
                    width: containerWidth,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 1,
                          style: BorderStyle.solid,
                          color: Colors.lightBlueAccent,
                        )
                    ),
                    child: Text(nama_anak, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              // umur anak
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Usia',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    height: 48,
                    width: containerWidth,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 1,
                          style: BorderStyle.solid,
                          color: Colors.lightBlueAccent,
                        )
                    ),
                    child: Text('$usia tahun', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              // kelamin
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Jenis Kelamin',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    height: 48,
                    width: containerWidth,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 1,
                          style: BorderStyle.solid,
                          color: Colors.lightBlueAccent,
                        )
                    ),
                    child: Text(jenis_kelamin, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              buildInputSection(
                  'Tanggal', 'Masukan tanggal', TextInputType.datetime,
                  isDate: true),

              const SizedBox(height: 16),

              ///berat
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Berat Badan (KG)',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: inputBeratBadan,
                      decoration: InputDecoration(
                        hintText: 'Contoh : 30.5',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: false,
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
                ],
              ),
              const SizedBox(height: 16),

              ///lingkar kepala
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Lingkar Kepala (CM)',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset:
                          const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: inputLingkarKepala,
                      decoration: InputDecoration(
                        hintText: 'Contoh : 17.5',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: false,
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
                ],
              ),
              const SizedBox(height: 16),

              ///tinggi
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tinggi Badan (CM)',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset:
                          const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: inputTinggiBadan,
                      decoration: InputDecoration(
                        hintText: 'Contoh : 133.0',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: false,
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
                ],
              ),
              const SizedBox(height: 16),

              ///keluhan

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Keluhan',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset:
                          const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: inputKeluhan,
                      decoration: InputDecoration(
                        hintText: 'Masukan Keluhan Anda',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: false,
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
                ],
              ),

              const SizedBox(height: 32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Color(0xff6722d0))),
                    onPressed: () => {
                      AddTimbang(
                        inputBeratBadan.text.toString(),
                        inputLingkarKepala.text.toString(),
                        inputTinggiBadan.text.toString(),
                        _selectedDate.toString(),
                        inputKeluhan.text.toString(),
                      )
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 60),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text('Submit',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          "Batal",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputSection(
      String label, String hintText, TextInputType inputType,
      {bool isDate = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        isDate ? buildDatePicker() : buildTextField(hintText, inputType),
      ],
    );
  }

  Widget buildTextField(String hintText, TextInputType inputType) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.grey),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        keyboardType: inputType,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildDatePicker() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.lightBlueAccent),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _selectedDate == null
                ? 'Masukan tanggal'
                : formatter.format(_selectedDate!),
            style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
          ),
          IconButton(
            onPressed: _presentStartDatePicker,
            icon: const Icon(Icons.calendar_today, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
