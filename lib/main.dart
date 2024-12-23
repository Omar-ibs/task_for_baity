import 'package:baity_task/src/core/utils/service_locator.dart';
import 'package:baity_task/src/features/main_feature/data/repos/home_repo.dart';
import 'package:baity_task/src/features/main_feature/data/repos/home_repo_impl.dart';
import 'package:baity_task/src/features/main_feature/presentation/view/main_feature.dart';
import 'package:baity_task/src/features/main_feature/presentation/view_model/cubit/item_list_cubit_cubit.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  ServiceLocator().setup();
  runApp(DevicePreview(enabled: true, builder: (context) => const BaityTask()));
}

class BaityTask extends StatelessWidget {
  const BaityTask({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xfff5f5fa),
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Tajawal'),
      ),
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: BlocProvider(
        create: (context) => ItemListCubitCubit(getIt.get<HomeRepo>()),
        child: const MainFeature(),
      ),
    );
  }
}
