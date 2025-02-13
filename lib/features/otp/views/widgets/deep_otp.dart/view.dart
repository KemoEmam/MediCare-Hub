// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medi_care_hub/features/otp/views/widgets/deep_otp.dart/custom_pin.dart';
// import 'otp_cubit.dart';
// import 'custom_otp_field.dart';

// class OtpVerificationScreen extends StatelessWidget {
//   const OtpVerificationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Verify OTP")),
//       body: BlocProvider(
//         create: (context) => OtpCubit(authRepository: context.read()),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               BlocBuilder<OtpCubit, OtpState>(
//                 builder: (context, state) {
//                   return Text(
//                     "Enter the OTP sent to ${context.read<OtpCubit>().phoneNumber}",
//                     style: const TextStyle(fontSize: 18),
//                   );
//                 },
//               ),
//               const SizedBox(height: 20),
//               BlocConsumer<OtpCubit, OtpState>(
//                 listener: (context, state) {
//                   if (state is OtpVerified) {
//                     Navigator.pushReplacementNamed(context, "/home");
//                   } else if (state is OtpError) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text(state.message)),
//                     );
//                   }
//                 },
//                 builder: (context, state) {
//                   return CustomOtpField(
//                     length: 6,
//                     onOtpCompleted: (otp) => context.read<OtpCubit>().verifyOtp(otp),
//                     onResendOtp: () => context.read<OtpCubit>().resendOtp(),
//                     resendTimer: state.resendTimer,
//                     isLoading: state is OtpVerifying,
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
