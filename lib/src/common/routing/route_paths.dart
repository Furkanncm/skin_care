/// Route paths
enum RoutePaths {
  splash('/'),
  serviceUnavailable('/serviceUnavailable'),
  login('/login'),
  signUp('/signUp'),
  home('/home'),
  todo('todo'),
  post('post'),
  comment('comment'),
  settings('/settings'),
  localization('localization'),
  profile('/profile'),
  profileEdit('profileEdit');

  const RoutePaths(this.asRoutePath);

  final String asRoutePath;
}
