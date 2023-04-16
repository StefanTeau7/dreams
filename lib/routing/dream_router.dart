class DreameRoute {
  static const String ALL = 'all';

  final String? primaryScreen;
  final String? primaryId;
  final String? secondaryScreen;
  final String? secondaryId;
  Map<String, String> params = {};
  dynamic model;

  // constructors
  DreameRoute.signin()
      : primaryScreen = PathElement.SIGNIN,
        primaryId = null,
        secondaryScreen = null,
        secondaryId = null;
  DreameRoute.home()
      : primaryScreen = PathElement.HOME,
        primaryId = null,
        secondaryScreen = null,
        secondaryId = null;
  DreameRoute.settings()
      : primaryScreen = PathElement.SETTINGS,
        primaryId = null,
        secondaryScreen = null,
        secondaryId = null;
  DreameRoute({this.primaryScreen, this.primaryId, this.secondaryScreen, this.secondaryId, this.params = const {}});

  factory DreameRoute.fromString(String? fullPath) {
    if (fullPath == null) return DreameRoute.home();
    Uri uri = Uri.parse(fullPath);
    String path = uri.path;
    List<String> pathSegments = path.split('/');
    if (pathSegments.isNotEmpty) {
      pathSegments = pathSegments.sublist(1);
    } // remove the first segment
    String? primaryScreen;
    String? primaryId;
    String? secondaryScreen;
    String? secondaryId;

    primaryScreen = pathSegments.isNotEmpty ? pathSegments[0] : PathElement.HOME;

    primaryId = pathSegments.length > 1 ? pathSegments[1] : null;
    secondaryScreen = pathSegments.length > 2 ? pathSegments[2] : null;
    secondaryId = pathSegments.length > 3 ? pathSegments[3] : null;

    return DreameRoute(
      primaryScreen: primaryScreen,
      primaryId: primaryId,
      secondaryScreen: secondaryScreen,
      secondaryId: secondaryId,
      params: uri.queryParameters,
    );
  }

  @override
  bool operator ==(other) => other is DreameRoute && toString() == other.toString();
  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    String path = '/';
    if (primaryScreen != null) path += (primaryScreen ?? '');
    if (primaryId != null) path += '/${primaryId ?? ''}';
    if (secondaryScreen != null) path += '/${secondaryScreen ?? ''}';
    if (secondaryId != null) path += '/${secondaryId ?? ''}';
    if (params.isNotEmpty) {
      path += '?';
      for (String k in params.keys) {
        path += '$k=${params[k]}&';
      }
    }
    // Utils.printCapture('toString created path $path');
    return path;
  }

  DreameRoute getParent() {
    if (secondaryId != null) {
      return DreameRoute(primaryScreen: primaryScreen, primaryId: primaryId, secondaryScreen: secondaryScreen);
    } else if (secondaryScreen != null) {
      return DreameRoute(primaryScreen: primaryScreen, primaryId: primaryId);
    } else if (primaryId != null) {
      return DreameRoute(primaryScreen: primaryScreen);
    } else {
      return DreameRoute.home();
    }
  }
}

class PathElement {
  static const NONE = '';
  // primary actions
  static const NO_CONNECTION = 'noConnection';
  static const SIGNIN = 'signin';
  static const SIGNUP = 'signup';
  static const OLD_VERSION = 'oldVersion';
  // primary resources
  static const HOME = 'home';
  static const GROUPS = 'groups';
  static const SEARCH = 'search';
  static const SETTINGS = 'settings';
}
