import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserInitialState()) {
    on<ActivateUser>((event, emit) {
      emit(EstablishUserState(event.user));
    });

    on<DeleteUser>(
      (event, emit) => emit(const UserInitialState()),
    );

    on<ChangeUserAge>((event, emit) {
      if (!state.userExist) return;
      emit(EstablishUserState(state.user!.copyWith(age: event.age)));
    });

    on<AddUserProfession>(
      (event, emit) {
        if (!state.userExist) return;
        final professions = state.user!.professions;
        professions.add('Profession ${professions.length + 1}');
        emit(
            EstablishUserState(state.user!.copyWith(professions: professions)));
      },
    );
  }
}
