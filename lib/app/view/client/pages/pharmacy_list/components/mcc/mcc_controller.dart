import 'package:get/get.dart';
import 'package:pharma_go_v2_app/app/model/client/cart/cart_model.dart';
import 'package:pharma_go_v2_app/app/model/pharmacy_strock_card.dart';
import 'package:pharma_go_v2_app/supports/constant/castings.dart';

/*

this controller class is belongs to "MedicineCardComp" class

 */

class MCCController extends GetxController {
// calculate the price of each medicine
  double getMedicinePrice(MedicineCardModel mccmedicineCardModel) {
    //calculate total dosage
    double totalDosage = extractDouble(mccmedicineCardModel.days.toString()) *
        extractDouble(mccmedicineCardModel.frequency.toString()) *
        extractDouble(mccmedicineCardModel.dosageInNote.toString());

    //return each medicine price
    return extractDouble(mccmedicineCardModel.price.toString()) *
        (totalDosage /
            extractDouble(mccmedicineCardModel.dosageInMedicine.toString()));
  }

  void setModel(CartModel model) {
    setModelToCartList(model);
  }
  
}

List<CartModel> _cartmodelList = [];

void setModelToCartList(CartModel model) {
  _cartmodelList.insert(0, model);
}

List<CartModel> get getCartItemLsit => _cartmodelList;
