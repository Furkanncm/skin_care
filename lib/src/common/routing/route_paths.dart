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
  addCosmetics('/addCosmetics'),
  addPlans('/addPlans'),
  localization('localization'),
  profile('/profile'),
  profileEdit('profileEdit');

  const RoutePaths(this.asRoutePath);

  final String asRoutePath;
}
