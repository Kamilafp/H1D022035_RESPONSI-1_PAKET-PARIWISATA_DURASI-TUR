import 'package:flutter/material.dart';
import 'package:pariwisata/bloc/logout_bloc.dart';
import 'package:pariwisata/bloc/durasi_bloc.dart';
import 'package:pariwisata/model/durasi.dart';
import 'package:pariwisata/ui/login_page.dart';
import 'package:pariwisata/ui/durasi_detail.dart';
import 'package:pariwisata/ui/durasi_form.dart';

class DurasiPage extends StatefulWidget {
  const DurasiPage({Key? key}) : super(key: key);

  @override
  _DurasiPageState createState() => _DurasiPageState();
}

class _DurasiPageState extends State<DurasiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6D5CF), // Background color
      appBar: AppBar(
        title: const Text(
          'List Durasi Tur',
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Title text color to white
          ),
        ),
        backgroundColor: const Color(0xFF202229), // Dark gray AppBar background
        iconTheme: const IconThemeData(color: Colors.white), // Toggle icon color to white
      ),
      drawer: Drawer(
        child: Container(
          color: const Color(0xFF202229), // Drawer background color same as AppBar
          child: ListView(
            children: [
              ListTile(
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 16,
                    color: Colors.white, // List tile text color set to white
                  ),
                ),
                trailing: const Icon(Icons.logout, color: Colors.white), // Icon color set to white
                onTap: () async {
                  await LogoutBloc.logout().then((value) => {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                            (route) => false)
                  });
                },
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          FutureBuilder<List>(
            future: DurasiBloc.getDurasis(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? ListDurasi(
                list: snapshot.data,
              )
                  : const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF202229), // Loading indicator color
                ),
              );
            },
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DurasiForm()));
              },
              backgroundColor: const Color(0xFF202229), // Button color
              child: const Icon(Icons.add, color: Colors.white), // Plus icon
            ),
          ),
        ],
      ),
    );
  }
}

class ListDurasi extends StatelessWidget {
  final List? list;

  const ListDurasi({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemDurasi(
            durasi_tur: list![i],
          );
        });
  }
}

class ItemDurasi extends StatelessWidget {
  final Durasi durasi_tur;

  const ItemDurasi({Key? key, required this.durasi_tur}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DurasiDetail(
                  durasi_tur: durasi_tur,
                )));
      },
      child: Card(
        color: const Color(0xFF282D33), // Card background color set to #282d33
        child: ListTile(
          title: Text(
            durasi_tur.Hari.toString(),
            style: const TextStyle(
              fontFamily: 'Georgia',
              fontSize: 18,
              color: Colors.white, // Main text color set to white for contrast
            ),
          ),
          subtitle: Text(
            durasi_tur.Harga.toString(),
            style: const TextStyle(
              fontFamily: 'Georgia',
              fontSize: 14,
              color: Colors.grey, // Subtitle color
            ),
          ),
          trailing: Text(
            durasi_tur.Tour!,
            style: const TextStyle(
              fontFamily: 'Georgia',
              fontSize: 16,
              color: Colors.white, // Trailing text color set to white for contrast
            ),
          ),
        ),
      ),
    );
  }
}

