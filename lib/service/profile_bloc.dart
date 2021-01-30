import 'package:homesaaz/common/dependency_injection.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc {

  BehaviorSubject<int> getCount = BehaviorSubject<int>();

  Stream<int> get getCountData => getCount.stream;

  Future<void> updateCart() async {
    getCount.sink.add(Injector.cartModel?.products?.length ?? 0);
  }
}

final cartBloc = CartBloc();
