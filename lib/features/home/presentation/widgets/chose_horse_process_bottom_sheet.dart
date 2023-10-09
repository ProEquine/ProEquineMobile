import 'package:flutter/material.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/features/home/domain/cubits/local_horse_cubit.dart';
import 'package:proequine/features/home/domain/repo/local_storage_repository.dart';
import 'package:proequine/features/home/presentation/widgets/exisiting_horse_details.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../data/local_trip.dart';

void existHorseBottomSheet({
  required BuildContext context,
  required String title,
  required String tripId,
  required Horse horse,
  required Widget content,
  required String name,
  required List<bool> ownerShip,
  required String horseId,
  required List<bool> staying,
}) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
        ? AppColors.formsBackground
        : AppColors.backgroundColorLight,
    useSafeArea: false,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
    ),
    builder: (BuildContext context) {
      LocalHorseCubit cubit =
          LocalHorseCubit(localStorageRepository: LocalStorageRepository());
      return Wrap(children: [
        ExistingHorseDetailsScreen(
            horseId: horseId,
            tripId: tripId,
            name: name,
            title: title,
            ownerShip: ownerShip,
            horse: horse,
            staying: staying)
      ]);
    },
  );
}
