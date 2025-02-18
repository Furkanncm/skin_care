// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/widgets/adaptive_indicator/adaptive_indicator.dart';
import 'package:bloc_clean_architecture/src/data/model/cosmetic/cosmetic.dart';
import 'package:bloc_clean_architecture/src/presentation/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CoreText.headlineMedium(LocalizationKey.routines.value),
        centerTitle: true,
        backgroundColor: context.colorScheme.surface,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
      ),
      body: BlocProvider(
        create: (context) => getIt<HomeBloc>()..add(HomeInitializedEvent()),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.status == HomeStatus.loading) {
              return const Center(child: AdaptiveIndicator());
            }
            final username = state.user?.name ?? '';
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _HeaderSection(username: username, state: state),
                const SizedBox(height: 16),
                _RoutinesSection(state: state),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Üst kısım: Karşılama mesajı ve takvim.
class _HeaderSection extends StatelessWidget {
  final String username;
  final HomeState state;
  const _HeaderSection({
    required this.username,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [context.colorScheme.primary, context.colorScheme.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hello ${username.isNotEmpty ? (username[0].toUpperCase() + username.substring(1)) : ''}",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: context.colorScheme.onSurface),
          ),
          const SizedBox(height: 8),
          Text(
            LocalizationKey.sloganWithUserName.value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurface),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: context.colorScheme.surface,
            ),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TableCalendar(
              startingDayOfWeek: StartingDayOfWeek.monday,
              rowHeight: 40,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: state.focusedDay ?? DateTime.now(),
              currentDay: state.currentDay,
              headerVisible: false,
              daysOfWeekVisible: true,
              calendarFormat: CalendarFormat.week,
              onDaySelected: (selectedDay, focusedDay) => context.read<HomeBloc>().add(HomeDayChangedEvent(currentDay: selectedDay)),
              onPageChanged: (focusedDay) => context.read<HomeBloc>().add(HomePageChangedOnCalendar(focusedDay: focusedDay)),
              calendarBuilders: CalendarBuilders(
                todayBuilder: (context, day, focusedDay) => _DayTile(day: day, isToday: true),
                defaultBuilder: (context, day, focusedDay) => _DayTile(day: day, isToday: false),
                outsideBuilder: (context, day, focusedDay) => _DayTile(day: day, isToday: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Takvimdeki her gün için basit gün kutusu.
class _DayTile extends StatelessWidget {
  final DateTime day;
  final bool isToday;
  const _DayTile({required this.day, required this.isToday, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isToday ? context.colorScheme.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: CoreText.bodyMedium(
        day.day.toString(),
      ),
    );
  }
}

/// Rutinlerin listelendiği bölüm.
class _RoutinesSection extends StatelessWidget {
  final HomeState state;
  const _RoutinesSection({required this.state});

  @override
  Widget build(BuildContext context) {
    final morningCosmetics = state.todaysPlan?.morning?.cosmetics ?? [];
    final eveningCosmetics = state.todaysPlan?.evening?.cosmetics ?? [];

    if (morningCosmetics.isEmpty && eveningCosmetics.isEmpty) {
      return Center(
        child: Text(
          LocalizationKey.thereIsAPlanForThatDay.value,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (morningCosmetics.isNotEmpty)
          _RoutineList(
            title: "Sabah Rutini",
            cosmetics: morningCosmetics,
            height: morningCosmetics.length * 90,
          ),
        if (eveningCosmetics.isNotEmpty)
          _RoutineList(
            title: "Akşam Rutini",
            cosmetics: eveningCosmetics,
            height: eveningCosmetics.length * 90,
          ),
      ],
    );
  }
}

// Sabaha ve akşama özel rutin tasarımı
class _RoutineList extends StatelessWidget {
  final String title;
  final List<Cosmetic> cosmetics;
  final double height;
  const _RoutineList({
    Key? key,
    required this.title,
    required this.cosmetics,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Üst kısım: İkon ve başlık
          Row(
            children: [
              Icon(
                title == "Sabah Rutini" ? Icons.wb_sunny : Icons.nights_stay,
                color: context.colorScheme.primary,
              ),
              horizontalBox8,
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.primary,
                    ),
              ),
            ],
          ),
          horizontalBox16,
          // Yatay liste halinde kozmetik kartları
          SizedBox(
            height: height,
            child: ListView.separated(
              itemCount: cosmetics.length,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final item = cosmetics[index];
                return _CosmeticCard(item: item);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CosmeticCard extends StatelessWidget {
  final Cosmetic item;
  const _CosmeticCard({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          File(item.image!),
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.image_not_supported_outlined,
            color: context.colorScheme.primary,
          ),
        ),
      ),
      title: Text(
        item.name ?? "Unknown",
        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        item.category ?? "Unknown",
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
