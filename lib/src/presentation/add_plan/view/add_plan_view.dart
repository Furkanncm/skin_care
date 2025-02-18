import 'dart:io';

import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/dialogs/sc_dialogs.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/toasts/my_toasts.dart';
import 'package:bloc_clean_architecture/src/common/widgets/adaptive_indicator/adaptive_indicator.dart';
import 'package:bloc_clean_architecture/src/presentation/add_plan/bloc/add_plan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

@immutable
final class AddPlanView extends StatelessWidget {
  const AddPlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddPlanBloc>()..add(AddPlanInitialEvent()),
      child: BlocBuilder<AddPlanBloc, AddPlanState>(
        builder: (context, state) {
          if (state.status == AddPlanStatus.loading) const Center(child: AdaptiveIndicator());
          return Scaffold(
            appBar: _AppBar(),
            body: _Body(),
          );
        },
      ),
    );
  }
}

@immutable
final class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: CoreText.headlineMedium(LocalizationKey.makeYourRoutine.value),
      centerTitle: true,
      backgroundColor: context.colorScheme.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

@immutable
final class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConstants.paddingConstants.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _CalendarWidget(),
          verticalBox12,
          _MorningAndEveningField(),
          verticalBox12,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CoreText.titleLarge(LocalizationKey.cosmetics.value, textColor: context.colorScheme.primary),
              CoreIconButton(icon: Icon(Icons.refresh_outlined), onPressed: () => context.read<AddPlanBloc>().add(AddPlanInitialEvent())),
            ],
          ),
          Divider(),
          verticalBox4,
          CoreText.bodySmall(
            "Toplam ürün sayısı: ${context.read<AddPlanBloc>().state.addedCosmetics?.length.toString() ?? 0}",
            textAlign: TextAlign.end,
          ),
          _Cosmetics(),
          _SubmitButton()
        ],
      ),
    );
  }
}

@immutable
final class _CalendarWidget extends StatelessWidget {
  const _CalendarWidget();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddPlanBloc>();
    return GestureDetector(
      onTap: () async {
        final date = await SCDialogs.showDatePickerDialog(context: context, initialDate: bloc.state.selectedDate ?? DateTime.now());
        if (date == null) return;
        bloc.add(AddPlanSelectDateEvent(date: date));
      },
      child: ListTile(
        leading: Icon(Icons.calendar_today),
        title: CoreText.bodyLarge(bloc.state.selectedDate?.toddMMy),
        trailing: Icon(Icons.arrow_drop_down_outlined),
      ),
    );
  }
}

@immutable
final class _MorningAndEveningField extends StatelessWidget {
  const _MorningAndEveningField();

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<AddPlanBloc>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: CheckboxListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            value: bloc.state.isMorning,
            onChanged: (value) => bloc.add(AddPlanIsMorningEvent(isMorning: value ?? false)),
            title: CoreText.bodyLarge(LocalizationKey.morning.value),
          ),
        ),
        horizontalBox12,
        Expanded(
          child: CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: bloc.state.isEvening,
            onChanged: (value) => bloc.add(AddPlanIsEveningEvent(isEvening: value ?? false)),
            title: CoreText.bodyLarge(LocalizationKey.evening.value),
          ),
        ),
      ],
    );
  }
}

@immutable
final class _Cosmetics extends StatelessWidget {
  const _Cosmetics();

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<AddPlanBloc>();
    if (bloc.state.cosmetics?.length == 0) return Expanded(child: Center(child: CoreText.titleMedium(LocalizationKey.thereIsNoCosmetic.value)));
    if (bloc.state.status == AddPlanStatus.loading) return AdaptiveIndicator();
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          final cosmeticList = bloc.state.cosmetics;
          final cosmetic = cosmeticList?[index];
          final isAdded = bloc.state.addedCosmetics?.contains(cosmetic);
          if (cosmetic == null) return AdaptiveIndicator();
          print(cosmeticList?.length);
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.file(
                File(cosmetic.image ?? ""),
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.photo_outlined);
                },
              ),
            ),
            title: CoreText.bodyLarge("${cosmetic.name}"),
            subtitle: CoreText.bodyMedium(" ${cosmetic.category}"),
            trailing: CoreIconButton(
              icon: Icon((isAdded ?? false) ? Icons.remove : Icons.add_outlined),
              onPressed: () => bloc.add(AddPlanAddCosmeticEvent(cosmetic: cosmetic)),
            ),
          );
        },
        itemCount: context.read<AddPlanBloc>().state.cosmetics?.length ?? 0,
      ),
    );
  }
}

@immutable
final class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<AddPlanBloc>();
    return CoreOutlinedButton.autoIndicator(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.save),
          horizontalBox8,
          CoreText.bodyLarge(LocalizationKey.prepareYourPlan.value),
        ],
      ),
      onPressed: () {
        if (!(bloc.state.isMorning) && !(bloc.state.isEvening))
          SCToasts.showErrorToast(message: LocalizationKey.pleaseCheckYourRoutine.value);
        else if (bloc.state.addedCosmetics?.length == 0)
          SCToasts.showErrorToast(message: LocalizationKey.pleaseAddCosmetics.value);
        else
          bloc.add(AddPlanSubmitPlansEvent(context: context));
      },
    );
  }
}
