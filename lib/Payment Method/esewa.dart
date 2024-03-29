// import 'package:esewa_flutter/esewa_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:movieapp/const/assets_path.dart';

// class EsewaApp extends StatefulWidget {
//   const EsewaApp({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<EsewaApp> createState() => _EsewaAppState();
// }

// class _EsewaAppState extends State<EsewaApp> {
//   String refId = '';
//   String hasError = '';
//   double? price; // Store the price retrieved from Firestore

//   @override
//   void initState() {
//     super.initState();
//     // Call the fetchPrice function from FirebaseService when the widget is initialized
//     fetchPrice();
//   }

//   // Function to fetch the price from Firestore
//   Future<void> fetchPrice() async {
//     final fetchedPrice = await FirebaseService.fetchPrice();
//     if (fetchedPrice != null) {
//       setState(() {
//         price = fetchedPrice;
        
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           InkWell(
//             onTap: () async {
//               print(price);
//               await Esewa.i.init(
//                 context: context,
//                 eSewaConfig: ESewaConfig.dev(
//                     // .live for live
//                     su: 'https://www.marvel.com/hello',
//                     amt: price!,
//                     fu: 'https://www.marvel.com/hello',
//                     pid: '',
//                     serverUrl: 'https://uat.esewa.com.np/epay/main?',
//                     scd: 'EPAYTEST'),
//               );
//             },
//             child: Container(
//               height: 60,
//               width: 110,
//               child: Image.asset(
//                 AssetsPath.esewa,
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),
//           if (refId.isNotEmpty)
//             Text('Console: Payment Success, Ref Id: $refId'),
//           if (hasError.isNotEmpty)
//             Text('Console: Payment Failed, Message: $hasError'),
//         ],
//       ),
//     );
//   }
// }
