

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/features/horses/data/add_horse_request_model.dart';
import 'package:proequine/features/horses/data/get_user_horses_response_model.dart';
import 'package:proequine/features/horses/data/update_condition_request_model.dart';
import 'package:proequine/features/horses/data/update_horse_request_model.dart';
import 'package:proequine/features/horses/domain/repo/horse_repository.dart';

import '../../../core/CoreModels/base_response_model.dart';
import '../../../core/CoreModels/empty_model.dart';
import '../../../core/errors/base_error.dart';
import '../../../core/utils/Printer.dart';


part 'horse_state.dart';

class HorseCubit extends Cubit<HorseState> {
  HorseCubit() : super(HorseInitial());

  Future<void> addHorse(AddHorseRequestModel addHorseRequestModel,
      String horseImage) async {
    emit(AddHorseLoading());
    var response =
    await HorseRepository.addHorse(addHorseRequestModel, horseImage);
    if (response is EmptyModel) {
      emit(AddHorseSuccessfully(
          message: "Your horse added successfully".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(AddHorseError(message: response.message));
    } else if (response is Message) {
      emit(AddHorseError(message: response.content));
    }
  }

  Future<void> updateHorse(UpdateHorseRequestModel updateHorseRequestModel,
      String horseImage) async {
    emit(UpdateHorseLoading());
    var response =
    await HorseRepository.updateHorse(updateHorseRequestModel, horseImage);
    if (response is EmptyModel) {
      emit(UpdateHorseSuccessfully(
          message: "Your Request has been sent successfully".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(UpdateHorseError(message: response.message));
    } else if (response is Message) {
      emit(UpdateHorseError(message: response.content));
    }
  }

  Future<void> updateHorseCondition(
      UpdateHorseConditionRequestModel updateHorseConditionRequestModel) async {
    emit(UpdateHorseConditionLoading());
    var response =
    await HorseRepository.updateHorseCondition(
        updateHorseConditionRequestModel);
    if (response is EmptyModel) {
      emit(UpdateHorseConditionSuccessfully(
          message: "Your Request has been sent successfully".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(UpdateHorseConditionError(message: response.message));
    } else if (response is Message) {
      emit(UpdateHorseConditionError(message: response.content));
    }
  }

  Future<void> getAllHorses() async {
    emit(GetUserHorsesLoading());
    var response =
    await HorseRepository.getHorses();
    if (response is GetAllHorsesResponseModel) {
      emit(GetUserHorsesSuccessfully(
          getAllHorsesResponseModel: response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(GetUserHorsesError(message: response.message));
    } else if (response is Message) {
      emit(GetUserHorsesError(message: response.content));
    }
  }
}
