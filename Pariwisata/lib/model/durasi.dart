class Durasi {
  int? id;
  String? Tour;
  int? Hari;
  int? Harga;
  Durasi({this.id, this.Tour, this.Hari, this.Harga});
  factory Durasi.fromJson(Map<String, dynamic> obj) {
    return Durasi(
        id: obj['id'],
        Tour: obj['tour'],
        Hari: obj['days'],
        Harga: obj['cost']);
  }
}
