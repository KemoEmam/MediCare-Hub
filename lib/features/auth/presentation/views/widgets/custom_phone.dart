import 'package:flutter/material.dart';
import 'package:medi_care_hub/core/themes/styles/app_text_styles.dart';
import 'package:phone_form_field/phone_form_field.dart';

class CustomPhoneFormField extends StatelessWidget {
  final String hintText;
  final TextStyle? hintTextStyle;
  final Widget? prefixIcon;
  final Color? prefixIconColor;
  final Widget? suffixIcon;
  final Color? suffixIconColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color enabledBorderColor;
  final Color? fillColor;
  final double borderRadius;
  final String labelText;
  final TextStyle? labelTextStyle;
  final dynamic Function(PhoneNumber)? onChanged;

  const CustomPhoneFormField({
    super.key,
    required this.hintText,
    this.hintTextStyle,
    this.prefixIcon,
    this.prefixIconColor,
    this.suffixIcon,
    this.suffixIconColor,
    this.borderColor = Colors.grey,
    this.focusedBorderColor = Colors.blue,
    this.enabledBorderColor = const Color(0xffeff2f2),
    this.fillColor,
    this.borderRadius = 16,
    this.onChanged,
    required this.labelText,
    this.labelTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return PhoneFormField(
      initialValue: const PhoneNumber(isoCode: IsoCode.EG, nsn: ''),
      decoration: InputDecoration(
        labelText: labelText, //label text instead of hint text
        labelStyle: labelTextStyle ??
            AppTextStyles.interMedium14
                .copyWith(color: const Color(0xffC2C2C2)),
        hintText: hintText,
        hintStyle: hintTextStyle,
        prefixIcon: prefixIcon,
        prefixIconColor: prefixIconColor,
        suffixIcon: suffixIcon,
        suffixIconColor: suffixIconColor ?? Colors.grey,
        fillColor: fillColor,
        filled: fillColor != null,
        border: _borderBuilder(borderColor),
        focusedBorder: _borderBuilder(focusedBorderColor),
        enabledBorder: _borderBuilder(enabledBorderColor),
      ),
      validator: PhoneValidator.compose([
        PhoneValidator.required(context, errorText: "Phone number is required"),
        PhoneValidator.valid(context, errorText: "Invalid phone number"),
      ]),
      countrySelectorNavigator:
          const CountrySelectorNavigator.draggableBottomSheet(
        countries: [
          // Add the countries you want to display here
          IsoCode.EG,
          // IsoCode.SA,
        ],
      ),
      onChanged: onChanged,
      enabled: true,
      isCountrySelectionEnabled: true,
      isCountryButtonPersistent: true,
      countryButtonStyle: const CountryButtonStyle(
        showDropdownIcon: false, // Uncomment if only one country is displayed
        showDialCode: true,
        showFlag: true,
        flagSize: 18,
      ),
    );
  }

  OutlineInputBorder _borderBuilder(Color color, {double width = 1.2}) {
    return OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(borderRadius), // Use borderRadius here
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
