class Quote {
  late String qoute;
  Quote({
    required this.qoute,
  });

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      qoute: map['quote'],
    );
  }
}
