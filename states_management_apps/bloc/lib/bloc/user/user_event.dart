part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class ActivateUser extends UserEvent {
  final User user;
  ActivateUser(this.user);
}

class ChangeUserAge extends UserEvent {
  final int age;
  ChangeUserAge(this.age);
}

class AddUserProfession extends UserEvent {
  /// in case we need the input
  // final String profession;
  // AddUserProfession(this.profession);
  // AddUserProfession();
}

class DeleteUser extends UserEvent {}
