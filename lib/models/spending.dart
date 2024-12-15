class Spending {
  int id;
  final String source;
  final double amount;

  Spending(this.id, this.source, this.amount);
  Map toJson() => {
        'id': id,
        'source': source,
        'amount': amount,
      };

  factory Spending.fromJson(Map json) {
    return Spending(json['id'], json['source'], json['amount']);
  }
}
