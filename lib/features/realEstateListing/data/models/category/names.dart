class Names {
  String? enUs;
  String? arIq;
  String? kuIq;

  Names({this.enUs, this.arIq, this.kuIq});

  factory Names.fromJson(Map<String, dynamic> json) => Names(
        enUs: json['en-US'] as String?,
        arIq: json['ar-IQ'] as String?,
        kuIq: json['ku-IQ'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'en-US': enUs,
        'ar-IQ': arIq,
        'ku-IQ': kuIq,
      };
}
