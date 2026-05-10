import 'package:flutter/material.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';

class ErrorMessageWidget extends StatelessWidget {
  String message;
  ErrorMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final l10n=AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(l10n.error, style: TextStyle(color: Colors.red)),
        ),
        Container(width: double.infinity, height: 2, color: Colors.black),
        Padding(
          padding: const EdgeInsets.only(
            top: 30,
            bottom: 20,
            left: 8,
            right: 8,
          ),
          child: Text(message),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                bottom: 8,
                left: 8,
                right: 10,
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(l10n.volver),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
