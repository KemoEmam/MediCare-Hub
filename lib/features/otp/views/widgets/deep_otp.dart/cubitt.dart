// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'auth_repository.dart';

// part 'otp_state.dart';

// class OtpCubit extends Cubit<OtpState> {
//   final AuthRepository authRepository;
//   Timer? _resendTimer;
//   late String phoneNumber; // Store phone number here

//   OtpCubit({required this.authRepository}) : super(OtpInitial(resendTimer: 30));

//   void setPhoneNumber(String phone) {
//     phoneNumber = phone;
//   }

//   void startResendTimer() {
//     _resendTimer?.cancel();
//     int timer = 30;
//     emit(state.copyWith(resendTimer: timer));

//     _resendTimer = Timer.periodic(const Duration(seconds: 1), (_) {
//       if (timer > 0) {
//         emit(state.copyWith(resendTimer: --timer));
//       } else {
//         _resendTimer?.cancel();
//       }
//     });
//   }

//   Future<void> verifyOtp(String otp) async {
//     emit(OtpVerifying());
//     try {
//       await authRepository.verifyOtp(otp);
//       emit(OtpVerified());
//     } catch (e) {
//       emit(OtpError(e.toString()));
//     }
//   }

//   Future<void> resendOtp() async {
//     emit(OtpResending());
//     try {
//       await authRepository.requestOtp(phoneNumber); // Reuse requestOtp
//       startResendTimer();
//       emit(OtpInitial(resendTimer: 30));
//     } catch (e) {
//       emit(OtpError(e.toString()));
//     }
//   }

//   @override
//   Future<void> close() {
//     _resendTimer?.cancel();
//     return super.close();
//   }
// }
