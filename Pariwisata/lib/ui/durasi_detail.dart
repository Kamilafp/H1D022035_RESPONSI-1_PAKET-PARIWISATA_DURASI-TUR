import 'package:flutter/material.dart';
import 'package:pariwisata/bloc/durasi_bloc.dart';
import 'package:pariwisata/model/durasi.dart';
import 'package:pariwisata/ui/durasi_form.dart';
import 'package:pariwisata/ui/durasi_page.dart';
import 'package:pariwisata/widget/warning_dialog.dart';

// ignore: must_be_immutable
class DurasiDetail extends StatefulWidget {
  Durasi? durasi_tur;

  DurasiDetail({Key? key, this.durasi_tur}) : super(key: key);

  @override
  _DurasiDetailState createState() => _DurasiDetailState();
}

class _DurasiDetailState extends State<DurasiDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6D5CF), // Background consistent with other pages
      appBar: AppBar(
        title: const Text(
          'Detail Durasi Tur',
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white, // White text for AppBar
          ),
        ),
        backgroundColor: const Color(0xFF202229), // Dark gray AppBar
        iconTheme: const IconThemeData(
          color: Colors.white, // White back arrow
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align texts to the left
          children: [
            _buildTextDetail("Jenis Tur", widget.durasi_tur!.Tour!),
            const SizedBox(height: 16),
            _buildTextDetail("Lama Tur", widget.durasi_tur!.Hari.toString()),
            const SizedBox(height: 16),
            _buildTextDetail("Harga", "Rp. ${widget.durasi_tur!.Harga}"),
            const SizedBox(height: 32),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _buildTextDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Georgia',
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Color(0xFF202229), // Dark gray text color for label
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Georgia',
            fontSize: 16.0,
            color: Color(0xFF202229), // Dark gray text for value
          ),
        ),
      ],
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Tombol Edit
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF202229), // Dark button color
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          ),
          child: const Text(
            "EDIT",
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Button text color
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DurasiForm(
                  durasi_tur: widget.durasi_tur!,
                ),
              ),
            );
          },
        ),
        // Tombol Hapus
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFF202229)), // Dark gray border
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          ),
          child: const Text(
            "DELETE",
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF202229), // Dark gray text color for delete button
            ),
          ),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text(
        "Yakin ingin menghapus data ini?",
        style: TextStyle(
          fontFamily: 'Georgia',
          fontSize: 16,
          color: Color(0xFF202229), // Dark gray text in dialog
        ),
      ),
      actions: [
        //tombol hapus
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFF202229)),
          ),
          child: const Text(
            "Ya",
            style: TextStyle(
              fontFamily: 'Georgia',
              fontWeight: FontWeight.bold,
              color: Color(0xFF202229),
            ),
          ),
          onPressed: () {
            DurasiBloc.deleteDurasi(id: widget.durasi_tur!.id!).then(
                    (value) => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DurasiPage()))
                }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                    description: "Hapus gagal, silahkan coba lagi",
                  ));
            });
          },
        ),
        //tombol batal
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFF202229)),
          ),
          child: const Text(
            "Batal",
            style: TextStyle(
              fontFamily: 'Georgia',
              fontWeight: FontWeight.bold,
              color: Color(0xFF202229),
            ),
          ),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
