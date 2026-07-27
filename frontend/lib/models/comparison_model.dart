/// One philosophy's perspective on a life situation.
class PhilosophyPerspective {
  final String philosophyId;
  final String philosophyName;
  final String emoji;
  final String keyInsight; // One powerful sentence
  final String perspective; // 2–3 paragraphs of real guidance
  final String actionStep; // Concrete thing to do today

  const PhilosophyPerspective({
    required this.philosophyId,
    required this.philosophyName,
    required this.emoji,
    required this.keyInsight,
    required this.perspective,
    required this.actionStep,
  });
}

/// A life situation users can compare across philosophies.
class ComparisonSituation {
  final String id;
  final String title; // "Going through a breakup"
  final String icon; // emoji
  final String prompt; // Short descriptor shown in comparison screen
  final List<PhilosophyPerspective> perspectives;

  const ComparisonSituation({
    required this.id,
    required this.title,
    required this.icon,
    required this.prompt,
    required this.perspectives,
  });

  /// Free users see the first 3 perspectives; premium sees all.
  List<PhilosophyPerspective> forUser({required bool isPremium}) {
    return isPremium ? perspectives : perspectives.take(3).toList();
  }
}
