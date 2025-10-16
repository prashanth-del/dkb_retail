import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: UiTextNew.customRubik(
        "No results found",
        fontSize: 14,
        textAlign: TextAlign.center,
        color: DefaultColors.black,
      ),
    );
  }
}

class ErrorCommonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String error;
  const ErrorCommonWidget({super.key, required this.error, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height, // full screen height
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // content size
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UiTextNew.customRubik(
              error.toString(),
              fontSize: 14,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,

              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onPressed,
              child: UiTextNew.customRubik(
                "Retry",
                fontSize: 15,
                color: DefaultColors.blue01,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
