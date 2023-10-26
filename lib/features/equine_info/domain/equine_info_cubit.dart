import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/CoreModels/empty_model.dart';
import 'package:proequine/core/errors/base_error.dart';
import 'package:proequine/features/equine_info/data/add_new_role_request_model.dart';
import 'package:proequine/features/equine_info/data/add_secondary_discipline_request_model.dart';
import 'package:proequine/features/equine_info/data/add_secondary_stable_request_model.dart';
import 'package:proequine/features/equine_info/data/delete_secondary_stable_request_model.dart';
import 'package:proequine/features/equine_info/data/get_user_disciplines_response_model.dart';
import 'package:proequine/features/equine_info/data/get_user_roles_response_model.dart';
import 'package:proequine/features/equine_info/data/get_user_stables_response_model.dart';
import 'package:proequine/features/equine_info/data/update_main_discipline_request_model.dart';
import 'package:proequine/features/equine_info/data/update_main_stable_request_model.dart';
import 'package:proequine/features/equine_info/data/update_secondary_discipline_request_model.dart';
import 'package:proequine/features/equine_info/domain/equine_info_repository/equine_info_repository.dart';

import '../../../core/CoreModels/base_response_model.dart';
import '../data/delete_discipline_request_model.dart';

part 'equine_info_state.dart';

class EquineInfoCubit extends Cubit<EquineInfoState> {
  EquineInfoCubit() : super(EquineInfoInitial());

  Future<void> getUserDiscipline() async {
    emit(GetUserDisciplineLoading());
    var response = await EquineInfoRepository.getUserDiscipline();

    if (response is GetUserDisciplinesResponseModel) {
      emit(GetUserDisciplineSuccessful(model: response));
    } else if (response is BaseError) {
      emit(GetUserDisciplineError(message: response.message));
    } else if (response is Message) {
      emit(GetUserDisciplineError(message: response.content));
    }
  }

  Future<void> getUserStables() async {
    emit(GetUserStablesLoading());
    var response = await EquineInfoRepository.getUserStables();

    if (response is GetUserStablesResponseModel) {
      emit(GetUserStablesSuccessful(model: response));
    } else if (response is BaseError) {
      emit(GetUserStablesError(message: response.message));
    } else if (response is Message) {
      emit(GetUserStablesError(message: response.content));
    }
  }
  Future<void> getUserRoles() async {
    emit(GetUserRolesLoading());
    var response = await EquineInfoRepository.getUserRoles();

    if (response is GetUserRolesResponseModel) {
      emit(GetUserRolesSuccessful(model: response));
    } else if (response is BaseError) {
      emit(GetUserRolesError(message: response.message));
    } else if (response is Message) {
      emit(GetUserRolesError(message: response.content));
    }
  }

  Future<void> updateMainDiscipline(
      UpdateMainDisciplineRequestModel updateMainDisciplineRequestModel) async {
    emit(UpdateMainDisciplineLoading());
    var response = await EquineInfoRepository.updateMainDiscipline(
        updateMainDisciplineRequestModel);

    if (response is EmptyModel) {
      emit(UpdateMainDisciplineSuccessful(
          message: "Discipline Updated Successfully"));
    } else if (response is BaseError) {
      emit(UpdateMainDisciplineError(message: response.message));
    } else if (response is Message) {
      emit(UpdateMainDisciplineError(message: response.content));
    }
  }

  Future<void> updateMainStable(
      UpdateMainStableRequestModel updateMainStableRequestModel) async {
    emit(UpdateMainStableLoading());
    var response = await EquineInfoRepository.updateMainStable(
        updateMainStableRequestModel);

    if (response is EmptyModel) {
      emit(UpdateMainStableSuccessful(message: "Stable Updated Successfully"));
    } else if (response is BaseError) {
      emit(UpdateMainStableError(message: response.message));
    } else if (response is Message) {
      emit(UpdateMainStableError(message: response.content));
    }
  }

