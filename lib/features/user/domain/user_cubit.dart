import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/features/user/data/login_response_model.dart';
import 'package:proequine/features/user/domain/repo/user_repository.dart';

import '../../../core/CoreModels/base_response_model.dart';
import '../../../core/errors/base_error.dart';
import '../../../core/utils/Printer.dart';
import '../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../data/login_request_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> login(LoginRequestModel loginRequestModel) async {
    /// here we emit loading state while contact with server
    emit(LoginLoading());
    /// return the response from server
    var response = await UserRepository.login(loginRequestModel);
    /// if server return the same model so it's success state
    if (response is LoginResponseModel) {
      /// store our token in shared pref
      AppSharedPreferences.accessToken = response.token!;

      /// this type of Printing working only on debug mode so maintains high performance app
      Print("access token ${AppSharedPreferences.accessToken}");
      /// this message will show as a toast if the status is success
      emit(LoginSuccessful(message: "login successfully".tra));
    } else if (response is BaseError) {
      /// message will return from our handling errors in Dio
      Print("messaggeeeeeeeee${response.message}");
      emit(LoginError(message: response.message));
    } else if (response is Message) {
      /// this message will return from the server in case we have error
      emit(LoginError(message: response.content));
    }
  }
}
