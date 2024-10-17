import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:posyandu/presentation/widget/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Dio dio = Dio();
  File? fotoProfile;
  var id = 0;
  var usia = 0;
  String token = "";
  String? dropdownValue1 = "laki_laki";
  DateTime? _selectedDateAnak;
  DateTime? _selectedDateIbu;
  final DateFormat formatter =
  DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getInt('id')!;
      token = prefs.getString('token')!;
      print(id);
      print(token);
    });
  }

  void _presentDatePickerAnak() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 40, now.month, now.day);
    final lastDate = DateTime(now.year + 5, now.month, now.day);

    final pickDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickDate != null) {
      setState(() {
        _selectedDateAnak = DateTime(pickDate.year, pickDate.month, pickDate.day);
      });
    }
  }

  void _presentDatePickerIbu() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 40, now.month, now.day);
    final lastDate = DateTime(now.year + 5, now.month, now.day);

    final pickDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickDate != null) {
      setState(() {
        _selectedDateIbu = DateTime(pickDate.year, pickDate.month, pickDate.day);
      });
    }
  }

  ProfileEdit(String alamat, String no_hp, String nik_anak, String nama_ibu, String tgl_lahir_ibu, String nama_anak,
      String tgl_lahir, String jenis_kelamin, String usia) async {
    var formData = FormData();
    formData.fields.add(MapEntry("alamat", alamat));
    print(alamat);
    formData.fields.add(MapEntry("no_hp", no_hp));
    print(no_hp);
    formData.fields.add(MapEntry("nik_anak", nik_anak));
    print(nik_anak);
    formData.fields.add(MapEntry("nama_ibu", nama_ibu));
    formData.fields.add(MapEntry("tgl_lahir_ibu", tgl_lahir_ibu));
    print(nama_ibu);
    print(tgl_lahir_ibu);
    formData.fields.add(MapEntry("nama_anak", nama_anak));
    print(nama_anak);
    formData.fields.add(MapEntry("tgl_lahir", tgl_lahir));
    print(tgl_lahir);
    formData.fields.add(MapEntry("jenis_kelamin", jenis_kelamin));
    print(jenis_kelamin);
    formData.fields.add(MapEntry("usia", usia));
    print(usia);
    var response =
    await dio.post('https://posyandu-admin.harysusilo.my.id/api/auth/edit-profile/$id',
        data: formData,
        options: Options(
            headers: {
              'Content-Type': 'multipart/form-data',
              'Authorization': token,
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }));
    print("response data : ${response.data}");
    if (response.data['success'] == true) {
      Navigator.pop(context);
      AlertDialog alert = const AlertDialog(
        icon: Icon(
          CupertinoIcons.checkmark_seal_fill,
          size: 20,
          color: Color(0xff009382),
        ),
        title: Text("Berhasil"),
        content: Text("berhasil melakukan perubahan profile"),
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
    print("response ${response.data}");
  }

  final TextEditingController inputUsername = TextEditingController();
  final TextEditingController inputPassword = TextEditingController();
  final TextEditingController inputAlamat = TextEditingController();
  final TextEditingController inputHP = TextEditingController();
  final TextEditingController inputNikAnak = TextEditingController();
  final TextEditingController inputNamaIbu = TextEditingController();
  final TextEditingController inputNamaAnak = TextEditingController();
  final TextEditingController inputUsia = TextEditingController();
  final TextEditingController inputKelamin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: darkblue,
        body: Padding(
          padding:
          const EdgeInsets.only(right: 20, left: 20, top: 45, bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Edit Profile',
                      textAlign: TextAlign.start,
                      style: semiboldwhitetext.copyWith(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Ubah data yang diperlukan, dan isi form lain dengan data yang sama',
                  textAlign: TextAlign.start,
                  style: semiboldwhitetext.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Alamat",
                      textAlign: TextAlign.left,
                      style: regularwhitetext.copyWith(fontSize: 14),
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
                        controller: inputAlamat,
                        decoration: InputDecoration(
                          hintText: 'Alamat rumah',
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
                  ],
                ),

                const SizedBox(height: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nomor HP",
                      textAlign: TextAlign.left,
                      style: regularwhitetext.copyWith(fontSize: 14),
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
                        controller: inputHP,
                        decoration: InputDecoration(
                          hintText: 'Masukan Nomor HP',
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
                  ],
                ),
                const SizedBox(height: 18),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "NIK Anak",
                      textAlign: TextAlign.left,
                      style: regularwhitetext.copyWith(fontSize: 14),
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
                        controller: inputNikAnak,
                        decoration: InputDecoration(
                          hintText: 'Masukan NIK Anak',
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
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama Ibu",
                      textAlign: TextAlign.left,
                      style: regularwhitetext.copyWith(fontSize: 14),
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
                        controller: inputNamaIbu,
                        decoration: InputDecoration(
                          hintText: 'Masukan Nama Ibu',
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
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama Anak",
                      textAlign: TextAlign.left,
                      style: regularwhitetext.copyWith(fontSize: 14),
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
                        controller: inputNamaAnak,
                        decoration: InputDecoration(
                          hintText: 'Masukan Nama Anak',
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
                  ],
                ),

                buildAnakSection(
                    'Tanggal Lahir Anak', 'Masukan tanggal', TextInputType.datetime,
                    isDate: true),

                const SizedBox(height: 18),

                buildIbuSection(
                    'Tanggal Lahir Ibu', 'Masukan tanggal', TextInputType.datetime,
                    isDate: true),

                const SizedBox(height: 18),

                ///usia
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Usia",
                      textAlign: TextAlign.left,
                      style: regularwhitetext.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    // ignore: avoid_unnecessary_containers
                    Container(
                      height: 50,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
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
                        controller: inputUsia,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Umur',
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
                  ],
                ),

                const SizedBox(height: 18),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jenis Kelamin",
                      textAlign: TextAlign.left,
                      style: regularwhitetext.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField(
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      dropdownColor: Colors.white,
                      hint: const Text(
                        "Kelamin",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600),
                      ),
                      value: dropdownValue1,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue1 = newValue!;
                        });
                        print("dropdown : $dropdownValue1");
                      },
                      items: <String>['laki_laki', 'perempuan']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                      WidgetStatePropertyAll(Color(0xff0092af))),
                  onPressed: () => {
                    ProfileEdit(
                      inputAlamat.text.toString(),
                      inputHP.text,
                      inputNikAnak.text.toString(),
                      inputNamaIbu.text.toString(),
                      _selectedDateIbu.toString(),
                      inputNamaAnak.text.toString(),
                      _selectedDateAnak.toString(),
                      dropdownValue1!,
                      inputUsia.text,
                        // fotoProfile
                    )
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 60),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text('Daftar', style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAnakSection(
      String label, String hintText, TextInputType inputType,
      {bool isDate = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.white)),
        const SizedBox(height: 8),
        isDate ? buildDateAnak() : buildTextFieldAnak(hintText, inputType),
      ],
    );
  }

  Widget buildIbuSection(
      String label, String hintText, TextInputType inputType,
      {bool isDate = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.white)),
        const SizedBox(height: 8),
        isDate ? buildDateIbu() : buildTextFieldIbu(hintText, inputType),
      ],
    );
  }

  Widget buildTextFieldAnak(String hintText, TextInputType inputType) {
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

  Widget buildTextFieldIbu(String hintText, TextInputType inputType) {
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

  ///anak
  Widget buildDateAnak() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        border: Border.all(color: Colors.lightBlueAccent),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _selectedDateAnak == null
                ? 'Masukan tanggal'
                : formatter.format(_selectedDateAnak!),
            style: const TextStyle(color: Colors.black45, fontWeight: FontWeight.w500),
          ),
          IconButton(
            onPressed: _presentDatePickerAnak,
            icon: const Icon(Icons.calendar_today, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget buildDateIbu() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        border: Border.all(color: Colors.lightBlueAccent),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _selectedDateIbu == null
                ? 'Masukan tanggal'
                : formatter.format(_selectedDateIbu!),
            style: const TextStyle(color: Colors.black45, fontWeight: FontWeight.w500),
          ),
          IconButton(
            onPressed: _presentDatePickerIbu,
            icon: const Icon(Icons.calendar_today, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}