  Future<void> addSecondaryDiscipline(
      AddSecondaryDisciplineRequestModel
          addSecondaryDisciplineRequestModel) async {
    emit(AddSecondaryDisciplineLoading());
    var response = await EquineInfoRepository.addSecondaryDiscipline(
        addSecondaryDisciplineRequestModel);

    if (response is EmptyModel) {
      emit(AddSecondaryDisciplineSuccessful(
          message: "Discipline Added Successfully"));
    } else if (response is BaseError) {
      emit(AddSecondaryDisciplineError(message: response.message));
    } else if (response is Message) {
      emit(AddSecondaryDisciplineError(message: response.content));
    }
  }
  Future<void> addSecondaryStable(
      AddSecondaryStableRequestModel
      addSecondaryStableRequestModel) async {
    emit(AddSecondaryStableLoading());
    var response = await EquineInfoRepository.addSecondaryStable(
        addSecondaryStableRequestModel);

    if (response is EmptyModel) {
      emit(AddSecondaryStableSuccessful(
          message: "Stable Added Successfully"));
    } else if (response is BaseError) {
      emit(AddSecondaryStableError(message: response.message));
    } else if (response is Message) {
      emit(AddSecondaryStableError(message: response.content));
    }
  }

  Future<void> addRole(
      AddRoleRequestModel
      addRoleRequestModel) async {
    emit(AddSecondaryRoleLoading());
    var response = await EquineInfoRepository.addNewRole(
        addRoleRequestModel);

    if (response is EmptyModel) {
      emit(AddSecondaryRoleSuccessful(
          message: "New Role Added Successfully"));
    } else if (response is BaseError) {
      emit(AddSecondaryRoleError(message: response.message));
    } else if (response is Message) {
      emit(AddSecondaryRoleError(message: response.content));
    }
  }
  Future<void> deleteRole(
      AddRoleRequestModel
      addRoleRequestModel) async {
    emit(DeleteRoleLoading());
    var response = await EquineInfoRepository.deleteRole(
        addRoleRequestModel);

    if (response is EmptyModel) {
      emit(DeleteRoleSuccessful(
          message: "Your Role Removed Successfully"));
    } else if (response is BaseError) {
      emit(DeleteRoleError(message: response.message));
    } else if (response is Message) {
      emit(DeleteRoleError(message: response.content));
    }
  }

  Future<void> updateSecondaryDiscipline(
      UpdateSecondaryDisciplineRequestModel
          updateSecondaryDisciplineRequestModel) async {
    emit(UpdateSecondaryDisciplineLoading());
    var response = await EquineInfoRepository.updateSecondaryDiscipline(
        updateSecondaryDisciplineRequestModel);

    if (response is EmptyModel) {
      emit(UpdateSecondaryDisciplineSuccessful(
          message: "Discipline Updated Successfully"));
    } else if (response is BaseError) {
      emit(UpdateSecondaryDisciplineError(message: response.message));
    } else if (response is Message) {
      emit(UpdateSecondaryDisciplineError(message: response.content));
    }
  }

  Future<void> deleteSecondaryDiscipline(
      DeleteDisciplineResponseModel deleteDisciplineResponseModel) async {
    emit(DeleteSecondaryDisciplineLoading());
    var response = await EquineInfoRepository.deleteDiscipline(
        deleteDisciplineResponseModel);

    if (response is EmptyModel) {
      emit(DeleteSecondaryDisciplineSuccessful(
          message: "Discipline Deleted Successfully"));
    } else if (response is BaseError) {
      emit(DeleteSecondaryDisciplineError(message: response.message));
    } else if (response is Message) {
      emit(DeleteSecondaryDisciplineError(message: response.content));
    }
  }
  Future<void> deleteSecondaryStable(
      DeleteSecondaryStableRequestModel deleteSecondaryStableRequestModel) async {
    emit(DeleteSecondaryStableLoading());
    var response = await EquineInfoRepository.deleteSecondaryStable(
        deleteSecondaryStableRequestModel);

    if (response is EmptyModel) {
      emit(DeleteSecondaryStableSuccessful(
          message: "Stable Deleted Successfully"));
    } else if (response is BaseError) {
      emit(DeleteSecondaryStableSuccessful(message: response.message));
    } else if (response is Message) {
      emit(DeleteSecondaryStableSuccessful(message: response.content));
    }
  }
}
