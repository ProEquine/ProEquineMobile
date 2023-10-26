import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/features/support/domain/repo/support_repository.dart';

import '../../../core/CoreModels/base_response_model.dart';
import '../../../core/CoreModels/empty_model.dart';
import '../../../core/errors/base_error.dart';
import '../../../core/utils/Printer.dart';
import '../data/support_request_model.dart';

part 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  SupportCubit() : super(SupportInitial());


  Future<void> contactSupport(CreateSupportRequestModel supportRequestModel) async {
    emit(ContactSupportLoading());
    var response =
    await SupportRepository.contactSupport(supportRequestModel);
    if (response is EmptyModel) {
      emit(ContactSupportSuccessful(
          message: "Your Message Received Successfully".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(ContactSupportError(message: response.message));
    } else if (response is Message) {
      emit(ContactSupportError(message: response.content));
    }
  }
}
