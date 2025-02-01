import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

final class OHBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    CoreLogger.log('${bloc.runtimeType} $change', color: LogColors.yellow);
    super.onChange(bloc, change);
  }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    CoreLogger.log('${bloc.runtimeType} created');
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    CoreLogger.log('${bloc.runtimeType} $event', color: LogColors.yellow);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    CoreLogger.log('${bloc.runtimeType} $transition', color: LogColors.yellow);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    CoreLogger.log('${bloc.runtimeType} $error', color: LogColors.red);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    CoreLogger.log('${bloc.runtimeType} closed', color: LogColors.magenta);
    super.onClose(bloc);
  }
}
