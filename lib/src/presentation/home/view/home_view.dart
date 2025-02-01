import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/routing/route_paths.dart';
import 'package:bloc_clean_architecture/src/presentation/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationKey.homePage.tr(context)),
      ),
      body: BlocProvider(
        create: (context) => getIt<HomeBloc>()..add(HomeInitializedEvent()),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
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
                        context.goNamed(RoutePaths.todo.name);
                      },
                      child: const Text('Go to Todo'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.goNamed(RoutePaths.post.name);
                      },
                      child: const Text('Network Posts'),
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
