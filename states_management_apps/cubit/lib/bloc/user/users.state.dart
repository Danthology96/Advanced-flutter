part of 'user.cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {
  final userExist = false;

  @override
  String toString() {
    return 'userExist: $userExist';
  }
}

class ActiveUser extends UserState {
  final userExist = true;
  final User user;

  ActiveUser(this.user);
}
