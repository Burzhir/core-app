class CourseDay {
  final int day;
  final String title;
  final String theme;
  final String content;
  final String reflectionQuestion;
  final String dailyPractice;

  const CourseDay({
    required this.day,
    required this.title,
    required this.theme,
    required this.content,
    required this.reflectionQuestion,
    required this.dailyPractice,
  });
}

class Course {
  final String id;
  final String title;
  final String subtitle;
  final String emoji;
  final String philosophy;
  final String description;
  final int durationDays;
  final List<CourseDay> days;

  const Course({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.philosophy,
    required this.description,
    required this.durationDays,
    required this.days,
  });
}

const List<Course> kCourses = [
  // ── STOICISM ─────────────────────────────────────────────────────────────────
  Course(
    id: 'stoicism_14',
    title: '14 Days of Stoicism',
    subtitle: 'Build an unshakeable mind',
    emoji: '⚖️',
    philosophy: 'stoicism',
    description:
        'A 14-day structured introduction to Stoic practice. Each day focuses on one core principle with theory, reflection, and a concrete daily challenge. By the end, you will have the foundations of a genuine Stoic practice.',
    durationDays: 14,
    days: [
      CourseDay(
        day: 1,
        title: 'The Dichotomy of Control',
        theme: 'Control',
        content:
            'Epictetus opened the Enchiridion — the Stoic handbook — with this: "Some things are in our control and others not. Things in our control are opinion, pursuit, desire, aversion — in a word, whatever are our own actions. Things not in our control are body, reputation, command, and in one word, whatever are not our own actions."\n\nThis single distinction is the foundation of Stoic practice. Most human suffering comes from directing will and energy at things that are genuinely not in our power: what others think, how events unfold, whether our efforts are rewarded. When we focus on these, we guarantee frustration.\n\nWhat is always in your power: your judgments (what you tell yourself about events), your choices (how you respond), your character (who you are becoming). These, and only these, can be improved with effort.',
        reflectionQuestion:
            'What three things are you expending the most mental energy on right now? Which are genuinely in your control?',
        dailyPractice:
            'For every concern you have today, ask: "Is this in my control?" If not, consciously redirect attention to what is.',
      ),
      CourseDay(
        day: 2,
        title: 'Negative Visualization',
        theme: 'Gratitude',
        content:
            'Stoics practiced premeditatio malorum — the premeditation of evils. This sounds morbid but produces the opposite of misery: profound gratitude for what you currently have. Seneca recommended a daily practice of imagining losing the things you value most — your health, your relationships, your work, your home. Not to make yourself anxious, but to dissolve the complacency that causes us to sleepwalk through blessings.\n\nThe person who has never imagined losing their health takes it entirely for granted. The person who has vividly imagined illness experiences a walk in good health as a privilege. This is the Stoic alchemy: imagining loss creates presence.\n\nNegative visualization also prepares you for difficulty. When hardship comes — as it does to everyone — the Stoic has already, mentally, made their peace with it.',
        reflectionQuestion:
            'What in your life would you most grieve if it were taken from you tomorrow?',
        dailyPractice:
            'Spend 5 minutes imagining your life without three things you currently have. Then spend 5 minutes fully appreciating them as they actually are.',
      ),
      CourseDay(
        day: 3,
        title: 'Virtue Is the Only Good',
        theme: 'Values',
        content:
            'The Stoics made a radical claim: virtue is the only genuine good. Everything else — health, wealth, pleasure, status, relationships — is "preferred indifferent." These things are fine to have and reasonable to pursue when available, but they are not genuinely good. Only excellence of character is good.\n\nThis sounds extreme. In practice, it is liberating. It means: your value as a person is not indexed to your outcomes. You cannot be made worse by losing money, health, or reputation. You can only be made worse by acting dishonestly, cowardly, or unjustly. And that is always your own choice.\n\nThe four Stoic virtues: wisdom (knowing what is genuinely good), justice (acting rightly toward others), courage (acting well despite difficulty), and temperance (moderating impulse with reason).',
        reflectionQuestion:
            'When have you sacrificed your integrity for an outcome you wanted? And when have you prioritized character over outcome — how did that feel?',
        dailyPractice:
            'At every decision point today, ask: "What would the person I want to be do here?" Then do that, regardless of how it affects the outcome.',
      ),
      CourseDay(
        day: 4,
        title: 'The View from Above',
        theme: 'Perspective',
        content:
            'Marcus Aurelius used a mental practice he called taking the view from above — imagining himself looking down at the earth, then at his empire, then at Rome, then at his own situation, from a cosmic distance. From that vantage point, petty grievances, status anxieties, and daily frustrations lose their suffocating importance.\n\nThis is not nihilism — it does not make things meaningless. It creates proportion. The things that matter most (your character, the quality of your attention, your genuine relationships) become clearer when the noise of conventional concern is quieted.\n\nMarcus also used this for meetings, conflicts, and difficult people: imagining future historians observing the scene. How do I want to appear from that distance? What action would I be proud of?',
        reflectionQuestion:
            'What current concern, when viewed from ten years in the future, would shrink significantly in importance?',
        dailyPractice:
            'At least once today, when you feel irritated or anxious, take the view from above. What does this situation look like from a cosmic distance?',
      ),
      CourseDay(
        day: 5,
        title: 'The Morning Ritual',
        theme: 'Practice',
        content:
            'Marcus Aurelius began each day with a version of premeditatio — a morning review. He would write (in private, as a practice not a publication): "Today I will encounter interference, ingratitude, insolence, disloyalty, ill-will, and selfishness." This sounds grim. The point was to be genuinely unsurprised when humans behaved badly, so he could respond with wisdom rather than reaction.\n\nHe would also review the day\'s likely challenges and ask himself: "How would a wise, just, and virtuous person handle these?" This prepared him, conceptually, to be his best self before the day\'s provocations arrived.\n\nThe Stoic morning practice: review your values, anticipate the day\'s challenges, and set an intention for who you will be.',
        reflectionQuestion:
            'What challenges are you likely to face today? How would your ideal self handle them?',
        dailyPractice:
            'Spend 10 minutes each morning this week: review your core values, anticipate likely challenges, and set a clear intention for who you will be.',
      ),
      CourseDay(
        day: 6,
        title: 'The Evening Review',
        theme: 'Reflection',
        content:
            'Seneca described the Stoic evening practice: "I examine my day and review what I have done and what I have said. I withhold nothing from myself, spare myself nothing. For why should I spare myself, when I can say: From this time on, be more careful? When I have transgressed, I am not angry with myself."\n\nThe Stoic evening review is not self-punishment. It is honest self-examination without drama. Three questions: Where did I fall short of my best self today? What happened that I handled well? What can I improve tomorrow?\n\nThis practice, done consistently, builds self-knowledge — the most Stoic of virtues, because without it, you cannot improve anything.',
        reflectionQuestion:
            'Looking at this past week: where did you act in full alignment with your values? Where did you not?',
        dailyPractice:
            'Every evening this week: answer the three evening review questions honestly. Not harshly — honestly.',
      ),
      CourseDay(
        day: 7,
        title: 'Dealing with Difficult People',
        theme: 'Others',
        content:
            'Marcus Aurelius wrote extensively about difficult people, because as emperor he dealt with some of the most difficult people who have ever lived — and wrote his reflections in the Meditations. His practice:\n\nFirst: nobody does wrong voluntarily. People act badly from ignorance, fear, pain, or false beliefs — not from a desire to be evil. This does not excuse them, but it changes the emotional response from contempt to something closer to pity.\n\nSecond: how they treat you is in their power. How you respond is in yours. You can maintain your equanimity and virtue regardless of their behavior.\n\nThird: relationships — including difficult ones — are part of what it means to be human. The person who never has to deal with difficult people has no real test of their character.',
        reflectionQuestion:
            'Think of the person who most reliably irritates or frustrates you. What false belief or genuine suffering might be driving their behavior?',
        dailyPractice:
            'The next time someone irritates you today, try the Stoic practice: understand before judging. What is driving their behavior? Does that change your response?',
      ),
      CourseDay(
        day: 8,
        title: 'Amor Fati — Love of Fate',
        theme: 'Acceptance',
        content:
            'Nietzsche borrowed this concept from the Stoics: amor fati, love of fate. Not mere acceptance of what happens, but genuine love of it — including the difficult, the painful, the unwanted. Marcus Aurelius: "A blazing fire makes flame and brightness out of everything that is thrown into it."\n\nThis is one of the most demanding and most liberating Stoic practices. It is not resignation — it does not mean passivity or approval of everything that happens. It means: I will not waste energy resisting reality as it is. I will work with what I have been given, finding the opportunity in every obstacle.\n\nAmenity is the Stoic word for this quality: treating everything as training material for the virtuous life, including the things that feel like they should be exceptions.',
        reflectionQuestion:
            'What has happened to you that, at the time, felt like a disaster, but in retrospect contributed something valuable to who you are?',
        dailyPractice:
            'Take something in your current life that you have been resisting or resenting. Write three ways it could be precisely the training your character needs.',
      ),
      CourseDay(
        day: 9,
        title: 'Impulse and Response',
        theme: 'Self-control',
        content:
            'The Stoics distinguished between first movements — the immediate, involuntary emotional responses that arise before we can control them — and the passions, which are the second movements where we add our assent (our judgment that the emotion is appropriate and should be indulged).\n\nYou cannot stop the first movement. When someone insults you, the blood rises in your face. That is physiological, not moral. What is within your power is the second movement: the story you tell, the judgment you add, whether you decide to be offended, afraid, or angry.\n\nThe practice is creating a gap between stimulus and response — a moment of awareness in which the first movement is observed without being immediately acted on. This is where freedom lives.',
        reflectionQuestion:
            'What emotional first movement most frequently hijacks your better judgment? What judgment do you typically add that makes it into a full passion?',
        dailyPractice:
            'Today, when you notice a strong emotional first movement, pause for 30 seconds before responding. Notice what you tell yourself in that gap.',
      ),
      CourseDay(
        day: 10,
        title: 'Voluntary Discomfort',
        theme: 'Resilience',
        content:
            'Seneca practiced voluntary discomfort — deliberately choosing simple food, cold water, uncomfortable conditions — not as asceticism but as training. His purpose: to discover that the things he feared losing were actually manageable without, and to reduce his dependence on comfortable conditions for his equanimity.\n\nThe logic: if your happiness depends on comfort, wealth, or convenience, you are always vulnerable to their removal. If you have demonstrated to yourself, repeatedly, that you can be equanimous without them, you no longer fear their loss.\n\nModern application: cold showers, fasting, difficult conversations, public embarrassment, physical difficulty — any voluntary departure from comfort that builds the capacity for equanimity under real hardship.',
        reflectionQuestion:
            'What comfort or convenience, if removed, would most destabilize you? What would change if you practiced its occasional absence?',
        dailyPractice:
            'Choose one voluntary discomfort today: cold shower, skipping a meal, doing something that embarrasses you slightly, having a difficult conversation you\'ve been avoiding.',
      ),
      CourseDay(
        day: 11,
        title: 'On Anger',
        theme: 'Anger',
        content:
            'Seneca devoted an entire treatise to anger — because he considered it the most destructive passion. His analysis is still unsurpassed: anger is almost always disproportionate to its cause. It punishes the person who holds it more than the person who provoked it. It clouds judgment precisely when clear judgment is most needed. And it never actually addresses the underlying injury.\n\nThe Stoic approach to anger: first, the delay. Any gap between stimulus and expression reduces the probability of action you will regret. Second, the examination: what judgment am I making? Is my judgment accurate? Third, the question: what would a wise and just response look like?\n\nRighteous anger — proportionate, directed, and aimed at genuine correction rather than revenge — is not condemned by the Stoics. What is condemned is the sustained, distorting passion of resentment.',
        reflectionQuestion:
            'When does anger most reliably hijack your judgment? What do you tell yourself in those moments? Is the judgment accurate?',
        dailyPractice:
            'The next time you feel anger today: delay any response by at least 60 seconds. Then write what judgment you are making about the situation.',
      ),
      CourseDay(
        day: 12,
        title: 'Cosmopolitanism',
        theme: 'Community',
        content:
            'The Stoics were the first philosophers to articulate cosmopolitanism — the view that all human beings are citizens of the same world, connected by shared reason. Marcus Aurelius wrote: "What injures the hive injures the bee." The welfare of the whole and the welfare of the individual are not opposed — they are connected.\n\nThis had practical implications for Stoics who, like Marcus, held positions of great power. Justice — the virtue of right action toward others — was not separable from wisdom and courage. The Stoic does not pursue virtue for personal improvement alone but as a way of living well with others.\n\nIn practice: your obligations extend beyond your immediate circle. What is good for the people in front of you? What is good for those you will never meet?',
        reflectionQuestion:
            'In your current work and relationships, are you acting with genuine concern for others\' wellbeing, or primarily for your own benefit?',
        dailyPractice:
            'Identify one specific way you can contribute today to someone beyond your immediate circle — a stranger, a community, or a cause.',
      ),
      CourseDay(
        day: 13,
        title: 'Memento Mori',
        theme: 'Mortality',
        content:
            'The Stoics kept death in mind not to produce morbidity but to produce urgency and perspective. Memento mori — "remember that you will die" — was a genuine practice, not a piece of gothic decoration.\n\nMarcus Aurelius wrote: "Think of yourself as dead. You have lived your life. Now take what\'s left and live it properly." The awareness of mortality clarifies priorities remarkably. Whatever does not matter fades. Whatever genuinely matters becomes luminous.\n\nSeneca wrote extensive meditations on the shortness of life — not to induce despair, but to produce the kind of focused attention that makes each day count. "It is not that we have a short time to live, but that we waste a good deal of it."',
        reflectionQuestion:
            'If you knew you had one year left, which of your current priorities would remain unchanged and which would you abandon immediately?',
        dailyPractice:
            'Begin the day by saying: "Today could be my last." Notice whether this changes the quality of your attention to the day\'s actual events.',
      ),
      CourseDay(
        day: 14,
        title: 'Building a Daily Practice',
        theme: 'Integration',
        content:
            'You have now worked through the core foundations of Stoic philosophy. The question is not what you have learned — it is what you will practice. Stoicism without practice is just reading.\n\nThe minimum viable Stoic practice: morning intention (5 min), daily dichotomy of control check (ongoing), evening review (5 min). This is 10 minutes per day. Marcus Aurelius, running an empire at war, managed to keep his practice.\n\nThe deeper practice grows from consistency: journaling, voluntary discomfort, memento mori, view from above, negative visualization. These are not techniques to apply once but to rotate through and deepen over a lifetime.\n\nYou have the tools. The question now is whether you will use them.',
        reflectionQuestion:
            'What from this course has most changed how you think about your situation? What specific practice will you commit to maintaining?',
        dailyPractice:
            'Write your personal Stoic practice plan: which practices will you do daily, weekly, and occasionally? Make it realistic enough to actually maintain.',
      ),
    ],
  ),

  // ── EXISTENTIALISM ───────────────────────────────────────────────────────────
  Course(
    id: 'existentialism_7',
    title: 'Existentialism: Your Freedom',
    subtitle: 'Confront your freedom and live authentically',
    emoji: '🌌',
    philosophy: 'existentialism',
    description:
        'A 7-day journey through existentialist philosophy. From Kierkegaard\'s anxiety to Sartre\'s radical freedom to de Beauvoir\'s ethics of ambiguity, this course gives you the philosophical tools to live more authentically and take genuine responsibility for your life.',
    durationDays: 7,
    days: [
      CourseDay(
        day: 1,
        title: 'Existence Precedes Essence',
        theme: 'Freedom',
        content:
            'Sartre\'s most famous statement: "Existence precedes essence." For a hammer, the essence — the purpose, the design — exists before the object. For a human being, the opposite is true. We exist first, and then we define ourselves through choice and action. There is no pre-given human nature, no fixed destiny, no essential you waiting to be discovered.\n\nThis is simultaneously terrifying and exhilarating. Terrifying because it means we cannot hide behind our "nature," our conditioning, our circumstances. Exhilarating because it means we are genuinely free — not abstractly, but in the concrete sense that our next choice is always possible.',
        reflectionQuestion:
            'Which of your traits do you treat as fixed aspects of your "nature" that are actually patterns you have chosen to repeat?',
        dailyPractice:
            'Pick one "I am" statement that has been limiting you ("I am not a confident person," "I am introverted," "I am not good at X"). Act against it once today.',
      ),
      CourseDay(
        day: 2,
        title: 'Bad Faith',
        theme: 'Authenticity',
        content:
            'Sartre\'s concept of bad faith (mauvaise foi) is one of the most penetrating ideas in modern philosophy. Bad faith is self-deception about your own freedom — pretending you had no choice when you did, claiming your actions were forced when they were chosen, identifying so completely with a social role that you forget you are a person who chose to inhabit it.\n\nExamples: "I have to do this for the money" (you are choosing to prioritize money over other values), "I can\'t help how I am" (you are choosing to continue the patterns you have), "That\'s just my culture" (you are choosing to follow it).\n\nAuthenticity, the opposite of bad faith, means owning your freedom honestly — including the uncomfortable parts.',
        reflectionQuestion:
            'Where in your life are you currently in bad faith — denying your freedom by saying "I have to" or "I can\'t" when the honest answer is "I choose to" or "I choose not to"?',
        dailyPractice:
            'Replace every "I have to" and "I can\'t" today with "I choose to" or "I choose not to." Notice how different the statements feel.',
      ),
      CourseDay(
        day: 3,
        title: 'Anxiety and Freedom',
        theme: 'Anxiety',
        content:
            'Kierkegaard called anxiety "the dizziness of freedom." Sartre described it as the vertigo that arises when you genuinely acknowledge that you could, at any moment, do otherwise than you are doing. The person standing at a cliff edge feels anxiety not only from fear of falling, but from the awareness that they could jump — and that this choice is genuinely theirs.\n\nExistentialist anxiety is not neurosis to be treated. It is the honest registration of genuine freedom and genuine stakes. If nothing genuinely mattered, there would be no anxiety. The anxiety is the sign that your choices are real.\n\nThe authentic response is not to eliminate anxiety but to act within it — to choose and commit despite the knowledge that you cannot guarantee the outcome.',
        reflectionQuestion:
            'What are you most anxious about right now? What genuine freedom and genuine stakes does that anxiety point to?',
        dailyPractice:
            'Do one thing today that makes you anxious because it genuinely matters to you. The anxiety is the sign that it is real.',
      ),
      CourseDay(
        day: 4,
        title: 'The Other',
        theme: 'Relationships',
        content:
            'Sartre\'s famous line "Hell is other people" is almost always misunderstood. He did not mean others are unpleasant. He meant: in the presence of others, I am confronted with a perspective on myself that I cannot control. Others see me as an object, as a fixed thing, in a way I never see myself. This is genuinely uncomfortable — and genuinely necessary.\n\nSimone de Beauvoir extended this: we are not self-sufficient consciousnesses. We exist in relationship. The meaning we create is always co-created in some sense — shaped by the people who look at us and the people we look at. Others are not obstacles to freedom but the mirrors in which we discover who we are.\n\nAuthentic relationships require acknowledging the other as a genuine freedom, not a tool for your own self-creation.',
        reflectionQuestion:
            'Which relationship in your life calls on you most to engage with the other as a genuinely free person rather than as a supporting character in your story?',
        dailyPractice:
            'In a significant conversation today, practice genuine interest in the other person\'s freedom — what they want, fear, and choose — not as it relates to you.',
      ),
      CourseDay(
        day: 5,
        title: 'Radical Responsibility',
        theme: 'Responsibility',
        content:
            'Sartre was extreme on this point, and deliberately so: we are responsible for everything we do, and we cannot escape this responsibility by pointing to circumstances, upbringing, or nature. This seems unfair — surely we are shaped by forces we did not choose? Yes. And we are still responsible for what we make of those forces in each subsequent choice.\n\nThis is not an excuse for self-blame. It is a call to agency. The person who accepts full responsibility for their choices — even the choices shaped by difficult circumstances — has the fullest capacity to change. The person who attributes everything to circumstances has surrendered their power to circumstances.\n\nDe Beauvoir moderated this: responsibility is exercised in conditions of freedom, and those conditions are not equal for everyone. Social structures matter. But within whatever conditions you find yourself in, the question of what you do with your freedom remains.',
        reflectionQuestion:
            'What in your life are you attributing to circumstances that might more honestly be attributed to choices you keep making?',
        dailyPractice:
            'Identify one pattern in your life you have been explaining by reference to circumstances. Write what choice is actually sustaining it.',
      ),
      CourseDay(
        day: 6,
        title: 'Meaning in a Meaningless Universe',
        theme: 'Meaning',
        content:
            'Sartre and Camus agreed on the diagnosis — the universe has no inherent meaning — but disagreed on the prescription. Sartre said: we create meaning through committed engagement. Camus said: we live in revolt against meaninglessness without pretending we\'ve solved it.\n\nFor Sartre, a meaningful life is not found but made: through projects we commit to, values we choose, people we love, work we invest in. The meaning is not "out there" to be discovered — it is in the quality and authenticity of our engagement.\n\nThis changes the question from "what is the meaning of life?" to "what am I choosing to give my life to?" The first question has no answer. The second is entirely in your hands.',
        reflectionQuestion:
            'What are you currently most deeply committed to — not what you should be, but what you actually are?',
        dailyPractice:
            'Write a personal mission statement — not a polished one for others to see, but a raw, honest statement of what you are choosing to give your life to. One paragraph.',
      ),
      CourseDay(
        day: 7,
        title: 'Living the Commitment',
        theme: 'Integration',
        content:
            'Existentialism does not end with philosophy — it begins there. The real work is translating these insights into daily lived practice. Sartre said: "Life has no meaning a priori... It is up to you to give it a meaning, and value is nothing but the meaning that you choose." The keyword is choose — not feel, not find, not receive.\n\nAuthentic existence is a daily discipline. Every time you catch yourself in bad faith ("I had no choice"), every time you notice anxiety and act anyway, every time you treat another person as a genuine freedom rather than a supporting character — you are practicing existentialism.\n\nThe goal is not to have solved the problem of meaning. The goal is to be genuinely engaged with it.',
        reflectionQuestion:
            'What one practice from this course will you carry forward into your daily life?',
        dailyPractice:
            'Write three commitments for the month ahead — one to yourself, one to a relationship, one to a project or contribution. Make them specific.',
      ),
    ],
  ),

  // ── TAOISM ───────────────────────────────────────────────────────────────────
  Course(
    id: 'taoism_7',
    title: 'The Tao of Less',
    subtitle: 'Find flow and release the grip',
    emoji: '☯️',
    philosophy: 'taoism',
    description:
        'A 7-day exploration of Taoist principles. Each day focuses on one foundational concept from the Tao Te Ching and Zhuangzi, with practices designed to cultivate wu wei, simplicity, and alignment with your own nature.',
    durationDays: 7,
    days: [
      CourseDay(
        day: 1,
        title: 'What Is the Tao?',
        theme: 'Foundation',
        content:
            'The Tao Te Ching opens with a paradox: "The Tao that can be named is not the eternal Tao." The Tao is the fundamental nature of reality — the ground from which all things arise, the pattern that connects everything, the way things flow. It cannot be grasped conceptually, only approached through stillness and simplicity.\n\nLaozi described the Tao through paradoxes: the Tao is empty, yet inexhaustible. It does nothing, yet nothing is left undone. The person who knows the Tao does not speak much about it. The person who speaks much about the Tao probably does not know it.\n\nYour relationship with the Tao is not intellectual. It is the quality of attention you bring to the actual texture of your experience.',
        reflectionQuestion:
            'When have you felt most in flow — most aligned with your own nature and the situation around you?',
        dailyPractice:
            'Spend 20 minutes outside today with no agenda and no phone. Simply observe. The Tao reveals itself through direct observation, not analysis.',
      ),
      CourseDay(
        day: 2,
        title: 'Wu Wei — Effortless Action',
        theme: 'Wu Wei',
        content:
            'Wu wei (無為) is the most misunderstood of all Taoist concepts. It does not mean passivity, laziness, or doing nothing. It means action that is fully aligned with the situation — neither forced nor absent, but precisely what the moment calls for.\n\nThe skilled craftsman of Zhuangzi does not impose their will on the material — they follow the natural structure of the wood or the ox, acting with the grain rather than against it. This is wu wei: not imposing, but responding. Not striving, but flowing.\n\nIn practical life, wu wei looks like: speaking when speech is needed, being silent when silence is needed, acting when action advances things, refraining when action would disturb them. The difficulty is distinguishing this from avoidance or laziness, which is the constant work.',
        reflectionQuestion:
            'Where in your life are you currently pushing against the grain — forcing an outcome, resisting a change, or acting from anxiety rather than clarity?',
        dailyPractice:
            'Today, before any significant action, pause and ask: "Is this what the situation genuinely calls for, or am I forcing it?" Act from the first, not the second.',
      ),
      CourseDay(
        day: 3,
        title: 'Simplicity',
        theme: 'Simplicity',
        content:
            'Laozi\'s prescription: "Reduce. Simplify. Slow down." The Tao Te Ching consistently points away from complexity, accumulation, and performance, toward what is natural, unadorned, and genuinely needed.\n\n"The more you know, the less you understand." This is not anti-intellectual — it is pointing at a specific kind of knowing that interferes with the direct apprehension of reality: the overlay of concepts, interpretations, and abstractions that prevent genuine perception.\n\nSimplicity in Taoist practice means: fewer desires, simpler speech, less performance of importance, more willingness to be ordinary. The person who is comfortable being unremarkable has more freedom than the person who needs to be impressive.',
        reflectionQuestion:
            'What in your life could be simplified — desires reduced, commitments pared back, performance dropped — without genuine loss?',
        dailyPractice:
            'Remove one thing from your day that is generating more complexity than value. Not forever — just for today. Observe what opens up.',
      ),
      CourseDay(
        day: 4,
        title: 'Yin and Yang',
        theme: 'Balance',
        content:
            'The yin-yang symbol is often reduced to a cliché, but its philosophical content is profound: opposites are not just coexisting but mutually generating and interdependent. There is no light without shadow, no strength without softness, no action without rest, no wisdom without experience of confusion.\n\nTaoism particularly emphasizes the power of yin — the soft, yielding, receptive principle. Water is yin, and water wears away stone. The Tao Te Ching: "The softest thing overcomes the hardest." This is not mere metaphor — it is an observation about power. Rigid things break; flexible things survive. Forceful things create resistance; yielding things dissolve it.\n\nThe practice is to find where you are being yang (forceful, rigid, pushing) when yin (soft, receptive, waiting) would be more effective.',
        reflectionQuestion:
            'Where are you currently being more forceful than the situation calls for? Where might yielding, waiting, or softening produce better results?',
        dailyPractice:
            'In one interaction today, practice deliberate yin: listen more than you speak, receive before you give, wait before you act.',
      ),
      CourseDay(
        day: 5,
        title: 'The Uncarved Block',
        theme: 'Authenticity',
        content:
            'Pu (樸) — the uncarved block — is a central Taoist metaphor for the original, unconditioned nature of a person before it has been shaped by social expectation, ambition, education, and performance. The block already contains all possibilities. The carving — adding identity, role, and narrative — reduces it.\n\nZhuangzi: "Let me tell you something about governing men... A perfect man of old looked after himself before looking to help others." This is not selfishness — it is the recognition that genuine contribution comes from genuine nature, not from performance of a role.\n\nPractice: where have you allowed social shaping to obscure your actual nature? Not the idealized "true self," but the specific things that are genuinely yours — your natural pace, your actual preferences, your honest responses.',
        reflectionQuestion:
            'If you stripped away all the roles you play and the expectations others have of you, what would remain? What is genuinely, originally yours?',
        dailyPractice:
            'For one hour today, act only from what you genuinely want to do — not from obligation, performance, or habit. Notice what that feels like.',
      ),
      CourseDay(
        day: 6,
        title: 'The Way of Water',
        theme: 'Persistence',
        content:
            'Laozi returns to water repeatedly as the supreme metaphor for the Tao and for the ideal character: "The highest good is like water. Water gives life to the ten thousand things and does not strive."\n\nWater possesses extraordinary qualities that appear paradoxical: it is the softest thing yet wears away the hardest; it flows downward (the humble direction) yet reaches everywhere; it takes the shape of whatever contains it (perfect wu wei) yet always returns to its own nature.\n\nThe practice of the "way of water" means cultivating these qualities: adaptability without loss of nature; persistence without force; serving without domination; seeking the lowest place (humility) rather than the highest.',
        reflectionQuestion:
            'What quality of water — persistence, adaptability, humility, or life-giving — do you most need to cultivate right now?',
        dailyPractice:
            'Choose one situation where you have been meeting resistance with more force. Today, try the water approach: yield, adapt, find another path.',
      ),
      CourseDay(
        day: 7,
        title: 'Living in Harmony',
        theme: 'Integration',
        content:
            'The Tao Te Ching ends not with a grand conclusion but with a return to simplicity: "The sage does not compete, and therefore no one can compete with him." A life in harmony with the Tao is not a life of achievement and accumulation but a life of genuine presence, appropriate action, and freedom from the turbulence of excessive desire.\n\nThis does not mean withdrawal from life. The Taoist engaged in the world, as emperor, craftsman, gardener, parent — the difference is the quality of engagement: flowing rather than forcing, responding rather than imposing, serving rather than dominating.\n\nYour invitation from Taoism: simplify one area of your life, practice wu wei in one relationship, and cultivate the capacity to be still.',
        reflectionQuestion:
            'What one change would most bring your life into greater alignment with your own nature and the natural flow of things?',
        dailyPractice:
            'Sit in complete stillness for 20 minutes. No phone, no meditation app, no goal. Simply be. What does stillness reveal about what matters?',
      ),
    ],
  ),
];
