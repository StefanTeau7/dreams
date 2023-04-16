import 'package:dream_catcher/styles/styles.dart';
import 'package:dream_catcher/widgets/async_action_button.dart';
import 'package:dream_catcher/widgets/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Utils {
  static void log(var output) => _logBase(output, 'DEBUG_OUTPUT');
  static void _logBase(var output, String flag) {
    if (dotenv.env[flag]?.toLowerCase() == 'true') {
      // ignore: avoid_print
      print(output);
    }
  }

  static Future<String?> showConfirmCancelDialog({
    required BuildContext context,
    String? title,
    String? content,
    Widget? body,
    String? customConfirmLabel,
    String? customCancelLabel,
    Color? titleColor,
    required Function confirmFunction,
    Function? customCancelFunction,
    bool isConfirmAsync = true,
    bool isCancelAsync = false,
    EdgeInsets? insetPadding,
  }) async {
    Future<T?> showModal<T>({
      required BuildContext context,
      required Widget content,
      bool isDismissible = true,
      bool padding = true,
      Widget? customDialog,
      Color? color,
    }) async {
      double inset = 20.0;

      return await showDialog(
        context: context,
        useRootNavigator: false,
        barrierDismissible: isDismissible,
        barrierColor: Styles.backgroundModalDark,
        builder: (BuildContext context2) {
          Widget child = Container(
              constraints: const BoxConstraints(maxWidth: 450),
              padding: padding ? const EdgeInsets.all(30) : const EdgeInsets.all(0),
              child: content);

          // return object of type Dialog
          return customDialog ??
              Dialog(
                  insetPadding: EdgeInsets.all(inset),
                  clipBehavior: Clip.antiAlias,
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Styles.white),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      )),
                  child: Container(color: Styles.white, child: child));
        },
      );
    }

    return await showModal(
      isDismissible: false,
      context: context,
      content: Container(),
      customDialog: AlertDialog(
        insetPadding: insetPadding ?? const EdgeInsets.all(20.0),
        titlePadding: title != null ? const EdgeInsets.only(bottom: 10, top: 25, left: 20, right: 20) : EdgeInsets.zero,
        title: title != null
            ? Text(
                title,
                style: Styles.copyBold.copyWith(color: titleColor ?? Styles.black),
                textAlign: TextAlign.start,
              )
            : null,
        contentPadding: const EdgeInsets.all(20.0),
        content: body ??
            (content != null
                ? SizedBox(
                    width: 250.0,
                    child: Text(
                      content,
                      style: Styles.copyFont,
                      textAlign: TextAlign.start,
                    ),
                  )
                : null),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        buttonPadding: const EdgeInsets.only(left: 20, right: 20),
        actions: <Widget>[
          Row(
            children: [
              isCancelAsync
                  ? AsyncActionButton(
                      needToCenter: false,
                      label: customCancelLabel ?? 'Cancel',
                      buttonVariant: ButtonVariant.TERTIARY,
                      height: 38,
                      onPressed: () async {
                        if (customCancelFunction != null) {
                          return await customCancelFunction.call();
                        } else {
                          Navigator.of(context).pop('CANCEL');
                        }
                      },
                    )
                  : SimpleButton(
                      needToCenter: false,
                      label: customCancelLabel ?? 'Cancel',
                      buttonVariant: ButtonVariant.TERTIARY,
                      height: 38,
                      onPressed: () async {
                        if (customCancelFunction != null) {
                          return await customCancelFunction.call();
                        } else {
                          Navigator.of(context).pop('CANCEL');
                        }
                      },
                    ),
              const SizedBox(width: 10),
              isConfirmAsync
                  ? AsyncActionButton(
                      needToCenter: false,
                      label: customConfirmLabel ?? 'Delete',
                      isDelete: true,
                      reset: true,
                      height: 38,
                      onPressed: () async {
                        return await confirmFunction.call();
                      },
                      onCompleted: (value) {
                        Navigator.of(context).pop('DELETE');
                      },
                    )
                  : SimpleButton(
                      label: customConfirmLabel ?? 'Delete',
                      height: 38,
                      onPressed: () async {
                        await confirmFunction.call();
                        Navigator.of(context).pop('DELETE');
                      },
                    ),
            ],
          )
        ],
      ),
    );
  }
}
