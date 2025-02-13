import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_care_hub/core/helper/log_helper.dart';

class CustomBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    LogHelper.info(
        '${bloc.runtimeType} ${transition.currentState} => ${transition.nextState}');
    super.onTransition(bloc, transition);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    // logger.i('${bloc.runtimeType} $change');
    LogHelper.info('${bloc.runtimeType} $change');
    super.onChange(bloc, change);
  }
}
