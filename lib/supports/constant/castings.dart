
String extractInt(String char)=> char.replaceAll(RegExp(r'[^0-9]'),'');
double extractDouble(String char)=> double.parse(char.replaceAll(RegExp(r'[^0-9]'),''));