import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/widgets/adaptive_indicator/adaptive_indicator.dart';
import 'package:bloc_clean_architecture/src/presentation/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:table_calendar/table_calendar.dart';

@immutable
final class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<HomeBloc>()..add(HomeInitializedEvent()),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.status == HomeStatus.loading) {
              return AdaptiveIndicator();
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeaderAndCalendar(),
                  verticalBox4,
                  Padding(
                    padding: AppConstants.paddingConstants.pageLowPadding,
                    child: CoreText.bodyLarge((state.user?.name?.toUpperCase() ?? "") + LocalizationKey.sloganWithUserName.value),
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: 10,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: AppConstants.paddingConstants.horizontalPadding,
                          child: Container(
                            decoration: BoxDecoration(
                              color: context.colorScheme.secondary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 200),
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: true ? Colors.blue : Colors.white,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                            color: false ? Colors.blue : Colors.grey,
                                            width: 2,
                                          ),
                                        ),
                                        child: true
                                            ? const Icon(
                                                Icons.check,
                                                size: 18,
                                                color: Colors.white,
                                              )
                                            : null,
                                      ),
                                    ),
                                  ),
                                  verticalBox8,
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        "https://picsum.photos/200/300",
                                        width: double.infinity, // Genişliği tamamen kaplasın
                                        fit: BoxFit.fill, // Oranları bozmadan içini doldur
                                      ),
                                    ),
                                  ),
                                  Align(alignment: Alignment.centerLeft, child: CoreText.bodyLarge("Serum")),
                                  Align(alignment: Alignment.centerLeft, child: CoreText.bodyMedium("Korendy"))
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

@immutable
final class _HeaderAndCalendar extends StatelessWidget {
  const _HeaderAndCalendar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.35,
      width: context.width,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CoreText.headlineMedium(LocalizationKey.dailyRoutine.value),
          verticalBox4,
          Divider(
            indent: context.width * 0.05,
            endIndent: context.width * 0.05,
          ),
          verticalBox16,
          _MonthAndBackToTodayWidgets(),
          verticalBox4,
          _CalendarWidget(),
        ],
      ),
    );
  }
}

@immutable
final class _MonthAndBackToTodayWidgets extends StatelessWidget {
  const _MonthAndBackToTodayWidgets();

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomeBloc>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: CoreText.bodyLarge(bloc.state.currentDay?.toMonthName()),
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () => bloc.isDayInWeek ? emptyBox : bloc.add(HomeBackToTodayEvent()),
            child: bloc.isDayInWeek ? emptyBox : CoreText.bodyLarge(LocalizationKey.goNow.value, textColor: Colors.blue),
          ),
        ),
      ],
    );
  }
}

@immutable
final class _CalendarWidget extends StatelessWidget {
  const _CalendarWidget();

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomeBloc>();
    return Padding(
      padding: AppConstants.paddingConstants.horizontalPadding,
      child: TableCalendar(
        startingDayOfWeek: StartingDayOfWeek.monday,
        rowHeight: context.height * 0.1,
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: bloc.state.focusedDay ?? DateTime.now(),
        currentDay: bloc.state.currentDay,
        headerVisible: false,
        daysOfWeekVisible: false,
        calendarFormat: CalendarFormat.week,
        onDaySelected: (selectedDay, focusedDay) => bloc.add(HomeDayChangedEvent(currentDay: selectedDay)),
        onPageChanged: (focusedDay) => bloc.add(HomePageChangedOnCalendar(focusedDay: focusedDay)),
        calendarBuilders: CalendarBuilders(
          todayBuilder: (context, day, focusedDay) {
            return _TodayCardBuilder(day: day);
          },
          defaultBuilder: (context, day, focusedDay) {
            return _NotTodayCardBuilder(day: day);
          },
          outsideBuilder: (context, day, focusedDay) {
            return _NotTodayCardBuilder(day: day);
          },
        ),
      ),
    );
  }
}

@immutable
final class _TodayCardBuilder extends StatelessWidget {
  _TodayCardBuilder({required this.day});

  final DateTime day;

  @override
  Widget build(BuildContext context) {
    return _TodayColumnWidget(day: day);
  }
}

@immutable
final class _TodayColumnWidget extends StatelessWidget {
  _TodayColumnWidget({required this.day});

  final DateTime day;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TodayWidgetsIndent(),
        verticalBox8,
        CoreText.bodyLarge(day.toDayName().truncateToLength(length: 3, suffix: "")),
        verticalBox8,
        CircleAvatar(radius: 15, backgroundColor: context.colorScheme.primary, child: CoreText.bodyLarge(day.day.toString())),
      ],
    );
  }
}

@immutable
final class _TodayWidgetsIndent extends StatelessWidget {
  const _TodayWidgetsIndent();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.05,
      height: context.height * 0.004,
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.primary.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(4, 4),
          ),
        ],
      ),
    );
  }
}

@immutable
final class _NotTodayCardBuilder extends StatelessWidget {
  _NotTodayCardBuilder({required this.day});

  final DateTime day;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      width: context.width,
      height: context.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: context.colorScheme.surface,
      ),
      child: _NotTodayColumnWidget(day: day),
    );
  }
}

@immutable
final class _NotTodayColumnWidget extends StatelessWidget {
  _NotTodayColumnWidget({required this.day});

  final DateTime day;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalBox8,
        CoreText.bodyLarge(day.toDayName().truncateToLength(length: 3, suffix: "")),
        verticalBox8,
        CircleAvatar(radius: 15, backgroundColor: context.colorScheme.surface, child: CoreText.bodyLarge(day.day.toString())),
      ],
    );
  }
}
