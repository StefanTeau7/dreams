import 'package:dream_catcher/main.dart';
import 'package:dream_catcher/routing/dream_router.dart';
import 'package:dream_catcher/screens/auth/auth_controller.dart';
import 'package:dream_catcher/screens/home.dart/home.dart';
import 'package:dream_catcher/styles/styles.dart';
import 'package:dream_catcher/utils/utils.dart';
import 'package:flutter/material.dart';

DreamRouteInformationParser routeParser = DreamRouteInformationParser._private();
DreamRouterDelegate router = DreamRouterDelegate._private();

// this class does three things:
// 1. hold the high-level application state (where is the user)
// 2. display the right screens based on that application state
// 3. set the application state from a path
// 4. get a path from the application state
class DreamRouterDelegate extends RouterDelegate<DreameRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<DreameRoute> {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // local copy of the route
  DreameRoute _route = DreameRoute.home();
  DreameRoute _previousRoute = DreameRoute.home();

  DreamRouterDelegate._private();

  MaterialPage pageSizeWrapper({required String key, required Widget child}) {
    return MaterialPage(
      key: ValueKey(key),
      child: Container(
        color: Styles.lightBg,
        alignment: Alignment.center,
        child: Container(
          constraints: const BoxConstraints(maxWidth: MAX_SCREEN_WIDTH),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Page> pages = [];
    switch (_route.primaryScreen) {
      // case PathElement.SIGNIN:
      // case PathElement.SIGNUP:
      //   pages.add(pageSizeWrapper(key: 'Signin', child: AuthBase(params: _route.params)));
      //   break;
      // case PathElement.NO_CONNECTION:
      //   Utils.log('dreamRouterDelegate showing no connection');
      //   pages.add(pageSizeWrapper(key: 'CantConnect', child: const CantConnectScreen()));
      //   break;
      default:
        //  if (authStatus == AuthStatus.authorized) {
        Utils.log('dreamRouterDelegate authorized with $_route');
        pages.add(MaterialPage(
          key: const ValueKey('home'),
          child: Container(
            color: Styles.wine,
            alignment: Alignment.center,
            child: const Home(),
          ),
        ));
      // } else {
      //   // initialized but no user, so push signin
      //   Utils.log('dreamRouterDelegate NOT authorized with $_route');
      //   pages.add(pageSizeWrapper(key: 'Signin', child: const AuthBase()));
      // }
    }
    return Container(
      color: Styles.lightBg,
      child: Navigator(
        key: navigatorKey,
        // this is where we configure the page(s) to display
        // based on the application state
        pages: pages,
        transitionDelegate: NoAnimationTransitionDelegate(),
        onPopPage: (route, result) {
          bool succeeded = route.didPop(result);
          return succeeded;
        },
      ),
    );
  }

  // this is the current route
  @override
  DreameRoute get currentConfiguration {
    return _route;
  }

  DreameRoute get previousConfiguration {
    return _previousRoute;
  }

  // this is where we set the application state from the path object
  // forces top-level rebuild
  @override
  Future<void> setNewRoutePath(DreameRoute? configuration) async {
    Utils.log('dreamRouterDelegate setNewRoutePath() called with new $configuration and old $_route');
    // Added the following to resolve https://app.asana.com/0/1140552801186289/1203235504433551/f
    // If pushing a signin/signup route, but already authenticated, don't push the sign in route.
    if ((configuration?.primaryScreen == PathElement.SIGNIN || configuration?.primaryScreen == PathElement.SIGNUP) &&
        authStatus == AuthStatus.authorized) {
      if (configuration?.params['r'] != null) {
        configuration = DreameRoute.fromString(configuration!.params['r']);
      } else {
        return;
      }
    }
    if (configuration == null) return;
    if (_previousRoute != _route) _previousRoute = _route;
    _route = configuration;
    notifyListeners(); // this forces rebuild somehow
  }
}

// this class converts URL path to dreamRoutePath and back
class DreamRouteInformationParser extends RouteInformationParser<DreameRoute> {
  DreamRouteInformationParser._private();

  @override
  Future<DreameRoute> parseRouteInformation(RouteInformation routeInformation) async {
    Utils.log('parseRouteInformation from ${routeInformation.location}');
    return DreameRoute.fromString(routeInformation.location);
  }

  @override
  RouteInformation restoreRouteInformation(DreameRoute configuration) {
    String path = configuration.toString();
    return RouteInformation(location: path);
  }
}

class NoAnimationTransitionDelegate extends TransitionDelegate<void> {
  @override
  Iterable<RouteTransitionRecord> resolve({
    required List<RouteTransitionRecord> newPageRouteHistory,
    required Map<RouteTransitionRecord?, RouteTransitionRecord> locationToExitingPageRoute,
    required Map<RouteTransitionRecord?, List<RouteTransitionRecord>> pageRouteToPagelessRoutes,
  }) {
    final List<RouteTransitionRecord> results = <RouteTransitionRecord>[];

    for (final RouteTransitionRecord pageRoute in newPageRouteHistory) {
      if (pageRoute.isWaitingForEnteringDecision) {
        pageRoute.markForAdd();
      }
      results.add(pageRoute);
    }
    for (final RouteTransitionRecord exitingPageRoute in locationToExitingPageRoute.values) {
      if (exitingPageRoute.isWaitingForExitingDecision) {
        exitingPageRoute.markForRemove();
        final List<RouteTransitionRecord>? pagelessRoutes = pageRouteToPagelessRoutes[exitingPageRoute];
        if (pagelessRoutes != null) {
          for (final RouteTransitionRecord pagelessRoute in pagelessRoutes) {
            if (!pagelessRoute.isWaitingForEnteringDecision && pagelessRoute.isWaitingForExitingDecision) {
              pagelessRoute.markForRemove();
            }
          }
        }
      }
      results.add(exitingPageRoute);
    }
    return results;
  }
}
