import 'package:flutter_dotenv/flutter_dotenv.dart';

class Utils {
  static const String deletedUserName = "Deleted User";
  static final RegExp _emailRegExp = RegExp(r'^[-0-9a-zA-Z_\.\+]+@[-0-9a-zA-Z\.]{2,}\.[a-zA-Z]{2,}$');
  static final RegExp _extractEmailRegExp = RegExp(r'[-0-9a-zA-Z_\.\+]+@[-0-9a-zA-Z\.]{2,20}\.[a-zA-Z]{2,8}');
  static RegExp simpleName = RegExp(r'^[a-zA-Z]+$');

  /// Returns a phone number in standard format (starting with +COUNTRY), or null if invalid.
  static String? cleanPhone(String? phone) {
    if (phone == null || phone.isEmpty) return null;
    // remove everything except number and +
    phone = phone.replaceAll(RegExp(r'[^0-9+]'), '');
    if (phone.startsWith('+1')) {
      // US country code with plus
      if (phone.length >= 12) {
        return phone;
      } else {
        return null;
      }
    } else if (phone.startsWith('1')) {
      // US country code
      if (phone.length == 11) {
        return '+$phone';
      } else {
        return null;
      }
    }
    if (phone.startsWith('+')) {
      // country code other than +1, say its ok if long enough
      if (phone.length > 10) {
        // assume non-US number
        return phone;
      }
    }
    // not starting with '+' or '1', must be 10-digit US number
    if (phone.length >= 10) {
      return '+1$phone';
    }
    return null;
  }

  static bool isValidPhone(String phone) {
    return cleanPhone(phone) != null;
  }

  static String? prettyPhone(String? phone) {
    if (phone == null) return null;
    if (phone.startsWith('+1')) {
      String area = phone.substring(2, 5);
      String exch = phone.substring(5, 8);
      String rest = phone.substring(8);
      return '($area) $exch-$rest';
    } else if (!phone.startsWith('+1') && phone.length == 10) {
      String area = phone.substring(0, 3);
      String exch = phone.substring(3, 6);
      String rest = phone.substring(6);
      return '($area) $exch-$rest';
    } else {
      return phone;
    }
  }

  // Returns a phone number in standard format (starting with +COUNTRY),
  // or null if invalid.
  static String? cleanEmail(String? email) {
    if (email == null) return null;
    email = email.trim();
    if (email.startsWith('<') && email.endsWith('>')) {
      // strip the outer <> which comes from gmail
      email = email.substring(1, email.length - 1);
    }
    if (email.isEmpty) return null;
    if (_emailRegExp.hasMatch(email)) {
      return email.trim().toLowerCase();
    }
    return null;
  }

  static bool isValidEmail(String email) {
    return cleanEmail(email) != null;
  }

  static void log(var output) => _logBase(output, 'DEBUG_OUTPUT');

  static void _logBase(var output, String flag) {
    if (dotenv.env[flag]?.toLowerCase() == 'true') {
      // ignore: avoid_print
      print(output);
    }
  }

  static bool isValidZipcode(String? code) {
    if (code == null) return false;
    RegExp zipRegexp = RegExp(r"^[0-9]{5}(?:-[0-9]{4})?$");
    bool result = zipRegexp.hasMatch(code);
    Utils.log('Utils.isValidZipcode just got $code $result');
    return result;
  }

  static final RegExp _newlineMatcher = RegExp(r'<\/p>|<\/li>|<br>|<\/div>');
  static final RegExp _elementMatcher = RegExp(r'<[^>]+?>');

  static String removeHTMLTags(String? text, [bool preserveNewlines = false]) {
    if (text == null || text.isEmpty) return '';
    text = text.replaceAll(_newlineMatcher, preserveNewlines ? '\n' : ' ');
    text = text.replaceAll(_elementMatcher, '');
    return text;
  }

  static String removeNewlines(String? text) {
    if (text == null || text.isEmpty) return '';
    return text.replaceAll('\n', ' ');
  }

  static final RegExp _tagMatcher = RegExp(r'<a href="(?<linka>[^"]+)">(?<anchora>[^<]+)</a>|'
      // r'(?<linke>[-_a-zA-Z0-9.]+@[-a-zA-Z0-9]+\.[-a-zA-Z]{2,10})|' // email
      r'\[(?<anchorb>[^\]]+)\]\((?<linkb>[^\)]+)\)'
      // r'|\b(?<linkc>(http://|https://)?([-a-zA-Z0-9:]{2,12}\.)?[-a-zA-Z0-9:]{2,24}\.[a-z]{2,6}(/[-_a-zA-Z0-9:&=+?/]+)?)\b' // URL
      );

  static String? removeTags(String? text) {
    if (text == null || text.isEmpty) return text;
    Iterable<RegExpMatch> matches = _tagMatcher.allMatches(text);
    if (matches.isEmpty) {
      return text;
    }
    int next, last = 0;
    String newText = '';
    for (RegExpMatch m in matches) {
      next = m.start;
      // add everything up until this
      newText += text.substring(last, next);
      String? anchor;
      if (m.namedGroup('linka') != null) {
        anchor = m.namedGroup('anchora');
      } else if (m.namedGroup('linkb') != null) {
        anchor = m.namedGroup('anchorb');
      }
      if (anchor != null) {
        // add the anchor from above
        newText += anchor;
      }
      last = m.end;
    }
    // add the last bit
    newText += text.substring(last, text.length);
    return newText;
  }

  static String getInitials(String s) {
    String result = '';
    List<String> tokens = s.split(' ');
    for (int i = 0; i < 3 && i < tokens.length; i++) {
      if (tokens[i].isNotEmpty) {
        result += tokens[i][0].toUpperCase();
      }
    }
    return result;
  }

