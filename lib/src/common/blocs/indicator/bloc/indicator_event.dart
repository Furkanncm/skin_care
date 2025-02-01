part of 'indicator_bloc.dart';

sealed class IndicatorEvent extends Equatable {
  const IndicatorEvent();

  @override
  List<Object> get props => [];
}

final class _IndicatorShowedEvent extends IndicatorEvent {
  const _IndicatorShowedEvent(this.indicatorKey);
  final String indicatorKey;

  @override
  List<Object> get props => [indicatorKey];
}

final class _IndicatorHiddenEvent extends IndicatorEvent {
  const _IndicatorHiddenEvent(this.indicatorKey);
  final String indicatorKey;

  @override
  List<Object> get props => [indicatorKey];
}
