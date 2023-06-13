class ExtractedCharModel {
  String? name;
  String? dosageInNote;
  String? frequency;
  String? days;

  ExtractedCharModel.fromJson(Map<String, dynamic> dataMap) {
    name = dataMap['name'];
    dosageInNote = dataMap['dosage_in_note'];
    frequency = dataMap['frequency'];
    days = dataMap['days'];
  }
  
}
