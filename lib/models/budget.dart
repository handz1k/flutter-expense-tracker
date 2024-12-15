class Budget {
  int id;
  final String source;
  final double amount;

  Budget(this.id, this.source, this.amount);
  Map toJson() => {
        'id': id,
        'source': source,
        'amount': amount,
      };

  factory Budget.fromJson(Map json) {
    return Budget(json['id'], json['source'], json['amount']);
  }
}
