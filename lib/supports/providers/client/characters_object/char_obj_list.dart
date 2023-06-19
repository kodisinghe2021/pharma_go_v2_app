import 'package:pharma_go_v2_app/app/model/client/extracted_char/extracted_char.dart';


  List<ExtractedCharModel> _extractedCharObjectList = [];

   void setObjectList(List<ExtractedCharModel> list) {
    _extractedCharObjectList = list;
  }

  List<ExtractedCharModel> get getObjectList => _extractedCharObjectList;

