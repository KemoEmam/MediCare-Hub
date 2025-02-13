// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

// class CustomOtpField extends StatelessWidget {
//   final int length;
//   final Function(String) onOtpCompleted;
//   final Function() onResendOtp;
//   final int resendTimer;
//   final bool isLoading;

//   const CustomOtpField({
//     super.key,
//     required this.length,
//     required this.onOtpCompleted,
//     required this.onResendOtp,
//     required this.resendTimer,
//     required this.isLoading,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: PinCodeTextField(
//             appContext: context,
//             length: length,
//             autoFocus: true,
//             keyboardType: TextInputType.number,
//             pinTheme: PinTheme(
//               shape: PinCodeFieldShape.box,
//               borderRadius: BorderRadius.circular(8.0),
//               fieldHeight: 50,
//               fieldWidth: 40,
//               activeFillColor: Colors.transparent,
//               activeColor: Theme.of(context).primaryColor,
//               inactiveColor: Colors.grey,
//               selectedColor: Theme.of(context).primaryColor,
//             ),
//             textStyle: const TextStyle(fontSize: 20),
//             onChanged: (value) {},
//             onCompleted: onOtpCompleted, // Pass OTP to callback
//           ),
//         ),
//         const SizedBox(height: 20),
//         ElevatedButton(
//           onPressed: isLoading ? null : () => onOtpCompleted(''),
//           child: isLoading
//               ? const CircularProgressIndicator()
//               : const Text("Verify OTP"),
//         ),
//         const SizedBox(height: 20),
//         TextButton(
//           onPressed: resendTimer == 0 ? onResendOtp : null,
//           child: Text(
//             resendTimer == 0 ? "Resend OTP" : "Resend in $resendTimer sec",
//             style:
//                 TextStyle(color: resendTimer == 0 ? Colors.blue : Colors.grey),
//           ),
//         ),
//       ],
//     );
//   }
// }
