import 'package:homesaaz/model/address_model.dart';
import 'package:homesaaz/screen/address/address_screen.dart';

class AddressScreenViewModel {
  AddressScreenState state;
  List<AddressModel> list = List();

  AddressScreenViewModel(AddressScreenState state) {
    this.state = state;
    listOfData();
  }

  listOfData() {
    list.add(AddressModel(
        "Shewrapara, Mirpur, Delhi-1216\nHouse no: 938\nRoad no: 9"));
    list.add(AddressModel("Chatkhil, Noakhali\nHouse no: 22\nRoad no: 7"));

  }
}
