import 'package:flutter/material.dart';
import 'package:posyandu/data/models/layanan_models.dart';
import 'package:posyandu/presentation/widget/formImunisasi.dart';
import 'package:posyandu/presentation/widget/theme.dart';

class Listlayanan extends StatelessWidget {
  const Listlayanan({super.key, required this.layananSurat});
  final List<Surat> layananSurat;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: layananSurat.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormImunisasi(),
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
                    const Text('Imunisasi dan Vitamin',
                        style: TextStyle(fontSize: 14, color: Colors.black)),
                    Text(
                      layananSurat[index].name,
                      style: mediumWhiteTextStyle.copyWith(fontSize: 12),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                      style: ElevatedButton.styleFrom(
                          elevation: 8,
                          textStyle: const TextStyle(color: Colors.white)),
                      child: const Text(
                        'Elevated Button',
                        style: TextStyle(fontSize: 8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Image.asset(
                  'assets/images/ibu-hamil.jpg',
                  width: 96,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
