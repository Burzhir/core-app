import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/app_colors.dart';
import 'core/app_theme.dart';
import 'providers/auth_provider.dart' as core;
import 'screens/auth_screen.dart';
import 'screens/today_screen.dart';
import 'screens/forge_screen.dart';
import 'screens/library_screen.dart';
import 'screens/journal_screen.dart';
import 'screens/profile_screen.dart';
import 'onboarding/onboarding_screen.dart';
import 'screens/maya_chat_screen.dart';

class CoreApp extends StatelessWidget {
  final bool showOnboarding;
  const CoreApp({super.key, this.showOnboarding = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CORE',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark,
      home: _RootRouter(showOnboarding: showOnboarding),
    );
  }
}

class _RootRouter extends StatelessWidget {
  final bool showOnboarding;
  const _RootRouter({required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<core.AuthProvider>();
    switch (auth.status) {
      case core.AuthStatus.unknown:
        return const _SplashScreen();
      case core.AuthStatus.unauthenticated:
        return const AuthScreen();
      case core.AuthStatus.authenticated:
        if (showOnboarding) return const OnboardingScreen();
        return const MainShell();
    }
  }
}

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.bg,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('CORE',
                style: TextStyle(
                  color: AppColors.accent,
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 10,
                  fontFamily: 'Outfit',
                )),
            SizedBox(height: 8),
            Text('Forge Yourself',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 14,
                  letterSpacing: 3,
                )),
          ],
        ),
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  static const _screens = [
    TodayScreen(),
    ForgeScreen(),
    LibraryScreen(),
    JournalScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Sync premium status + streak every time the main shell is mounted
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final auth = context.read<core.AuthProvider>();
      if (auth.isAuthenticated) {
        auth.refreshStreakAndPremium();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      extendBody: true, // Required for floating nav bar
      body: IndexedStack(index: _index, children: _screens),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open Maya Chat Screen
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const MayaChatScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.easeOutQuart;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                return SlideTransition(position: animation.drive(tween), child: child);
              },
            ),
          );
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFFBF5AF2), Color(0xFF64D2FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFBF5AF2),
                blurRadius: 15,
                spreadRadius: 2,
              )
            ],
          ),
          child: const Center(
            child: Icon(Icons.auto_awesome, color: Colors.white, size: 28),
          ),
        ),
      ),
      bottomNavigationBar: _NavBar(
        index: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}

class _NavBar extends StatelessWidget {
  final int _index;
  final ValueChanged<int> onTap;
  const _NavBar({required int index, required this.onTap}) : _index = index;

  static const _items = [
    (Icons.wb_sunny_outlined, Icons.wb_sunny, 'Today'),
    (Icons.compare_arrows_outlined, Icons.compare_arrows, 'Forge'),
    (Icons.auto_stories_outlined, Icons.auto_stories, 'Library'),
    (Icons.book_outlined, Icons.book, 'Journal'),
    (Icons.person_outline_rounded, Icons.person_rounded, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _items.asMap().entries.map((e) {
                final i = e.key;
                final item = e.value;
                final active = i == _index;
                return GestureDetector(
                  onTap: () => onTap(i),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: Icon(
                            active ? item.$2 : item.$1,
                            key: ValueKey(active),
                            color: active ? AppColors.accent : AppColors.textMuted,
                            size: active ? 26 : 22,
                          ),
                        ),
                        if (active)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 12,
                              height: 3,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFBF5AF2), Color(0xFF64D2FF)],
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
