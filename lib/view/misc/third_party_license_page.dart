import 'package:filmdevelopmentcompanion/view/misc/license.dart';
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
        body: Center(
          child: ListView.builder(
            itemCount: LicenseUtil.getLicenses().length,
            itemBuilder: (BuildContext context, int index) {
              final item = LicenseUtil.getLicenses()[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.grey.withOpacity(0.5),
                  child: Column(
                    children: [
                      Text(item.name),
                      Text(item.version),
                      Text(item.url),
                      Container(height: 8),
                      Text(item.license),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
