import 'package:flutter/material.dart';

/// A single day's philosophy content shown on the Today screen.
class DailyPhilosophyContent {
  final String quote;
  final String quoteAuthor;
  final String reflectionQuestion;
  final String actionChallenge;

  const DailyPhilosophyContent({
    required this.quote,
    required this.quoteAuthor,
    required this.reflectionQuestion,
    required this.actionChallenge,
  });
}

/// Full philosophy model — represents one of the 12 core philosophies.
class PhilosophyModel {
  final String id;
  final String name;
  final String emoji;
  final List<Color> gradient; // Two-color gradient for cards & detail
  final String tagline; // Short one-liner under the name
  final String overview; // One concise paragraph
  final List<String> coreBeliefs; // 3–5 bullet points
  final List<String> keyThinkers; // Notable figures
  final String practicalApplication;
  final String criticisms;
  final List<DailyPhilosophyContent> dailyContent; // 7 entries (Mon–Sun)

  const PhilosophyModel({
    required this.id,
    required this.name,
    required this.emoji,
    required this.gradient,
    required this.tagline,
    required this.overview,
    required this.coreBeliefs,
    required this.keyThinkers,
    required this.practicalApplication,
    required this.criticisms,
    required this.dailyContent,
  });

  /// Returns the daily content for today's day of the week (0 = Mon).
  DailyPhilosophyContent get todayContent {
    final weekday = DateTime.now().weekday - 1; // 0–6
    return dailyContent[weekday % dailyContent.length];
  }
}
