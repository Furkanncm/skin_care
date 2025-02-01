part of 'indicator_bloc.dart';

sealed class IndicatorState extends Equatable {
  const IndicatorState();
}

final class IndicatorInitial extends IndicatorState {
  const IndicatorInitial();

  @override
  List<Object> get props => [];
}

final class IndicatorShow extends IndicatorState {
  const IndicatorShow({required this.indicatorKey});

  final String indicatorKey;

  @override
  List<Object> get props => [indicatorKey];
}

final class IndicatorHide extends IndicatorState {
  const IndicatorHide({required this.indicatorKey});

  final String indicatorKey;

  @override
  List<Object> get props => [indicatorKey];
}
