import 'package:flutter/material.dart';
import 'package:pariwisata/bloc/durasi_bloc.dart';
import 'package:pariwisata/model/durasi.dart';
import 'package:pariwisata/ui/durasi_page.dart';
import 'package:pariwisata/widget/warning_dialog.dart';

// ignore: must_be_immutable
class DurasiForm extends StatefulWidget {
  Durasi? durasi_tur;
  DurasiForm({Key? key, this.durasi_tur}) : super(key: key);

  @override
  _DurasiFormState createState() => _DurasiFormState();
}

class _DurasiFormState extends State<DurasiForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH TOUR";
  String tombolSubmit = "SIMPAN";
  final _TourTextboxController = TextEditingController();
  final _HariTextboxController = TextEditingController();
  final _HargaTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.durasi_tur != null) {
      setState(() {
        judul = "UBAH TOUR";
        tombolSubmit = "UBAH";
        _TourTextboxController.text = widget.durasi_tur!.Tour ?? '';
        _HariTextboxController.text = widget.durasi_tur!.Hari?.toString() ?? '';
        _HargaTextboxController.text = widget.durasi_tur!.Harga?.toString() ?? '';
      });
    } else {
      judul = "TAMBAH TOUR";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6D5CF), // Same background as DurasiPage
      appBar: AppBar(
        title: Text(
          judul,
          style: const TextStyle(
            fontFamily: 'Georgia',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white, // White text
          ),
        ),
        backgroundColor: const Color(0xFF202229), // Dark gray AppBar
        iconTheme: const IconThemeData(
          color: Colors.white, // Set back arrow color to white
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Add more padding for cleaner layout
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _TourTextField(),
                const SizedBox(height: 16),
                _HariTextField(),
                const SizedBox(height: 16),
                _HargaTextField(),
                const SizedBox(height: 24),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _TourTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Jenis Tur",
        labelStyle: TextStyle(
          fontFamily: 'Georgia',
          color: Color(0xFF202229), // Label color
        ),
        filled: true,
        fillColor: Color(0xFFE4E2DC), // Form field background
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.text,
      controller: _TourTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Jenis Tur harus diisi";
        }
        return null;
      },
    );
  }

  Widget _HariTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Durasi",
        labelStyle: TextStyle(
          fontFamily: 'Georgia',
          color: Color(0xFF202229), // Label color
        ),
        filled: true,
        fillColor: Color(0xFFE4E2DC), // Form field background
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      controller: _HariTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Durasi harus diisi";
        } else if (int.tryParse(value) == null) {
          return "Durasi harus berupa angka";
        }
        return null;
      },
    );
  }

  Widget _HargaTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Harga",
        labelStyle: TextStyle(
          fontFamily: 'Georgia',
          color: Color(0xFF202229), // Label color
        ),
        filled: true,
        fillColor: Color(0xFFE4E2DC), // Form field background
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      controller: _HargaTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Harga harus diisi";
        } else if (int.tryParse(value) == null) {
          return "Harga harus berupa angka";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF202229), // Dark button color
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Text(
          tombolSubmit,
          style: const TextStyle(
            fontFamily: 'Georgia',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Button text color
          ),
        ),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.durasi_tur != null) {
                // kondisi update produk
                ubah();
              } else {
                // kondisi tambah produk
                simpan();
              }
            }
          }
        },
      ),
    );
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Durasi createDurasi = Durasi(id: null);
    createDurasi.Tour = _TourTextboxController.text;
    createDurasi.Hari = int.parse(_HariTextboxController.text);
    createDurasi.Harga = int.parse(_HargaTextboxController.text);

    DurasiBloc.addDurasi(durasi_tur: createDurasi).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const DurasiPage()));
    }, onError: (error) {
      setState(() {
        _isLoading = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Simpan gagal, silahkan coba lagi",
          ));
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Durasi updateDurasi = Durasi(id: widget.durasi_tur!.id!);
    updateDurasi.Tour = _TourTextboxController.text;
    updateDurasi.Hari = int.parse(_HariTextboxController.text);
    updateDurasi.Harga = int.parse(_HargaTextboxController.text);

    DurasiBloc.updateDurasi(durasi_tur: updateDurasi).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const DurasiPage()));
    }, onError: (error) {
      setState(() {
        _isLoading = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Permintaan ubah data gagal, silahkan coba lagi",
          ));
    });
  }
}
