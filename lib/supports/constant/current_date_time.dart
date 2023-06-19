

Map<String, dynamic> getCurrentDate() {
  final now = DateTime.now();

  return {
    'date': now.day,
    'month': now.month,
    'year': now.year,
    'hour': now.hour,
    'minut': now.minute,
    'second': now.second,
  };
}
