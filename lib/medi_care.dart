import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medi_care_hub/core/router/app_router.dart';
import 'package:medi_care_hub/core/router/routes.dart';

class MediCare extends StatelessWidget {
  final AppRouter appRouter;
  const MediCare({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        onGenerateRoute: appRouter.onGenerateRoute,
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.onBoardingView,
      ),
    );
  }
}
