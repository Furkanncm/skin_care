import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/data/model/localization/response/culture.dart';
import 'package:bloc_clean_architecture/src/data/model/localization/response/resource.dart';
import 'package:injectable/injectable.dart';

mixin ILocalizationRemoteDS {
  Future<BaseResponse<List<Culture>>> getCultures();
}

@lazySingleton
final class LocalizationRemoteDS with ILocalizationRemoteDS {
  const LocalizationRemoteDS(/* this._networkManager */);

  //final NetworkManager _networkManager;

  @override
  Future<BaseResponse<List<Culture>>> getCultures() async {
    // final res = await _networkManager.request<List<Culture>, Culture>(
    //   path: RequestPath.cultures,
    //   type: RequestType.get,
    //   responseEntityModel: const Culture(),
    // );

    // return res;

    return const BaseResponse(
      data: [
        Culture(
          id: '8090c42b-888e-45f0-967e-5113adb940e5',
          name: 'English',
          description: 'English(American)',
          flag: '',
          resources: [
            Resource(
              cultureId: '8090c42b-888e-45f0-967e-5113adb940e5',
              key: 'Settings',
              value: 'Settings',
              description: 'Settings',
            ),
          ],
        ),
        Culture(
          id: 'b3b3b3b3-3b3b-3b3b-3b3b-3b3b3b3b3b3b',
          name: 'Turkish',
          description: 'Türkçe',
          flag: '',
          resources: [
            Resource(
              cultureId: 'b3b3b3b3-3b3b-3b3b-3b3b-3b3b3b3b3b3b',
              key: 'Settings',
              value: 'Ayarlar',
              description: 'Ayarlar',
            ),
          ],
        ),
      ],
    );
  }
}
