import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'firebase_options.dart';

import 'app.dart';
import 'providers/auth_provider.dart' as core;
import 'providers/ai_chat_provider.dart';
import 'providers/maya_provider.dart';
import 'services/revenue_cat_service.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await RevenueCatService.initialize();

  await NotificationService.instance.init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  try {
    http
        .get(Uri.parse('https://core-app-x3ok.onrender.com/health'))
        .timeout(const Duration(seconds: 5));
  } catch (_) {}

  final prefs = await SharedPreferences.getInstance();
  final onboardingDone = prefs.getBool('onboarding_done') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => core.AuthProvider()),
        ChangeNotifierProvider(create: (_) => AiChatProvider()),
        ChangeNotifierProvider(create: (_) => MayaProvider()),
      ],
      child: CoreApp(showOnboarding: !onboardingDone),
    ),
  );
}
