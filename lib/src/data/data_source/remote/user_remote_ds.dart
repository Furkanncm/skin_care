import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/message.dart';
import 'package:bloc_clean_architecture/src/data/model/my_user/my_user.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

mixin IUserRemoteDS {
  Future<BaseResponse<MyUser>> getUser();
}

@lazySingleton
final class UserRemoteDS implements IUserRemoteDS {
  const UserRemoteDS(/* this._networkManager */);

  //final NetworkManager _networkManager;

  @override
  Future<BaseResponse<MyUser>> getUser() async {
    /*   return _networkManager.request<MyUser, MyUser>(
      path: RequestPath.getCurrentUser,
      type: RequestType.get,
      responseEntityModel: const MyUser(),
    ); */

    // ignore: inference_failure_on_instance_creation
    await Future.delayed(500.milliseconds);
    return  BaseResponse(
      data: MyUser(
        id: '0f8fad5b-d9cb-469f-a165-70867728950e',
        userName: 'admin',
        name: 'admin name',
        surName: 'admin surname',
        title: 'admin title',
        email: 'admin@corewish.com',
        phone: '',
        isActive: true,
        language: 'en-US',
        password: "asdasdasdadasda"
      ),
      succeeded: true,
      messages: [
        Message(
          content: 'İşlem Başarılı',
          type: MessageType.success,
        ),
      ],
      statusCode: 200,
    );
  }
}
