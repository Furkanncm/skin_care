part of 'localization_key.dart';

extension LocalizationKeyExtension on LocalizationKey {
  String tr(BuildContext context, {bool listen = true, String? placeHolder}) {
    late final Culture? culture;
    if (listen) {
      culture = context.select((LocalizationBloc bloc) => bloc.state.culture);
    } else {
      culture = context.read<LocalizationBloc>().state.culture;
    }
    final resource = culture?.resources?.firstWhere(
      (element) => element.key == value,
      orElse: () => Resource(description: placeHolder ?? value),
    );
    return resource?.description ?? placeHolder ?? value;
  }

  String trParams(BuildContext context, {List<String?> params = const [], bool listen = true, String? placeHolder}) {
    var temp = tr(context, listen: listen, placeHolder: placeHolder);
    for (var i = 0; i < params.length; i++) {
      temp = temp.replaceAll('{$i}', params[i] ?? 'null');
    }
    return temp;
  }
}
