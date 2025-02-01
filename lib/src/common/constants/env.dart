import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  // Base URLs
  @EnviedField(varName: 'WEB_URL_DEV', obfuscate: true)
  static final String webUrlDev = _Env.webUrlDev;
  @EnviedField(varName: 'WEB_URL_PROD', obfuscate: true)
  static final String webUrlProd = _Env.webUrlProd;
  @EnviedField(varName: 'GATEWAY_URL_DEV', obfuscate: true)
  static final String gatewayUrlDev = _Env.gatewayUrlDev;
  @EnviedField(varName: 'GATEWAY_URL_PROD', obfuscate: true)
  static final String gatewayUrlProd = _Env.gatewayUrlProd;
  @EnviedField(varName: 'ACCESS_TOKEN_URL_DEV', obfuscate: true)
  static final String accessTokenUrlDev = _Env.accessTokenUrlDev;
  @EnviedField(varName: 'ACCESS_TOKEN_URL_PROD', obfuscate: true)
  static final String accessTokenUrlProd = _Env.accessTokenUrlProd;

  // Credentials
  @EnviedField(varName: 'USER_NAME', obfuscate: true)
  static final String userName = _Env.userName;
  @EnviedField(varName: 'CLIENT_ID', obfuscate: true)
  static final String clientId = _Env.clientId;
  @EnviedField(varName: 'GRANT_TYPE', obfuscate: true)
  static final String grantType = _Env.grantType;

  // Authorization
  @EnviedField(varName: 'AUTHORIZATION', obfuscate: true)
  static final String authorization = _Env.authorization;

  // Encryption
  @EnviedField(varName: 'ENCRYPTION_KEY', obfuscate: true)
  static final String encryptionKey = _Env.encryptionKey;
  @EnviedField(varName: 'ENCRYPTION_IV', obfuscate: true)
  static final String encryptionIv = _Env.encryptionIv;

  // Push Notification
  @EnviedField(varName: 'ONESIGNAL_APP_ID', obfuscate: true)
  static final String oneSignalAppId = _Env.oneSignalAppId;
}
