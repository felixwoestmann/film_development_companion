import 'package:filmdevelopmentcompanion/util/license.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThirdPartyLicensesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Licenses",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView.builder(
          itemBuilder: (context, position) {
            return ListTile(
                title: Text(
                    "Package: " + LicenseUtil.getLicenses()[position].name),
                subtitle: Text(
                    "Version: " + LicenseUtil.getLicenses()[position].version),
                trailing: Text(LicenseUtil.getLicenses()[position].license));
          },
          itemCount: LicenseUtil.getLicenses().length,
        ));
  }
}
