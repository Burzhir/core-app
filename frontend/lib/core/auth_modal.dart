import 'package:flutter/material.dart';
import '../screens/auth_screen.dart';

/// Show the sign-in sheet from anywhere in the app.
/// The user can dismiss it to keep browsing as a guest.
void showAuthSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: true,
    enableDrag: true,
    builder: (ctx) => ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.92,
        child: const AuthScreen(),
      ),
    ),
  );
}
