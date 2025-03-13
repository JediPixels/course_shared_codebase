import 'package:flutter/material.dart';

/// StatusMessage
class StatusMessage extends StatelessWidget {
  /// Show a Banner and Status Message
  const StatusMessage({
    super.key,
    required this.message,
    required this.bannerMessage,
    required this.bannerColor,
    required this.textColor,
  });

  final String message;
  final String bannerMessage;
  final Color bannerColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.only(top: kToolbarHeight)),
        Banner(
          message: bannerMessage,
          location: BannerLocation.topStart,
          color: bannerColor,
          textStyle: TextStyle(color: textColor),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 48),
            padding: const EdgeInsets.all(24),
            child: Text(
              message,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        )
      ],
    );
  }
}
