class Tugas {
  final String matakuliah;
  final String perintah;
  final String deskripsi;
  final String tenggatwaktu;
  final String pengumpulan;

  Tugas({
    required this.matakuliah,
    required this.perintah,
    required this.tenggatwaktu,
    required this.deskripsi,
    required this.pengumpulan,
  });

  factory Tugas.fromJson(Map<String, dynamic> json) {
    return Tugas(
      matakuliah: json['mata kuliah'],
      perintah: json['perintah'],
      deskripsi: json['deskripsi'],
      tenggatwaktu: json['tenggat waktu'],
      pengumpulan: json['pengumpulan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mata kuliah': matakuliah,
      'perintah': perintah,
      'deskripsi': deskripsi,
      'tenggat waktu': tenggatwaktu,
      'pengumpulan': pengumpulan,
    };
  }
}
