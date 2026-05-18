import 'package:flutter/material.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';

class InformationMessageWidget extends StatelessWidget {
  String message;
  InformationMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            l10n.informacion,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: double.infinity,
          height: 2,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
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
                child: Text(l10n.aceptar),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
