import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void set(int data) {
    emit(data);
  }
}
