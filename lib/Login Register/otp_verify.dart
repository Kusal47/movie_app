		// import 'package:flutter/material.dart';
// import 'package:email_otp/email_otp.dart';
// import 'package:otp_text_field/otp_text_field.dart';
// import 'package:otp_text_field/style.dart';

// class OTPVerificationPage extends StatelessWidget {


//   @override
//   Widget build(BuildContext context) {
//   EmailOTP myauth = EmailOTP();
//   OtpFieldController otp = new OtpFieldController();
//     // return Scaffold(
//     //   appBar: AppBar(
//     //     title: Text("OTP Verification"),
//     //   ),
//     //   body: Center(
//     //     child: Column(
//     //       mainAxisAlignment: MainAxisAlignment.center,
//     //       children: [
//     //         OTPTextField(
//     //           length: 6,
//     //           width: MediaQuery.of(context).size.width,
//     //           fieldWidth: 40,
//     //           style: TextStyle(fontSize: 17),
//     //           textFieldAlignment: MainAxisAlignment.spaceAround,
//     //           fieldStyle: FieldStyle.box,
//     //           onCompleted: (pin) {
//     //             // Called when the user enters the complete OTP
//     //             setState(() {
//     //               enteredOTP = pin;
//     //             });
//     //           },
//     //         ),
//     //         SizedBox(height: 20),
//     //         Text(
//     //           "Entered OTP: $enteredOTP",
//     //           style: TextStyle(fontSize: 20),
//     //         ),
//     //         SizedBox(height: 20),
//     //         ElevatedButton(
//     //           onPressed: () {
//     //             // Verify the OTP here
//     //             if (enteredOTP == "123456") {
//     //               // OTP is correct
//     //               ScaffoldMessenger.of(context).showSnackBar(
//     //                 SnackBar(content: Text("OTP Verified")),
//     //               );
//     //             } else {
//     //               // OTP is incorrect
//     //               ScaffoldMessenger.of(context).showSnackBar(
//     //                 SnackBar(content: Text("Invalid OTP")),
//     //               );
//     //             }
//     //           },
//     //           child: Text("Verify OTP"),
//     //         ),
//     //       ],
//     //     ),
//     //   ),
//     // );

//     return Scaffold(
//       body: Container(
//         child: Padding(
//           padding: const EdgeInsets.all(15),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Card(
//               //   child: Column(
//               //     children: [
//               //       // Padding(
//               //       //   padding: const EdgeInsets.all(8.0),
//               //       //   child: TextFormField(
//               //       //       controller: email,
//               //       //       decoration:
//               //       //           const InputDecoration(hintText: "User Email")),
//               //       // ),
//               //       // ElevatedButton(
//               //       //     onPressed: () async {
//               //       //       myauth.setConfig(
//               //       //         appEmail: "me@rohitchouhan.com",
//               //       //         appName: "Email OTP",
//               //       //         userEmail: email.text,
//               //       //         otpLength: 6,
//               //       //         otpType: OTPType.digitsOnly
//               //       //       );
//               //       //       if (await myauth.sendOTP() == true) {
//               //       //         ScaffoldMessenger.of(context)
//               //       //             .showSnackBar(const SnackBar(
//               //       //           content: Text("OTP has been sent"),
//               //       //         ));
//               //       //       } else {
//               //       //         ScaffoldMessenger.of(context)
//               //       //             .showSnackBar(const SnackBar(
//               //       //           content: Text("Oops, OTP send failed"),
//               //       //         ));
//               //       //       }
//               //       //     },
//               //       //     child: const Text("Send OTP")),

//               //     ],
//               //   ),
//               // ),

//               Card(
//                 child: Column(
//                   children: [
//                     // Padding(
//                     //   padding: const EdgeInsets.all(8.0),
//                     //   child: TextFormField(
//                     //       controller: otp,
//                     //       decoration:
//                     //           const InputDecoration(hintText: "Enter OTP")),
//                     // ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: OTPTextField(
//                         controller: otp,
//                         length: 6,
//                         width: MediaQuery.of(context).size.width,
//                         fieldWidth: 40,
//                         style: TextStyle(fontSize: 17),
//                         textFieldAlignment: MainAxisAlignment.spaceAround,
//                         fieldStyle: FieldStyle.box,
//                         // onCompleted: (pin) {
//                         //   // Called when the user enters the complete OTP
                          
//                         // },
//                       ),
//                     ),
                   
//                     ElevatedButton(
//                         onPressed: () async {
//                           if (await myauth.verifyOTP(otp: otp) == true) {
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(const SnackBar(
//                               content: Text("OTP is verified"),
//                             ));
//                           } else {
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(const SnackBar(
//                               content: Text("Invalid OTP"),
//                             ));
//                           }
//                         },
//                         child: const Text("Verify")),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
