import 'package:bloc_clean_architecture/src/data/model/my_user/my_user.dart';
import 'package:flutter/material.dart';

enum ProfilInfoEnum {
  Username,
  phone,
  password,
  gender,
  birthDate,
}

enum GenderEnum {
  male,
  female,
}

extension ProfileInfoExtension on ProfilInfoEnum {
  String? value(MyUser user) {
    switch (this) {
      case ProfilInfoEnum.Username:
        return user.Username ?? (user.name ?? '').characters.first.toUpperCase() + (user.surName ?? '').characters.first.toUpperCase() + (user.surName ?? '').substring(1);
      case ProfilInfoEnum.phone:
        return user.phone ?? "000 000 00 00";
      case ProfilInfoEnum.password:
        return user.password != null ? "*" * user.password!.length : "There is no password";
      case ProfilInfoEnum.gender:
        return user.gender ?? "Unkown";
      case ProfilInfoEnum.birthDate:
        return user.birthDate?.toString() ?? "__/__/____";
    }
  }

  Icon? icon(MyUser user) {
    switch (this) {
      case ProfilInfoEnum.Username:
        return Icon(Icons.person);
      case ProfilInfoEnum.phone:
        return Icon(Icons.phone);
      case ProfilInfoEnum.password:
        return Icon(Icons.lock);
      case ProfilInfoEnum.gender:
        return Icon(user.gender != null ? (user.gender== GenderEnum.male.name ? Icons.male_outlined : Icons.female_outlined) : Icons.question_mark);
      case ProfilInfoEnum.birthDate:
        return Icon(Icons.calendar_today);
    }
  }
}
