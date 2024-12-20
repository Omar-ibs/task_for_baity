import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_for_baity/core/service_locator.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/filter/filter_repo.dart';
import 'package:task_for_baity/features/realEstateListing/data/repo/realestateList/listing_repo.dart';
import 'package:task_for_baity/features/realEstateListing/view/real_estate_listing.dart';
import 'package:task_for_baity/features/realEstateListing/view_model/fetchAndFilter/item_list_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator().setup();
  runApp(TaskForBaity());
}

class TaskForBaity extends StatelessWidget {
  const TaskForBaity({super.key});

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
        create: (context) =>
            ItemListCubit(getIt.get<ListingRepo>(), getIt.get<FilterRepo>())
              ..fetchItems(),
        child: const ListingFeature(),
      ),
    );
  }
}
