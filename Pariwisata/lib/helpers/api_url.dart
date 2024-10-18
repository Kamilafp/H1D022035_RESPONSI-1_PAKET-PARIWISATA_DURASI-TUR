class ApiUrl {
  static const String baseUrl =
      'http://103.196.155.42/api';

  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listDurasi = '$baseUrl/pariwisata/durasi_tur';
  static const String createDurasi = '$baseUrl/pariwisata/durasi_tur';

  static String updateDurasi(int id) {
    return
        '$baseUrl/pariwisata/durasi_tur/$id/update';
  }

  static String showDurasi(int id) {
    return
      '$baseUrl/pariwisata/durasi_tur/$id';
  }

  static String deleteDurasi(int id) {
    return
      '$baseUrl/pariwisata/durasi_tur/$id/delete';
  }
}
