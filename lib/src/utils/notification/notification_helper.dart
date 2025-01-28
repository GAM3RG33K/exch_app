import 'package:exch_app/src/utils/application/context_helper.dart';
import 'package:exch_app/src/utils/application/system_access_helper.dart';
import 'package:exch_app/src/utils/application/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:exch_app/src/constants.dart';

class ActionData {
  final String title;
  final VoidCallback onClick;

  ActionData({required this.title, required this.onClick});

  factory ActionData.yes({
    required BuildContext context,
    String? title,
    VoidCallback? onClick,
  }) {
    return ActionData(
      title: title ?? context.l10n!.yes,
      onClick: onClick ?? () => Navigator.of(context).pop(true),
    );
  }

  factory ActionData.no({
    required BuildContext context,
    String? title,
    VoidCallback? onClick,
  }) {
    return ActionData(
      title: title ?? context.l10n!.no,
      onClick: onClick ?? () => Navigator.of(context).pop(false),
    );
  }

  factory ActionData.done({
    required BuildContext context,
    String? title,
    VoidCallback? onClick,
  }) {
    return ActionData(
      title: title ?? context.l10n!.done,
      onClick: onClick ?? () => Navigator.of(context).pop(),
    );
  }

  factory ActionData.why({
    required BuildContext context,
    String? title,
    VoidCallback? onClick,
  }) {
    return ActionData(
      title: title ?? context.l10n!.why,
      onClick: onClick ??
          () => systemAccessHelper.openSite(
                website: kWebSiteFAQ,
              ),
    );
  }

  factory ActionData.copy({
    required BuildContext context,
    required String data,
    String? title,
    VoidCallback? onClick,
  }) {
    return ActionData(
      title: title ?? context.l10n!.copy,
      onClick: onClick ?? () => systemAccessHelper.copyDataToClipboard(data),
    );
  }
}

showShortToast(msg) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
  );
}

showLongToast(msg) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
  );
}

showCustomSnackBar({
  required BuildContext context,
  required String message,
  required ActionData actionData,
  Duration duration = const Duration(seconds: 5),
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: actionData.title,
        textColor: themeHelper.fontColor3,
        onPressed: actionData.onClick,
      ),
      duration: duration,
    ),
  );
}

Future<bool?> showConfirmationDialog(
  BuildContext context, {
  required String title,
  required String message,
}) async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext dialogContext) {
      final ActionData cancelAction = ActionData.no(context: context);
      final ActionData confirmAction = ActionData.yes(context: context);

      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: themeHelper.backgroundColor3,
        title: title.isNotEmpty ? Text(title) : null,
        titleTextStyle: themeHelper.alertTitleTextStyle,
        content: message.isNotEmpty ? Text(message) : null,
        contentTextStyle: themeHelper.alertContentTextStyle,
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: <Widget>[
          InkWell(
            onTap: cancelAction.onClick,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Text(
                cancelAction.title,
                style: themeHelper.bodyTextStyle.copyWith(
                  color: themeHelper.fontColor3,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: confirmAction.onClick,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Text(
                confirmAction.title,
                style: themeHelper.bodyTextStyle.copyWith(
                  color: themeHelper.fontColor3,
                ),
              ),
            ),
          ),
        ],
      );
    },
  ).then((value) {
    return value;
  });
}

Future<void> handleCloseAction(
  BuildContext context, {
  String? title,
  VoidCallback? onConfirm,
  String? message,
}) async {
  title ??= context.l10n!.close_confirmation;
  message ??= context.l10n!.close_msg;

  if (!context.mounted) return;
  final confirmation = await showConfirmationDialog(
    context,
    title: title,
    message: message,
  );

  if (confirmation ?? false) {
    onConfirm?.call();
  }
}

Future<void> showAlertDialog(
  BuildContext context, {
  required String title,
  required String message,
  List<ActionData>? actions,
}) async {
  actions ??= [
    ActionData.done(context: context),
  ];
  return showDialog<void>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        scrollable: true,
        backgroundColor: themeHelper.backgroundColor3,
        title: title.isNotEmpty ? Text(title) : null,
        titleTextStyle: themeHelper.alertTitleTextStyle,
        content: message.isNotEmpty ? Text(message) : null,
        contentTextStyle: themeHelper.alertContentTextStyle,
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: actions!.map(
          (e) {
            return InkWell(
              onTap: e.onClick,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: Text(
                  e.title,
                  style: themeHelper.subtitleTextStyle.copyWith(
                    color: themeHelper.fontColor3,
                  ),
                ),
              ),
            );
          },
        ).toList(),
      );
    },
  ).then((value) {
    return value;
  });
}

Future<void> showAlert(
  BuildContext context, {
  String? title,
  String? message,
  List<ActionData>? actions,
}) async {
  title ??= context.l10n!.alert_title;
  message ??= context.l10n!.alert_msg;

  if (!context.mounted) return;
  return showAlertDialog(
    context,
    title: title,
    message: message,
  );
}
