import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/routing/route_paths.dart';
import 'package:bloc_clean_architecture/src/common/routing/router.dart';
import 'package:bloc_clean_architecture/src/presentation/profile/cubit/profile_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationKey.myProfile.tr(context)),
      ),
      body: BlocProvider(
        create: (context) => getIt<ProfileCubit>()..initialize(),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        router.goNamed(RoutePaths.profileEdit.name);
                      },
                      child: const Text('Go to Profile Edit'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProfileCubit>().logout();
                      },
                      child: const Text('Logout'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (kDebugMode) print(context.locale);
                        popupManager.showAdaptiveDatePicker(
                          context: context,
                          initialDateTime: DateTime.now(),
                          minimumDate: DateTime.now().subtract(const Duration(days: 365)),
                          maximumDate: DateTime(2050),
                        );
                      },
                      child: const Text('Show date picker'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
