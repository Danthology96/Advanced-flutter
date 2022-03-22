part of 'user_bloc.dart';

@immutable
abstract class UserState {
  final bool userExist;
  final User? user;

  const UserState({this.userExist = false, this.user});
}

class UserInitialState extends UserState {
  const UserInitialState() : super(userExist: false, user: null);
}

class EstablishUserState extends UserState {
  final User newUser;
  const EstablishUserState(this.newUser)
      : super(user: newUser, userExist: true);
}
