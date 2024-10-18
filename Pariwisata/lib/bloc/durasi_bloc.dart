import 'dart:convert';
import 'package:pariwisata/helpers/api.dart';
import 'package:pariwisata/helpers/api_url.dart';
import 'package:pariwisata/model/durasi.dart';

class DurasiBloc {
  static Future<List<Durasi>> getDurasis() async {
    String apiUrl = ApiUrl.listDurasi;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listDurasi = (jsonObj as Map<String, dynamic>)['data'];
    List<Durasi> durasi_turs = [];
    for (int i = 0; i < listDurasi.length; i++) {
      durasi_turs.add(Durasi.fromJson(listDurasi[i]));
    }
    return durasi_turs;
  }

  static Future addDurasi({Durasi? durasi_tur}) async {
    String apiUrl = ApiUrl.createDurasi;

    var body = {
      "tour": durasi_tur!.Tour,
      "days": durasi_tur.Hari.toString(),
      "cost": durasi_tur.Harga.toString()
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateDurasi({required Durasi durasi_tur}) async {
    String apiUrl = ApiUrl.updateDurasi(durasi_tur.id!);
    print(apiUrl);

    var body = {
      "tour": durasi_tur.Tour,
      "days": durasi_tur.Hari,
      "cost": durasi_tur.Harga
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteDurasi({int? id}) async {
    String apiUrl = ApiUrl.deleteDurasi(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
