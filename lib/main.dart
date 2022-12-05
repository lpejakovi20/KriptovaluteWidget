import 'dart:ui';
import 'dart:async';

import 'package:crypto_android_widget/app/app_module.dart';
import 'package:crypto_android_widget/app/app_widget.dart';
import 'package:crypto_android_widget/services/background_callback_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:home_widget/home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HomeWidget.registerBackgroundCallback(BackgroundCallbackService.call);

  //await initializeService();
  return runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}

