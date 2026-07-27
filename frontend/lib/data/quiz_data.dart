class QuizOption {
  final String text;
  final Map<String, double> scores; // philosophy id → score

  const QuizOption({required this.text, required this.scores});
}

class QuizQuestion {
  final String text;
  final List<QuizOption> options;

  const QuizQuestion({required this.text, required this.options});
}

const List<QuizQuestion> kQuizQuestions = [
  QuizQuestion(
    text: 'When something goes wrong, your first instinct is to...',
    options: [
      QuizOption(
          text: 'Examine what was in my control and what wasn\'t',
          scores: {'stoicism': 2.0}),
      QuizOption(
          text: 'Ask what this means about my choices and freedom',
          scores: {'existentialism': 2.0}),
      QuizOption(
          text: 'Accept that it happened and look for what comes next',
          scores: {'taoism': 1.5, 'buddhism': 1.5}),
      QuizOption(
          text: 'Analyze the problem and plan concrete next steps',
          scores: {'pragmatism': 2.0}),
    ],
  ),
  QuizQuestion(
    text: 'When you think about the meaning of life, you believe...',
    options: [
      QuizOption(
          text: 'There is no cosmic meaning — we create it ourselves',
          scores: {'existentialism': 2.0, 'nihilism': 1.0}),
      QuizOption(
          text: 'Life has no ultimate meaning, but we can still live fully',
          scores: {'absurdism': 2.0}),
      QuizOption(
          text: 'Meaning comes from living virtuously and flourishing',
          scores: {'virtue_ethics': 2.0, 'stoicism': 0.5}),
      QuizOption(
          text: 'Meaning comes from human connection and contribution',
          scores: {'humanism': 2.0, 'epicureanism': 0.5}),
    ],
  ),
  QuizQuestion(
    text: 'When you feel a strong emotion — anger, sadness, fear — you...',
    options: [
      QuizOption(
          text:
              'Try to examine whether my judgment about the situation is accurate',
          scores: {'stoicism': 2.0, 'rationalism': 0.5}),
      QuizOption(
          text: 'Observe the feeling without following it',
          scores: {'buddhism': 2.0}),
      QuizOption(
          text: 'Let it flow through naturally without forcing it away',
          scores: {'taoism': 2.0}),
      QuizOption(
          text: 'Express it honestly and deal with consequences later',
          scores: {'cynicism': 1.5, 'existentialism': 0.5}),
    ],
  ),
  QuizQuestion(
    text: 'The role of pleasure in a good life is...',
    options: [
      QuizOption(
          text: 'Central — calm, deep pleasure is the foundation of happiness',
          scores: {'epicureanism': 2.0}),
      QuizOption(
          text: 'A signal, but virtue matters more than how things feel',
          scores: {'stoicism': 1.5, 'virtue_ethics': 1.0}),
      QuizOption(
          text: 'It passes — clinging to it creates suffering',
          scores: {'buddhism': 2.0}),
      QuizOption(
          text: 'Overrated — intensity of experience matters more than comfort',
          scores: {'absurdism': 1.5, 'nihilism': 0.5}),
    ],
  ),
  QuizQuestion(
    text: 'When someone tells you what to do, your gut reaction is...',
    options: [
      QuizOption(
          text:
              'I\'ll comply if it\'s reasonable, but I evaluate it independently',
          scores: {'rationalism': 1.5, 'humanism': 0.5}),
      QuizOption(
          text: 'I resist — my freedom is non-negotiable',
          scores: {'existentialism': 2.0}),
      QuizOption(
          text:
              'I question whether the social expectation is even worth following',
          scores: {'cynicism': 2.0}),
      QuizOption(
          text: 'I\'ll do what produces the best outcome for everyone',
          scores: {'pragmatism': 1.5, 'humanism': 0.5}),
    ],
  ),
  QuizQuestion(
    text: 'Your relationship with social status and reputation is...',
    options: [
      QuizOption(
          text: 'Irrelevant — I focus on my own virtue',
          scores: {'stoicism': 2.0, 'cynicism': 1.0}),
      QuizOption(
          text: 'Something to examine — it shouldn\'t drive my choices',
          scores: {'existentialism': 1.5, 'rationalism': 0.5}),
      QuizOption(
          text: 'Not worth the turbulence — I prefer tranquility over prestige',
          scores: {'epicureanism': 2.0, 'taoism': 0.5}),
      QuizOption(
          text: 'Constructed — most of what people call success is convention',
          scores: {'cynicism': 2.0, 'nihilism': 0.5}),
    ],
  ),
  QuizQuestion(
    text: 'Your approach to suffering and pain is...',
    options: [
      QuizOption(
          text: 'It arises from false judgments I can work to change',
          scores: {'stoicism': 2.0}),
      QuizOption(
          text: 'It arises from clinging to impermanent things',
          scores: {'buddhism': 2.0}),
      QuizOption(
          text:
              'It is real and meaningless — but I choose to live fully anyway',
          scores: {'absurdism': 2.0}),
      QuizOption(
          text: 'It is part of life and can be minimized through simple living',
          scores: {'epicureanism': 1.5, 'taoism': 0.5}),
    ],
  ),
  QuizQuestion(
    text: 'The best response to uncertainty is...',
    options: [
      QuizOption(
          text: 'Focus on what I control and prepare as well as I can',
          scores: {'stoicism': 2.0, 'pragmatism': 0.5}),
      QuizOption(
          text: 'Be still and allow clarity to emerge',
          scores: {'taoism': 2.0, 'buddhism': 0.5}),
      QuizOption(
          text: 'Test different approaches and learn from results',
          scores: {'pragmatism': 2.0}),
      QuizOption(
          text: 'Sit with the discomfort — certainty is an illusion anyway',
          scores: {'existentialism': 1.5, 'absurdism': 0.5}),
    ],
  ),
  QuizQuestion(
    text: 'What would most improve humanity right now?',
    options: [
      QuizOption(
          text: 'More reason, science, and education',
          scores: {'humanism': 2.0, 'rationalism': 1.0}),
      QuizOption(
          text: 'More authentic individual freedom and responsibility',
          scores: {'existentialism': 2.0}),
      QuizOption(
          text: 'Better practices for working with the mind and suffering',
          scores: {'buddhism': 2.0}),
      QuizOption(
          text: 'More honesty and less performance of respectability',
          scores: {'cynicism': 2.0}),
    ],
  ),
  QuizQuestion(
    text: 'When you think about death, you feel...',
    options: [
      QuizOption(
          text:
              'It\'s not something within my control, so I don\'t dwell on it',
          scores: {'stoicism': 2.0}),
      QuizOption(
          text:
              'It\'s not to be feared — there is no "me" there to experience it',
          scores: {'epicureanism': 1.5, 'buddhism': 1.0}),
      QuizOption(
          text: 'It makes life more urgent and more real',
          scores: {'existentialism': 2.0, 'absurdism': 0.5}),
      QuizOption(
          text: 'It\'s part of the natural cycle — just another change',
          scores: {'taoism': 2.0}),
    ],
  ),
  QuizQuestion(
    text: 'Truth, for you, is...',
    options: [
      QuizOption(
          text: 'What can be known through careful reasoning',
          scores: {'rationalism': 2.0}),
      QuizOption(
          text: 'What works — what produces useful outcomes',
          scores: {'pragmatism': 2.0}),
      QuizOption(
          text: 'What I experience directly and honestly',
          scores: {'existentialism': 1.5, 'humanism': 0.5}),
      QuizOption(
          text:
              'Beyond language — the Tao that can be named is not the eternal Tao',
          scores: {'taoism': 2.0}),
    ],
  ),
  QuizQuestion(
    text: 'Your strongest source of happiness is...',
    options: [
      QuizOption(
          text: 'Deep, genuine friendships',
          scores: {'epicureanism': 2.0, 'humanism': 0.5}),
      QuizOption(
          text: 'Moments of full presence and clarity',
          scores: {'buddhism': 2.0, 'taoism': 0.5}),
      QuizOption(
          text: 'Acting according to my values',
          scores: {'virtue_ethics': 2.0, 'stoicism': 1.0}),
      QuizOption(
          text: 'Creating something — expressing myself fully',
          scores: {'existentialism': 1.5, 'absurdism': 1.0}),
    ],
  ),
  QuizQuestion(
    text: 'When someone disagrees with your deeply held view, you...',
    options: [
      QuizOption(
          text:
              'Engage with their strongest argument — reason should be revisable',
          scores: {'rationalism': 2.0, 'pragmatism': 0.5}),
      QuizOption(
          text: 'Hold my position unless they show me specific evidence',
          scores: {'rationalism': 1.5, 'stoicism': 0.5}),
      QuizOption(
          text: 'Consider whether they have a point — I might be wrong',
          scores: {'humanism': 2.0}),
      QuizOption(
          text: 'Say exactly what I think, with no diplomatic softening',
          scores: {'cynicism': 2.0}),
    ],
  ),
  QuizQuestion(
    text: 'The purpose of suffering in a good life is...',
    options: [
      QuizOption(
          text: 'To reveal character and build virtue',
          scores: {'virtue_ethics': 1.5, 'stoicism': 1.5}),
      QuizOption(
          text: 'It has no purpose — but liberation from it is possible',
          scores: {'buddhism': 2.0}),
      QuizOption(
          text:
              'It has no ultimate purpose — but can be made meaningful by choice',
          scores: {'existentialism': 1.5, 'absurdism': 1.0}),
      QuizOption(
          text: 'To be minimized as much as possible through wise living',
          scores: {'epicureanism': 2.0}),
    ],
  ),
  QuizQuestion(
    text: 'The best life is one where you...',
    options: [
      QuizOption(
          text: 'Fully develop your capacities and live with excellence',
          scores: {'virtue_ethics': 2.0}),
      QuizOption(
          text: 'Live simply with minimal unnecessary desire',
          scores: {'epicureanism': 1.5, 'cynicism': 1.0, 'taoism': 0.5}),
      QuizOption(
          text: 'Are completely authentic to what you truly are',
          scores: {'existentialism': 2.0}),
      QuizOption(
          text: 'Contribute to human wellbeing with reason and compassion',
          scores: {'humanism': 2.0}),
    ],
  ),
  QuizQuestion(
    text: 'Your natural response to conventional success is...',
    options: [
      QuizOption(
          text: 'Indifferent — my character matters, not external success',
          scores: {'stoicism': 2.0, 'cynicism': 1.0}),
      QuizOption(
          text:
              'Curious — is this what I actually want, or what I\'ve been told to want?',
          scores: {'existentialism': 1.5, 'nihilism': 0.5}),
      QuizOption(
          text:
              'Cautious — success brings attachment, and attachment brings suffering',
          scores: {'buddhism': 2.0, 'epicureanism': 0.5}),
      QuizOption(
          text:
              'Measured — success is only meaningful if it actually helps people',
          scores: {'pragmatism': 1.5, 'humanism': 1.0}),
    ],
  ),
  QuizQuestion(
    text: 'When you read history, you are most struck by...',
    options: [
      QuizOption(
          text: 'The patterns of cause and effect — how ideas shape outcomes',
          scores: {'rationalism': 1.5, 'pragmatism': 0.5}),
      QuizOption(
          text: 'The recurring suffering caused by illusion and craving',
          scores: {'buddhism': 2.0}),
      QuizOption(
          text:
              'The individuals who had the courage to live on their own terms',
          scores: {'existentialism': 1.5, 'cynicism': 0.5}),
      QuizOption(
          text:
              'How most of what people valued desperately turned out to be worthless',
          scores: {'nihilism': 1.5, 'stoicism': 0.5}),
    ],
  ),
  QuizQuestion(
    text: 'Your relationship with rules and social norms is...',
    options: [
      QuizOption(
          text: 'I follow those I can rationally justify and question the rest',
          scores: {'rationalism': 2.0, 'humanism': 0.5}),
      QuizOption(
          text:
              'I follow the ones that serve genuine virtue and discard the rest',
          scores: {'virtue_ethics': 2.0}),
      QuizOption(
          text:
              'Most conventions are arbitrary — I follow them for convenience, not conviction',
          scores: {'cynicism': 2.0}),
      QuizOption(
          text:
              'They should be tested — rules that work, we keep; rules that don\'t, we change',
          scores: {'pragmatism': 2.0}),
    ],
  ),
  QuizQuestion(
    text: 'When you feel empty or purposeless, your first move is...',
    options: [
      QuizOption(
          text: 'Return to my core values and act from them',
          scores: {'stoicism': 2.0, 'virtue_ethics': 1.0}),
      QuizOption(
          text:
              'Question whether I\'ve been living according to what I truly want',
          scores: {'existentialism': 2.0}),
      QuizOption(
          text: 'Do something for others — connection restores meaning',
          scores: {'humanism': 2.0}),
      QuizOption(
          text: 'Sit with the emptiness rather than rushing to fill it',
          scores: {'buddhism': 1.5, 'taoism': 1.0}),
    ],
  ),
  QuizQuestion(
    text: 'Your attitude toward religious and spiritual traditions is...',
    options: [
      QuizOption(
          text:
              'Valuable as practices, even if I don\'t accept supernatural claims',
          scores: {'pragmatism': 1.5, 'humanism': 1.0}),
      QuizOption(
          text: 'Containing real wisdom about suffering and the mind',
          scores: {'buddhism': 2.0}),
      QuizOption(
          text: 'Historically important but subject to rational scrutiny',
          scores: {'rationalism': 2.0, 'humanism': 0.5}),
      QuizOption(
          text: 'Part of the conventional machinery that needs to be examined',
          scores: {'cynicism': 1.5, 'nihilism': 0.5}),
    ],
  ),
  QuizQuestion(
    text: 'The most important question you ask yourself is...',
    options: [
      QuizOption(
          text: 'Am I acting with complete integrity and virtue?',
          scores: {'stoicism': 2.0, 'virtue_ethics': 1.0}),
      QuizOption(
          text: 'Am I living authentically — truly my own choices?',
          scores: {'existentialism': 2.0}),
      QuizOption(
          text: 'Am I contributing to genuine human flourishing?',
          scores: {'humanism': 2.0}),
      QuizOption(
          text: 'Is this belief actually supported by evidence?',
          scores: {'rationalism': 2.0}),
    ],
  ),
  QuizQuestion(
    text: 'Regarding ambition and striving, you believe...',
    options: [
      QuizOption(
          text: 'Strive for excellence of character, not external achievement',
          scores: {'stoicism': 2.0, 'virtue_ethics': 0.5}),
      QuizOption(
          text: 'Most ambition is craving in disguise — simplicity is better',
          scores: {'epicureanism': 2.0, 'buddhism': 0.5}),
      QuizOption(
          text:
              'Striving that comes from wu wei is natural and right; forcing is not',
          scores: {'taoism': 2.0}),
      QuizOption(
          text: 'Ambition to become more fully yourself is the highest form',
          scores: {'nihilism': 1.5, 'existentialism': 0.5}),
    ],
  ),
  QuizQuestion(
    text: 'What do you think about the existence of objective moral truth?',
    options: [
      QuizOption(
          text: 'It exists — reason can discover it through careful analysis',
          scores: {'rationalism': 2.0}),
      QuizOption(
          text: 'It exists in the form of universal human flourishing',
          scores: {'virtue_ethics': 1.5, 'humanism': 1.0}),
      QuizOption(
          text: 'It is made, not found — morality is a human creation',
          scores: {'existentialism': 1.5, 'nihilism': 1.0}),
      QuizOption(
          text:
              'It is tested by results — what produces wellbeing is what is right',
          scores: {'pragmatism': 2.0}),
    ],
  ),
  QuizQuestion(
    text: 'Your relationship with nature and the natural world is...',
    options: [
      QuizOption(
          text: 'Deep — I am part of something much larger than myself',
          scores: {'taoism': 2.0, 'buddhism': 0.5}),
      QuizOption(
          text: 'One of interdependence — I have responsibilities toward it',
          scores: {'humanism': 1.5, 'buddhism': 0.5}),
      QuizOption(
          text:
              'Indifferent — the natural world has no particular moral claim on me',
          scores: {'stoicism': 0.5, 'nihilism': 1.0, 'rationalism': 0.5}),
      QuizOption(
          text: 'Simpler engagement with nature is better for tranquility',
          scores: {'epicureanism': 1.5, 'cynicism': 1.0}),
    ],
  ),
  QuizQuestion(
    text: 'When you make a mistake, your primary response is...',
    options: [
      QuizOption(
          text: 'Examine what judgment led to the error and correct it',
          scores: {'stoicism': 2.0, 'rationalism': 0.5}),
      QuizOption(
          text: 'Own it fully and choose differently — this defines who I am',
          scores: {'existentialism': 2.0}),
      QuizOption(
          text:
              'Observe it with compassion — mistakes are part of the human condition',
          scores: {'buddhism': 2.0, 'humanism': 0.5}),
      QuizOption(
          text: 'Extract the learning and move on — failure is instructive',
          scores: {'pragmatism': 2.0}),
    ],
  ),
  QuizQuestion(
    text: 'Your view on love and deep relationships is...',
    options: [
      QuizOption(
          text:
              'One of the deepest goods — friendship is the foundation of happiness',
          scores: {'epicureanism': 2.0, 'humanism': 0.5}),
      QuizOption(
          text: 'Powerful, but attachment in them is a source of suffering',
          scores: {'buddhism': 2.0}),
      QuizOption(
          text:
              'An act of authentic mutual freedom — not need, but genuine choice',
          scores: {'existentialism': 2.0}),
      QuizOption(
          text: 'Something I cultivate with intention and wisdom',
          scores: {'virtue_ethics': 1.5, 'stoicism': 0.5}),
    ],
  ),
  QuizQuestion(
    text: 'The source of ethical guidance for you is primarily...',
    options: [
      QuizOption(
          text: 'Reason and universal principles I can apply consistently',
          scores: {'rationalism': 2.0}),
      QuizOption(
          text: 'Examining consequences and what actually works',
          scores: {'pragmatism': 2.0}),
      QuizOption(
          text: 'My developed character and the example of people I admire',
          scores: {'virtue_ethics': 2.0}),
      QuizOption(
          text: 'Compassion and the recognition of shared human suffering',
          scores: {'buddhism': 1.5, 'humanism': 1.0}),
    ],
  ),
  QuizQuestion(
    text: 'The statement that resonates most with you is...',
    options: [
      QuizOption(text: '"The obstacle is the way."', scores: {'stoicism': 2.0}),
      QuizOption(
          text:
              '"In the beginner\'s mind there are many possibilities; in the expert\'s there are few."',
          scores: {'buddhism': 2.0}),
      QuizOption(
          text: '"The Tao that can be told is not the eternal Tao."',
          scores: {'taoism': 2.0}),
      QuizOption(
          text: '"Existence precedes essence."',
          scores: {'existentialism': 2.0}),
    ],
  ),
  QuizQuestion(
    text: 'The statement that resonates most with you is...',
    options: [
      QuizOption(
          text: '"One must imagine Sisyphus happy."',
          scores: {'absurdism': 2.0}),
      QuizOption(
          text: '"We are what we repeatedly do."',
          scores: {'virtue_ethics': 2.0}),
      QuizOption(
          text: '"Act as if what you do makes a difference. It does."',
          scores: {'pragmatism': 2.0}),
      QuizOption(
          text: '"God is dead, and we have killed him."',
          scores: {'nihilism': 2.0}),
    ],
  ),
  QuizQuestion(
    text: 'Describe your ideal relationship with time and productivity.',
    options: [
      QuizOption(
          text:
              'Purposeful — I use time well because I am clear on what matters',
          scores: {'stoicism': 1.5, 'virtue_ethics': 0.5}),
      QuizOption(
          text: 'Slow and deliberate — I resist the tyranny of busyness',
          scores: {'taoism': 2.0, 'epicureanism': 0.5}),
      QuizOption(
          text: 'Experimental — I try things, see what works, and adjust',
          scores: {'pragmatism': 2.0}),
      QuizOption(
          text: 'Present-focused — past and future are less real than now',
          scores: {'buddhism': 2.0}),
    ],
  ),
];
