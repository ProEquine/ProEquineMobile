import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeBoolState {
  final bool thereAreNotification;

  ChangeBoolState({this.thereAreNotification = false});

  ChangeBoolState copyWith({
    bool? one,
  }) {
    return ChangeBoolState(
      thereAreNotification: one ?? thereAreNotification,

    );
  }
}

class ChangeBoolCubit extends Cubit<ChangeBoolState> {
  ChangeBoolCubit(super.initialState);

  void changeOne() {
    emit(state.copyWith(
      one: !state.thereAreNotification,
    ));
  }
}