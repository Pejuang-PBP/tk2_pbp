class Tanya {
  final String pertanyaan;
  final String jawaban;

  Tanya({required this.pertanyaan, required this.jawaban});

  factory Tanya.fromJson(Map<String, dynamic> json) {
    return Tanya(
      pertanyaan: json['pertanyaan'],
      jawaban: json['jawaban'],
    );
  }

  Map<String, dynamic> toJson() => {
    'pertanyaan' : pertanyaan,
    'jawaban': jawaban,
  };
}