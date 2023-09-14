import 'package:cloud_firestore/cloud_firestore.dart';

class PurchaseOrderService {
  Future<void> createPurchaseOrderCollection(
    String userId,
    String movieName,
    int quantity,
    String showType,
  ) async {
    final purchaseorderCollection =
        FirebaseFirestore.instance.collection('Purchase_Order_$userId');

    double price = 0;

    // Calculate the price based on the selected show type
    if (showType == 'Morning Show') {
      price = 175.0;
    } else if (showType == 'Evening Show') {
      price = 200.0;
    } else if (showType == 'Night Show') {
      price = 150.0;
    }

    await purchaseorderCollection.add({
      'name': movieName,
      'showType': showType,
      'quantity': quantity,
      'price': price * quantity,
    });
  }
}