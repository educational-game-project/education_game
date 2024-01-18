class ErrorCatch {
  final String? value, constraint, property;
  ErrorCatch({
    this.value,
    this.constraint,
    this.property,
  });

  factory ErrorCatch.fromJson(Map<String, dynamic> json) {
    return ErrorCatch(
      value: json['value'],
      constraint: json['constraint'],
      property: json['property'],
    );
  }
}
