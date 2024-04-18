import 'package:flutter/material.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:get/get.dart';
import 'package:odc_chat_app/screens/home.dart';
import 'package:odc_chat_app/screens/login.dart';

void main() {
  runApp(const MyFirstApp());
}

class MyFirstApp extends StatelessWidget {
  const MyFirstApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Get.key,
      debugShowCheckedModeBanner: false,
      title: "ODC APP",
      home: Login(),
      localizationsDelegates: [
        FormBuilderLocalizations.delegate,
      ],
    );
  }
}
