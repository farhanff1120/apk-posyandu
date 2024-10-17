import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:posyandu/presentation/widget/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormImunisasi extends StatefulWidget {
  const FormImunisasi({super.key});

  @override
  State<FormImunisasi> createState() => _FormImunisasiState();
}

class _FormImunisasiState extends State<FormImunisasi> {
  var id = 0;
  double containerHeight = 60.0;
  double containerWidth = double.infinity;
  String? dropdownValue1 = "Campak";
  String? dropdownValue2 = "Vitamin A+";
  String token = "";
  String nama_anak = "";
  String jenis_kelamin = "";
  List vitamin = [];
  List imunisasi = [];
  var tanggal_pelayanan = "";
  var keluhan = "";
  String usia = "";
  var isLoading = false;
  Dio dio = Dio();
  DateTime? _selectedDate;
  final DateFormat formatter =
  DateFormat('yyyy-MM-dd'); // Inisialisasi formatter

  @override
  void initState() {
    super.initState();
    getVitamin();
    getUser();
    getImunisasi();
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

  ///get vitamin
  void getVitamin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;
    
    try {
      var response = await get(
          Uri.parse('https://posyandu-admin.harysusilo.my.id/api/get-jenis-vitamin'),
          );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        vitamin = responseData;
        print(vitamin);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void getImunisasi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token')!;

    try {
      var response = await get(
        Uri.parse('https://posyandu-admin.harysusilo.my.id/api/get-jenis-imunisasi'),
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        imunisasi = responseData;
        print(imunisasi);
      }
    } catch (e) {
      print(e.toString());
    }
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

    /// Jika tanggal dipilih, waktu diatur menjadi 00:00:00 (tanpa waktu)
    if (pickDate != null) {
      setState(() {
        _selectedDate = DateTime(pickDate.year, pickDate.month, pickDate.day);
      });
    }
  }

  final TextEditingController inputTanggal = TextEditingController();
  final TextEditingController inputJenisImunisasi = TextEditingController();
  final TextEditingController inputJenisVitamin = TextEditingController();
  final TextEditingController inputKeluhan = TextEditingController();

  void AddImunisasi(String jenis_imunisasi, String jenis_vitamin,
      String tanggal_pelayanan, String keluhan) async {
    setState(() {
      isLoading = true;
    });
    try {
      var response = await dio.post('https://posyandu-admin.harysusilo.my.id/api/layanan/imunisasi',
          data: {
            'user_id': id.toString(),
            'jenis_imunisasi': jenis_imunisasi,
            'jenis_vitamin': jenis_vitamin,
            'tanggal_pelayanan': tanggal_pelayanan,
            'keluhan': keluhan,
          });
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Formulir Imunisasi dan Vitamin',
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
              ///imunisasi
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Jenis Imunisasi',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                          borderRadius:
                          BorderRadius.all(Radius.circular(10))),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    dropdownColor: Colors.white,
                    hint: const Text(
                      "Imunisasi",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600),
                    ),
                    value: dropdownValue1,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue1 = newValue!;
                      });
                    },
                    items: <String>['Campak']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              ///vitamin
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Jenis Vitamin',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(8))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                          borderRadius:
                          BorderRadius.all(Radius.circular(8))),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    dropdownColor: Colors.white,
                    hint: const Text(
                      "Imunisasi",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600),
                    ),
                    value: dropdownValue2,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue2 = newValue!;
                      });
                    },
                    items: <String>['Vitamin A+', 'Vitamin C', 'Vitamin B Complex']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87),
                        ),
                      );
                    }).toList(),
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
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
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

              ///submit
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                        WidgetStatePropertyAll(Color(0xff6722d0))),
                    onPressed: () => {AddImunisasi(

                      dropdownValue1!,
                      dropdownValue2!,
                      _selectedDate.toString(),
                      inputKeluhan.text.toString(),
                    )},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 60),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text('Submit', style: TextStyle(color: Colors.white)),
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
                        child: const Text("Batal", style: TextStyle(color: Colors.white),)),
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
