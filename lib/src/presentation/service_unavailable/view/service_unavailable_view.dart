import 'package:bloc_clean_architecture/src/common/gen/assets.gen.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

@immutable
final class ServiceUnavailableView extends StatelessWidget {
  const ServiceUnavailableView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _Body(),
    );
  }
}

@immutable
final class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _RepairImage(),
            CoreRelativeHeight(0.1),
            _RepairTitle(),
            CoreRelativeHeight(0.04),
            _RepairBody(),
          ],
        ),
      ),
    );
  }
}

@immutable
final class _RepairImage extends StatelessWidget {
  const _RepairImage();

  @override
  Widget build(BuildContext context) {
    return Assets.images.appRepair.image(width: context.width * 0.4, height: context.width * 0.4);
  }
}

@immutable
final class _RepairTitle extends StatelessWidget {
  const _RepairTitle();

  @override
  Widget build(BuildContext context) {
    return CoreText.titleLarge(
      LocalizationKey.applicationUnderMaintenance.tr(context),
      textAlign: TextAlign.center,
      fontWeight: FontWeight.bold,
    );
  }
}

@immutable
final class _RepairBody extends StatelessWidget {
  const _RepairBody();

  @override
  Widget build(BuildContext context) {
    return CoreText.bodyMedium(
      LocalizationKey.applicationUnderMaintenanceDescription.tr(context),
      textAlign: TextAlign.center,
      textColor: context.colorScheme.onSurface.withOpacity(0.6),
    );
  }
}
