import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valet_parking_app/constants/app_binding.dart';
import 'package:valet_parking_app/constants/constants.dart';
import 'package:valet_parking_app/data/services/user_service.dart';
import 'package:valet_parking_app/data/storage/valet_storage.dart';
import 'package:valet_parking_app/routes/app_pages.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ValetStorage().initStorage();
  await UserService().initSession();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.APP_NAME,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      defaultTransition: Transition.noTransition,
      initialBinding: AppBinding(),
      locale: const Locale('es', 'ES'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', 'ES'),
      ],
    );
  }
}
