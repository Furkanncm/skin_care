import 'package:bloc_clean_architecture/src/data/model/my_user/my_user.dart';

enum ProfilInfoEnum {
  Username,
  phone,
  password,
  gender,
  birthDate,
}

extension ProfileInfoExtension on ProfilInfoEnum {
  String? value(MyUser? user) {
    switch (this) {
      case ProfilInfoEnum.Username:
        return user?.Username ?? "Guest";
      case ProfilInfoEnum.phone:
        return user?.phone ?? "000 000 00 00";
      case ProfilInfoEnum.password:
        return user?.password != null ? "*" * user!.password!.length : "There is no password";
      case ProfilInfoEnum.gender:
        return user?.gender ?? "Unkown";
      case ProfilInfoEnum.birthDate:
        return user?.birthDate?.toString() ?? "__/__/____";
    }
  }
}
