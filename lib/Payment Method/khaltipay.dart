import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import '../const/export.dart';


class KhaltiApp extends StatefulWidget {
  const KhaltiApp(
      {super.key, this.price, this.productId, this.isTotalAmt = false});
  final double? price;
  final int? productId;
  final bool isTotalAmt;
  @override
  State<KhaltiApp> createState() => _KhaltiAppState();
}

class _KhaltiAppState extends State<KhaltiApp> {
  String referenceId = '';
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        payKhalti();
      },
      child: Container(
        height: 60,
        width: 110,
        child: Image.asset(
          AssetsPath.khalti,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  payKhalti() {
    KhaltiScope.of(context).pay(
        config: PaymentConfig(
          amount: widget.price!.toInt() * 100,
          productIdentity: widget.productId.toString(),
          productName: 'Product Name',
          mobile: '9840454804',
          mobileReadOnly: true,
        ),
        preferences: [PaymentPreference.khalti],
        onSuccess: onSuccess,
        onFailure: onFailure,
        onCancel: onCancel);
  }

  void onSuccess(PaymentSuccessModel success) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Payment Success'),
              content: Text('Reference Id: ${success.idx}'),
              actions: [
                InkWell(
                    onTap: () {
                      setState(() {
                        referenceId = success.idx;
                      });
                    
                    },
                    child: Text('Ok'))
              ],
            ));
  }

  void onFailure(PaymentFailureModel failure) {
    debugPrint(failure.toString());
  }

  void onCancel() {
    debugPrint('Cancelled');
  }
}
