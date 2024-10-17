import 'package:flutter/material.dart';
import 'package:posyandu/presentation/navbarBottom.dart';
import 'package:posyandu/presentation/pages/history/historyIbuHamil.dart';
import 'package:posyandu/presentation/pages/history/historyImunisasi.dart';
import 'package:posyandu/presentation/pages/history/historyTimbang.dart';


class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int pageIndex = 0;

  final pages = [
    const HistoryImunisasi(),
    const HistoryTimbang(),
    const HistoryTimbang(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4 ,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff1e3883),
          title: const Text("History Layanan", style: TextStyle(fontSize: 16, color: Colors.white),),
          leading: BackButton(
            onPressed: () => const NavbarBot(),
          ),
          bottom: const TabBar(
            dividerColor: Colors.white,

            tabs: [
              Tab(child: Text('Imunisasi', style: TextStyle(color: Colors.white),),),
              Tab(child: Text('Timbang', style: TextStyle(color: Colors.white),),),
              Tab(child: Text('Ibu Hamil', style: TextStyle(color: Colors.white),),),
            ],
          ),
        ),
        body:Container(
          color: const Color(0xffE3E9EB),
          child: const TabBarView(
            children: [
              HistoryImunisasi(),

              HistoryTimbang(),

              HistoryIbuHamil(),
            ],
          ),
        ),
      ),
    );
  }
}