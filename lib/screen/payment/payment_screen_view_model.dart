import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/screen/payment/payment_screen.dart';

class PaymentScreenViewModel {
  PaymentScreenState state;

  PaymentScreenViewModel(PaymentScreenState state) {
    this.state = state;
  }
  List<String> paymentImage = [Utils.assetImage('VectorVisaCreditCard'), Utils.assetImage('VectorVisaCreditCard'), Utils.assetImage('VectorVisaCreditCard') ,];

}
