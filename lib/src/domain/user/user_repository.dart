import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/data/data_source/local/user_local_ds.dart';
import 'package:bloc_clean_architecture/src/data/data_source/remote/user_remote_ds.dart';
import 'package:bloc_clean_architecture/src/data/model/my_user/my_user.dart';
import 'package:injectable/injectable.dart';

abstract interface class IUserRepository {
  Future<BaseResponse<MyUser>> getRemoteUser();
  Future<bool> setLocalUser({required MyUser user});
  MyUser? getLocalUser();
  Future<bool> deleteLocalUser();
}

@lazySingleton
final class UserRepository implements IUserRepository {
  const UserRepository(this._userRemoteDS, this._userLocalDS);

  final UserRemoteDS _userRemoteDS;
  final UserLocalDS _userLocalDS;

  @override
  Future<BaseResponse<MyUser>> getRemoteUser() => _userRemoteDS.getUser();

  @override
  Future<bool> setLocalUser({required MyUser user}) => _userLocalDS.setUser(user: user);

  @override
  MyUser? getLocalUser() => _userLocalDS.getUser();

  @override
  Future<bool> deleteLocalUser() => _userLocalDS.deleteUser();
}
