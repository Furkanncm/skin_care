import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/presentation/splash/bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

@immutable
final class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    /// SplashBloc provide ediliyor ve SplashInitializedEvent tetikleniyor.
    return BlocProvider(
      create: (context) => getIt<SplashBloc>()..add(const SplashInitializedEvent()),
      child: const Scaffold(
        body: _Body(),
      ),
    );
  }
}

@immutable
final class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConstants.paddingConstants.pagePadding,
      child: BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) {
          /// State'lere göre gösterilecek sayfa hazırlanıyor.
          if (state is SplashError) {
            return _SplashErrorBody(state.message);
          } else {
            return const _SplashSuccessBody();
          }
        },
      ),
    );
  }
}

@immutable
final class _SplashErrorBody extends StatelessWidget {
  const _SplashErrorBody(this.message);

  final String message;

  @override
  Widget build(BuildContext context) {
    /// SplashBloc akışlarında hata gerçekleşirse bu tasarım gösteriliyor.
    /// Hata mesajı ekranda gösterilip tekrar dene butonuna tıklandığında tüm splash akışları tekrar başlatılıyor.
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              size: 64,
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  CoreText.titleMedium(
                    message,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textColor: context.colorScheme.onSurface,
                  ),
                  verticalBox16,
                  CoreFilledButton(
                    onPressed: () => context.read<SplashBloc>().add(const SplashInitializedEvent()),
                    child: CoreText.labelLarge(
                      LocalizationKey.retry.tr(
                        context,
                        listen: false,
                        placeHolder: context.locale.countryCode == 'TR' ? 'Tekrar Dene' : 'Retry',
                      ),
                      textColor: context.colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

@immutable
final class _SplashSuccessBody extends StatelessWidget {
  const _SplashSuccessBody();

  @override
  Widget build(BuildContext context) {
    /// Akışlar gerçekleşirken ekranda bu tasarım gösterilir.
    /// Bu tasarımda genelde uygulama logosu gösterilir.
    return const Center(child: Text('Splash Screen'));
  }
}
