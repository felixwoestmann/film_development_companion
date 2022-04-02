import 'package:flutter/material.dart';

import '../../localizations.dart';

class AddFilmOrderFloatingActionButton extends StatelessWidget {
  final VoidCallback onButtonPressed;

  AddFilmOrderFloatingActionButton(this.onButtonPressed);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onButtonPressed,
      icon: Icon(Icons.check),
      label: Text(AppLocalizations.of(context).translate('AddFilmOrderSaveOrderLabel'),
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
