import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:proequine/features/home/data/local_horse.dart';

import '../../../../core/utils/Printer.dart';
import '../repo/local_storage_repository.dart';

part 'local_horse_state.dart';

class LocalHorseCubit extends Cubit<LocalHorseState> {
  final LocalStorageRepository _localStorageRepository;

  LocalHorseCubit({required LocalStorageRepository localStorageRepository})
      : _localStorageRepository = localStorageRepository,
        super(LocalHorseInitial());

  bool isAdded = false;
  List<int> wishListIds = [];
  List<Horse> horses = [];

  Future<void> addAuction(AddHorseSuccessfully event) async {
    emit(AddHorseLoading());
    try {
      Print(horses.length);
      Print('first print$horses');
      Box box = await _localStorageRepository.openBox();

      // wishListIds.add(event.item.id!);

      _localStorageRepository.createHorse(box, event.item);
      // _localStorageRepository.addAuctionIds(event.item.id);

      Print(horses.length);
      Print(horses);

      await getHorses();
      // Print(ids.values);
      emit(AddHorseSuccessfully(item: event.item));
    } catch (_) {
      emit(AddHorseError(message: "error"));
    }
  }

  Future<void> getHorses() async {
    emit(GetHorsesLoading());
    try {
      Box box = await _localStorageRepository.openBox();
      List<Horse> items = _localStorageRepository.getHorses(box);
      horses = items;
      // await Future<void>.delayed(const Duration(seconds: 1));
      Print(horses.length);
      Print(horses);
      emit(GetHorsesSuccessfully(items: items));
    } catch (_, error) {
      Print(error);
      emit(GetHorsesError(message: "error"));
    }
  }
}