  static String replaceMentions(String messageText, Map<String, String> mentionMap) {
    if (mentionMap.isEmpty || messageText.isEmpty) {
      return messageText;
    }
    mentionMap.forEach((mention, url) {
      messageText = messageText.replaceAll(mention, url);
    });
    return messageText;
  }

  static RegExp streetNumMatcher = RegExp(r"^([0-9]+)([^,]+)");

  static int compareAddresses(String? a1, String? a2) {
    if (a1 == null || a1.isEmpty) return 1;
    if (a2 == null || a2.isEmpty) return -1;
    a1 = a1.toLowerCase().trim();
    int n1 = 0;
    String s1 = a1;
    if (streetNumMatcher.hasMatch(a1)) {
      RegExpMatch m = streetNumMatcher.firstMatch(a1)!;
      n1 = int.parse(m.group(1)!);
      s1 = m.group(2)!;
    }
    a2 = a2.toLowerCase().trim();
    int n2 = 0;
    String s2 = a2;
    if (streetNumMatcher.hasMatch(a2)) {
      RegExpMatch m = streetNumMatcher.firstMatch(a2)!;
      n2 = int.parse(m.group(1)!);
      s2 = m.group(2)!;
    }
    int value = s1.compareTo(s2);
    if (value != 0) return value;
    return n1.compareTo(n2);
  }

  static String concatStringsWithMax(Iterable<String> names, int maxLength, {String? concatWith}) {
    String text = '';
    int i = 0;
    concatWith ??= ',';
    List<String> l = List.from(names);
    for (; i < l.length && i < maxLength; i++) {
      if (i != 0) {
        text += '$concatWith ';
      }
      text += l[i];
    }
    if (names.length > maxLength) {
      if (names.length - maxLength == 1) {
        text += '$concatWith and ${names.length - maxLength} other';
      } else {
        text += '$concatWith and ${names.length - maxLength} others';
      }
    }
    return text;
  }

  // static Future<PermissionStatus?> requestNotificationPermissions(
  //     {bool isModal = false, required BuildContext context}) async {
  //   // Safari does not support push notifications
  //   if (isSafari) return null;
  //   PermissionStatus notificationPermissionStatus = await Permission.notification.status;

  //   Utils.log('checking notification permissions');
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;
  //   // check without asking
  //   NotificationSettings origSettings = await messaging.getNotificationSettings();
  //   if (origSettings.authorizationStatus == AuthorizationStatus.authorized &&
  //       origSettings.authorizationStatus == AuthorizationStatus.provisional) {
  //     Utils.log('we already have notification permissions');
  //     return null;
  //   } else if (!notificationPermissionStatus.isGranted) {
  //     if (notificationPermissionStatus.isPermanentlyDenied) {
  //       openAppSettings();
  //     } else {
  //       if (!kIsWeb && Platform.isAndroid) {
  //         DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //         AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //         if (androidInfo.version.sdkInt < 33) {
  //           // Android API less than 33 give notification permission by default.
  //           // If notification is denied, it was manually disabled by the user
  //           // and must be manually enabled.  Unfortunately the Permission package
  //           // doesn't seem to correctly return isPermanentlyDenied, so force it here:
  //           openAppSettings();
  //         } else {
  //           await Permission.notification.request();
  //         }
  //       } else {
  //         await Permission.notification.request();
  //       }
  //     }
  //   } else if ((Platform.isIOS && origSettings.notificationCenter == AppleNotificationSetting.enabled) ||
  //       (Platform.isAndroid && !notificationPermissionStatus.isGranted)) {
  //     if (isModal) {
  //       Navigator.pop(context);
  //     }
  //   } else {
  //     // now ask
  //     Utils.log('asking for notification permissions (if we asked already this is a no-op)');
  //     NotificationSettings notificationSettings = await messaging.requestPermission(
  //       alert: true,
  //       announcement: false,
  //       badge: true,
  //       carPlay: false,
  //       criticalAlert: false,
  //       provisional: false,
  //       sound: true,
  //     );
  //     UserService userService = getIt<UserService>();
  //     if (notificationSettings.authorizationStatus == AuthorizationStatus.authorized ||
  //         notificationSettings.authorizationStatus == AuthorizationStatus.provisional) {
  //       Utils.log('User granted permission for the first time, adding notification channel');
  //       FirebaseService firebaseService = getIt<FirebaseService>();
  //       firebaseService
  //           .logFirebaseAnalyticsEvent(eventName: 'login_success', parameters: {'userName': userService.user.fullName});
  //     } else {
  //       Utils.log('User declined or has not accepted permission');
  //     }
  //   }
  //   notificationPermissionStatus = await Permission.notification.status;
  //   return notificationPermissionStatus;
  // }

  static String getHumanReadableList(List<String> items, int max) {
    Utils.log('getHumanReadableList for ${items.length} and $max');
    String result = '';
    if (items.length == 1) {
      return items[0];
    } else if (items.length == 2) {
      return '${items[0]} & ${items[1]}';
    }
    for (int i = 0; i < items.length && i < max - 1; i++) {
      result += '${items[i]}, ';
    }
    int remainder = items.length - max + 1;
    if (remainder > 0) {
      result += '& $remainder other${remainder > 1 ? 's' : ''}';
    } else if (result.isNotEmpty) {
      result = result.substring(0, result.length - 2);
    }
    return result;
  }

  static List<T> getValuesFromMap<T>(Map<dynamic, Set<T>> map) {
    List<T> messageIds = [];
    for (dynamic mappedId in map.keys) {
      for (T id in map[mappedId] ?? []) {
        messageIds.add(id);
      }
    }
    return messageIds;
  }
}
