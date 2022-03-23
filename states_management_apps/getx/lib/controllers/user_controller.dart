import 'package:get/get.dart';
import 'package:getx/models/user.dart';

class UserController extends GetxController {
  RxBool userExists = false.obs;
  Rx<User> user = User().obs;

  void loadUser(User user) {
    userExists.value = true;
    this.user.value = user;
  }

  void changeAge(int value) {
    user.update((val) {
      val!.age = value;
    });
  }

  void addProfession(String profession) {
    user.update((val) {
      val!.professions!.add(profession);
    });
  }
}
