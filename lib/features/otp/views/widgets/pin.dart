import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomOtpField extends StatefulWidget {
  final int length;
  final Function(String) onOtpCompleted;
  final Function() onResendOtp;

  const CustomOtpField({
    super.key,
    required this.length,
    required this.onOtpCompleted,
    required this.onResendOtp,
  });

  @override
  State<CustomOtpField> createState() => _CustomOtpFieldState();
}

class _CustomOtpFieldState extends State<CustomOtpField> {
  final TextEditingController _otpController = TextEditingController();
  bool _isVerifying = false;
  int _resendTimer = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    setState(() => _resendTimer = 30);
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer == 0) {
        timer.cancel();
      } else {
        setState(() => _resendTimer--);
      }
    });
  }

  void _verifyOtp() {
    if (_isVerifying) return;

    if (_otpController.text.length < widget.length) {
      setState(() => _isVerifying = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter the complete OTP")),
      );
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isVerifying = false);
      });
    } else {
      widget.onOtpCompleted(_otpController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: PinCodeTextField(
            appContext: context,
            length: widget.length,
            controller: _otpController,
            autoFocus: true,
            keyboardType: TextInputType.number,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(8.0),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.transparent,
              activeColor: Theme.of(context).primaryColor,
              inactiveColor: Colors.grey,
              selectedColor: Theme.of(context).primaryColor,
            ),
            textStyle: const TextStyle(fontSize: 20),
            // onChanged: (value) {
            //   setState(() {
            //     _otpController.text = value.replaceAll(RegExp(r'[^0-9]'),
            //         ''); //this line will remove any non-numeric character
            //   });
            // },
            // beforeTextPaste: (text) {
            //   return RegExp(r'^\d+$').hasMatch(text ?? "");
            // },
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _verifyOtp,
          child: const Text("Verify OTP"),
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: _resendTimer == 0
              ? () {
                  widget.onResendOtp();
                  _startResendTimer();
                }
              : null,
          child: Text(
            _resendTimer == 0 ? "Resend OTP" : "Resend in $_resendTimer sec",
            style:
                TextStyle(color: _resendTimer == 0 ? Colors.blue : Colors.grey),
          ),
        ),
      ],
    );
  }
}
