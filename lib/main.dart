import 'package:flutter/material.dart';
import 'package:medi_care_hub/core/helper/custom_bloc_observer.dart';
import 'package:medi_care_hub/core/helper/shared_prefs.dart';
import 'package:medi_care_hub/core/services/service_locator.dart';
import 'package:medi_care_hub/medi_care.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  serviceLocator();
  CustomBlocObserver();
  runApp(const MediCare());
}
