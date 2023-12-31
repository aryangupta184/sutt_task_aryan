enum APP_PAGE {
  signin,
  signup,
  login,
  home,
  phone,
}

extension AppPageExtension on APP_PAGE {
  String get toPath {
    switch (this) {
      case APP_PAGE.home:
        return "/";
      case APP_PAGE.login:
        return "/login";
      case APP_PAGE.signin:
        return "/signin";
      case APP_PAGE.signup:
        return "/signup";
      case APP_PAGE.phone:
        return "/phone";

      default:
        return "/";
    }
  }

  String get toName {
    switch (this) {
      case APP_PAGE.home:
        return "HOME";
      case APP_PAGE.login:
        return "LOGIN";
      case APP_PAGE.signin:
        return "SIGNIN";
      case APP_PAGE.signup:
        return "SIGNUP";
      case APP_PAGE.phone:
        return "PHONE";

      default:
        return "HOME";
    }
  }


}