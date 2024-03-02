class AppConstants {
  const AppConstants._();

  static CachedKey cachedKey = const CachedKey();
  static AppApi appApi = const AppApi();
  static ErrorKey errorKey = const ErrorKey();
  static ErrorMessage errorMessage = const ErrorMessage();
  static TagDialog tagDialog = const TagDialog();
  static ArgsKey argsKey = const ArgsKey();
  static TagHero tagHero = const TagHero();
  static LocaleLang localeLang = const LocaleLang();
}

class CachedKey {
  const CachedKey();

  String get tokenKey => 'token_key';
  String get userIDKey => 'user_id_Key';
  String get localeKey => 'locale_Key';
}

class AppApi {
  const AppApi();

  String get baseUrl => 'https://story-api.dicoding.dev/v1';
  String get random => '/random';
  String get login => '/login';
  String get register => '/register';
  String get stories => '/stories';
}

class ErrorKey {
  const ErrorKey();
  String get message => "message";
}

class ErrorMessage {
  const ErrorMessage();

  String get noInternet => "Can't connect, please check your connection";

  String get errorCommon => "Opss.. Sorry, Something went wrong";
}

class TagDialog {
  const TagDialog();

  String get tagDialogLoading => "tag_dialog_loading";
  String get tagDialog => "tag_dialog";
}

class TagHero {
  const TagHero();

  String get tagLocale => "ta_locale";
}

class ArgsKey {
  const ArgsKey();

  String get id => "id";
}

class LocaleLang {
  const LocaleLang();

  String get id => "id";
  String get en => "en";
}
