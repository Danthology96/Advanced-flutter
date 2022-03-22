import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/user.dart';

part 'users.state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void selectUser(User user) {
    emit(ActiveUser(user));
  }

  void changeAge(int age) {
    final currentState = state;
    if (currentState is ActiveUser) {
      final newUser = currentState.user.copyWith(age: 30);
      emit(ActiveUser(newUser));
    }
  }

  void addProffesion() {
    final currentState = state;
    if (currentState is ActiveUser) {
      final proffesions = currentState.user.proffesions;
      proffesions.add('Profesion ${proffesions.length + 1}');
      final newUser = currentState.user.copyWith(proffesions: proffesions);
      emit(ActiveUser(newUser));
    }
  }

  void deleteUser() {
    emit(UserInitial());
  }
}
