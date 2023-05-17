import 'package:logger/logger.dart';


class TimeProvider {
  List<String> getCurrentDate() {
    List<String> currentTime = [];
    final DateTime now = DateTime.now();

    final String formattedDate = '${now.month}/${now.day}/${now.year}';

    final String formattedTime = '${now.hour}:${now.minute}';

    currentTime.insert(0, formattedDate);
    currentTime.insert(1, formattedTime);
    Logger().i(currentTime);
    return currentTime;
  }
}
