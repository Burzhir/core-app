import 'package:flutter/material.dart';
import '../models/philosophy_model.dart';

const List<PhilosophyModel> kPhilosophies = [
  // ── 1. STOICISM ─────────────────────────────────────────────────────────────
  PhilosophyModel(
    id: 'stoicism',
    name: 'Stoicism',
    emoji: '⚖️',
    gradient: [Color(0xFFD4AF37), Color(0xFF8B5E00)],
    tagline: 'Control what you can. Release what you cannot.',
    overview:
        'Founded in Athens around 300 BCE by Zeno of Citium, Stoicism teaches that virtue — wisdom, courage, justice, and temperance — is the only true good. External circumstances such as wealth, health, and reputation are indifferent: they are neither good nor bad in themselves. We do not suffer from events but from our judgments about them. The path to a good life is to align our will with nature and reason, and to distinguish relentlessly between what is within our power and what is not.',
    coreBeliefs: [
      'The dichotomy of control: our judgments, desires, and actions are "up to us." Everything else — outcomes, others\' opinions, health — is not.',
      'Virtue is the only genuine good. Everything else is "preferred indifferent" — useful, but not worth compromising your character for.',
      'Emotions arise from false judgments. Destructive emotions can be dissolved by examining the beliefs underlying them.',
      'We are all part of a rational cosmos. What is good for the whole is good for us, even when it is painful.',
      'Negative visualization (premeditatio malorum): regularly imagining loss trains genuine appreciation and removes fear.',
    ],
    keyThinkers: [
      'Marcus Aurelius',
      'Epictetus',
      'Seneca',
      'Zeno of Citium',
      'Chrysippus'
    ],
    practicalApplication:
        'When something upsets you, ask one question: "Is this in my control?" If not, your suffering is optional — chosen by the story you are telling. If yes, act. Stoics keep a daily journal not to record events but to examine their responses. Marcus Aurelius wrote his private notes not for publication but to hold himself accountable to his own principles. Start there: write one thing that bothered you today, one judgment you made about it, and one you would make instead if you were at your best.',
    criticisms:
        'Critics argue Stoicism can suppress legitimate emotional expression, encouraging a kind of emotional numbness that looks like strength but avoids genuine processing. The dichotomy of control may be used to justify passivity toward systemic injustice — "it\'s not in my control" becomes an excuse for disengagement. The ideal of the Stoic sage — perfectly rational, unmoved by passion — is inhuman and perhaps counterproductive as a goal. Stoicism also emerged from a position of relative privilege; for many, circumstances genuinely are the problem, not merely one\'s judgments about them.',
    dailyContent: [
      DailyPhilosophyContent(
        quote:
            'You have power over your mind, not outside events. Realize this, and you will find strength.',
        quoteAuthor: 'Marcus Aurelius',
        reflectionQuestion:
            'What have you been giving mental energy to today that is genuinely outside your control?',
        actionChallenge:
            'Write three things worrying you. Mark each "in my control" or "not in my control." Spend the next hour only on the first category.',
      ),
      DailyPhilosophyContent(
        quote: 'We suffer more in imagination than in reality.',
        quoteAuthor: 'Seneca',
        reflectionQuestion:
            'What is the worst-case scenario you have been dreading? How likely is it, really?',
        actionChallenge:
            'Write your worst fear about one situation. Then write the most realistic outcome. Notice the gap.',
      ),
      DailyPhilosophyContent(
        quote:
            'Make the best use of what is in your power, and take the rest as it happens.',
        quoteAuthor: 'Epictetus',
        reflectionQuestion:
            'Where are you waiting for perfect conditions before acting on something important?',
        actionChallenge:
            'Take one action today on something you\'ve been delaying because circumstances aren\'t ideal.',
      ),
      DailyPhilosophyContent(
        quote:
            'Loss is nothing else but change, and change is Nature\'s delight.',
        quoteAuthor: 'Marcus Aurelius',
        reflectionQuestion:
            'What are you struggling to accept as changed that you cannot change back?',
        actionChallenge:
            'Sit with one loss or ending for five minutes. Say to yourself: "This is nature. This is how things go."',
      ),
      DailyPhilosophyContent(
        quote:
            'Begin at once to live, and count each separate day as a separate life.',
        quoteAuthor: 'Seneca',
        reflectionQuestion:
            'If today were complete in itself, would you be satisfied with how you lived it?',
        actionChallenge:
            'Identify one thing you\'ve been postponing "until later." Do part of it today.',
      ),
      DailyPhilosophyContent(
        quote:
            'It is not death that a man should fear, but he should fear never beginning to live.',
        quoteAuthor: 'Marcus Aurelius',
        reflectionQuestion:
            'What would you do differently if you were not afraid of judgment or failure?',
        actionChallenge:
            'Do one small thing today that fear has been preventing. It does not have to be large.',
      ),
      DailyPhilosophyContent(
        quote:
            'The impediment to action advances action. What stands in the way becomes the way.',
        quoteAuthor: 'Marcus Aurelius',
        reflectionQuestion:
            'What obstacle in your life could be reframed as exactly the training you need?',
        actionChallenge:
            'Write down your biggest current obstacle. Then write three ways it could be making you stronger.',
      ),
    ],
  ),

  // ── 2. EXISTENTIALISM ────────────────────────────────────────────────────────
  PhilosophyModel(
    id: 'existentialism',
    name: 'Existentialism',
    emoji: '🌌',
    gradient: [Color(0xFF9B8EC4), Color(0xFF2C3E50)],
    tagline: 'Existence precedes essence. You define yourself.',
    overview:
        'Existentialism holds that humans exist first and define themselves afterward — there is no pre-given human nature, no fixed purpose handed to us by God or evolution. We are "condemned to be free," as Sartre put it: radically responsible for every choice, unable to hide behind excuses of fate or circumstance. This freedom is terrifying (existential anxiety) and exhilarating in equal measure. Authenticity — living in accordance with your own honestly examined values rather than collapsing into social expectations — is the core existentialist virtue.',
    coreBeliefs: [
      'Existence precedes essence: we have no fixed nature or pre-given purpose. We create ourselves through our choices.',
      'Radical freedom and radical responsibility: we cannot escape choosing, and every choice defines us.',
      'Bad faith (mauvaise foi): lying to yourself about your freedom — "I had no choice," "that\'s just how I am" — is existential cowardice.',
      'Authenticity: living honestly according to your own examined values, not borrowed ones.',
      'Intersubjectivity: others are not obstacles to freedom but the very mirror in which we discover ourselves.',
    ],
    keyThinkers: [
      'Jean-Paul Sartre',
      'Simone de Beauvoir',
      'Albert Camus',
      'Søren Kierkegaard',
      'Martin Heidegger'
    ],
    practicalApplication:
        'Existentialism gives you a powerful diagnostic tool: whenever you feel stuck, trapped, or victimized, examine whether you are in bad faith — pretending you have less freedom than you actually do. This is not about blaming yourself but about reclaiming agency. Sartre argued that even the refusal to choose is a choice. Start by asking: "What am I pretending I cannot change?" Then ask: "What am I afraid would happen if I took responsibility for changing it?" That fear — not circumstance — is usually the actual obstacle.',
    criticisms:
        'Existentialism can trigger decision paralysis: if every choice matters enormously and defines who you are, choosing becomes unbearable. Critics argue it underestimates how much social structures, class, race, and trauma genuinely constrain freedom — radical responsibility can slide into blaming the oppressed for their own oppression. The emphasis on individual authenticity can also become narcissistic, elevating personal truth above community and care. Existential anxiety, treated as an inescapable condition, can be counterproductive for those already prone to anxiety disorders.',
    dailyContent: [
      DailyPhilosophyContent(
        quote:
            'Man is condemned to be free; because once thrown into the world, he is responsible for everything he does.',
        quoteAuthor: 'Jean-Paul Sartre',
        reflectionQuestion:
            'What is one situation in your life where you have been acting as if you had no choice?',
        actionChallenge:
            'Identify a decision you have been avoiding. Make a clear, deliberate choice about it today — even if the choice is "not yet."',
      ),
      DailyPhilosophyContent(
        quote:
            'Life has no meaning the moment you lose the illusion of being eternal.',
        quoteAuthor: 'Jean-Paul Sartre',
        reflectionQuestion:
            'If you knew you had one year left, which of your current priorities would you keep?',
        actionChallenge:
            'Write your top five current priorities. Then write what your priorities would be if time were visibly limited. Compare them honestly.',
      ),
      DailyPhilosophyContent(
        quote: 'One is not born, but rather becomes, a woman.',
        quoteAuthor: 'Simone de Beauvoir',
        reflectionQuestion:
            'Which of your traits do you treat as fixed that are actually choices you keep making?',
        actionChallenge:
            'Choose one identity ("I\'m not a morning person," "I\'m bad at confrontation") and do the opposite once today.',
      ),
      DailyPhilosophyContent(
        quote: 'The most common form of despair is not being who you are.',
        quoteAuthor: 'Søren Kierkegaard',
        reflectionQuestion:
            'Where in your life are you performing a version of yourself that is not quite true?',
        actionChallenge:
            'Have one conversation today where you say what you actually think rather than what is expected.',
      ),
      DailyPhilosophyContent(
        quote:
            'We do not know what we want and yet we are responsible for what we are.',
        quoteAuthor: 'Jean-Paul Sartre',
        reflectionQuestion:
            'What do you actually want — not what you\'re supposed to want?',
        actionChallenge:
            'Write for 10 minutes without stopping about what you genuinely want from your life. Do not censor.',
      ),
      DailyPhilosophyContent(
        quote:
            'In life, man commits himself and draws his own portrait, outside of which there is nothing.',
        quoteAuthor: 'Jean-Paul Sartre',
        reflectionQuestion:
            'Looking at your actions of the past week, what kind of person do they portray?',
        actionChallenge:
            'Write the kind of person you want to be. Then write three specific actions that person would take this week.',
      ),
      DailyPhilosophyContent(
        quote: 'Anxiety is the dizziness of freedom.',
        quoteAuthor: 'Søren Kierkegaard',
        reflectionQuestion:
            'When did anxiety last stop you from exercising a freedom that was genuinely yours?',
        actionChallenge:
            'Do one thing today that makes you anxious because it matters to you. The anxiety is the sign that it is real.',
      ),
    ],
  ),

  // ── 3. ABSURDISM ─────────────────────────────────────────────────────────────
  PhilosophyModel(
    id: 'absurdism',
    name: 'Absurdism',
    emoji: '🎭',
    gradient: [Color(0xFFBF5AF2), Color(0xFF5E5CE6)],
    tagline: 'Life is meaningless. Live anyway — with everything.',
    overview:
        'Albert Camus proposed that the fundamental tension of human life is the collision between our desperate need for meaning, clarity, and order, and the universe\'s absolute silence in response. This gap is the Absurd. Camus rejected two common responses: suicide (giving up) and the "leap of faith" (pretending the silence has been answered). Instead he proposed revolt — a conscious refusal to be defeated by meaninglessness — combined with freedom and passion. To live fully despite knowing it doesn\'t ultimately matter is, for Camus, the only authentic response to being human.',
    coreBeliefs: [
      'The Absurd is the conflict between the human need for meaning and the universe\'s silence. It cannot be resolved, only lived.',
      'Neither suicide nor religious escape is an honest answer to the Absurd.',
      'Revolt: a daily, conscious refusal to be crushed by meaninglessness.',
      'Freedom: once you abandon the illusion of higher purpose, you are free to live entirely on your own terms.',
      'Passion: without eternal stakes, intensity of experience becomes its own justification.',
    ],
    keyThinkers: [
      'Albert Camus',
      'Søren Kierkegaard (rejected)',
      'Franz Kafka',
      'Samuel Beckett'
    ],
    practicalApplication:
        'Absurdism is most useful when you notice you are suffering because things "should" be different or have a clear purpose. Camus\'s answer: they don\'t, and that is fine. Sisyphus is condemned to roll a boulder up a hill forever. Camus\'s final sentence in The Myth of Sisyphus is: "One must imagine Sisyphus happy." Not because the task has meaning, but because he has chosen to be fully present to it. Apply this to the repetitive, thankless, or meaningless-seeming parts of your own life: can you bring full presence and revolt rather than resentment?',
    criticisms:
        'Absurdism is philosophically compelling but offers little practical guidance when you actually have to make ethical choices. Camus\'s insistence on revolt and passion can seem like an aesthetic pose rather than a livable ethic. Critics note it does not adequately address obligations to other people or to justice. Nietzsche and Sartre both found it too passive — mere acceptance of the void rather than active creation. For those in genuine crisis, "live fully anyway" can feel like an unhelpful cheerleading from a position of relative comfort.',
    dailyContent: [
      DailyPhilosophyContent(
        quote: 'One must imagine Sisyphus happy.',
        quoteAuthor: 'Albert Camus',
        reflectionQuestion:
            'What repetitive, seemingly pointless task in your life could be fully embraced rather than resented?',
        actionChallenge:
            'Do one routine task today with complete, deliberate presence. Treat it as if it were inherently worth doing.',
      ),
      DailyPhilosophyContent(
        quote:
            'The only way to deal with an unfree world is to become so absolutely free that your very existence is an act of rebellion.',
        quoteAuthor: 'Albert Camus',
        reflectionQuestion:
            'Where are you waiting for permission to live the way you actually want to?',
        actionChallenge:
            'Do one thing today that is entirely for yourself — not productive, not impressive, simply something you enjoy.',
      ),
      DailyPhilosophyContent(
        quote:
            'In the depth of winter, I finally learned that within me there lay an invincible summer.',
        quoteAuthor: 'Albert Camus',
        reflectionQuestion:
            'When did you last discover inner resilience you didn\'t know you had?',
        actionChallenge:
            'Write about one difficult period you survived. What did you find in yourself that surprised you?',
      ),
      DailyPhilosophyContent(
        quote: 'The absurd is the essential concept and the first truth.',
        quoteAuthor: 'Albert Camus',
        reflectionQuestion:
            'What in your life are you still trying to make "make sense" that never will?',
        actionChallenge:
            'Write one situation you have been analyzing obsessively. Then write: "This may never make sense. I can live with that."',
      ),
      DailyPhilosophyContent(
        quote: 'Don\'t wait for the last judgment. It takes place every day.',
        quoteAuthor: 'Albert Camus',
        reflectionQuestion:
            'Are you living in a way that, today, you would be proud of?',
        actionChallenge:
            'At the end of today, write one sentence verdict on how you lived it. Not harshly — honestly.',
      ),
      DailyPhilosophyContent(
        quote: 'I rebel; therefore we exist.',
        quoteAuthor: 'Albert Camus',
        reflectionQuestion:
            'What injustice or absurdity in your life are you too resigned to?',
        actionChallenge:
            'Choose one thing that is wrong with your situation. Take one small act of resistance — even symbolic.',
      ),
      DailyPhilosophyContent(
        quote:
            'The struggle itself towards the heights is enough to fill a man\'s heart.',
        quoteAuthor: 'Albert Camus',
        reflectionQuestion:
            'Are you enjoying the process of something, or are you only tolerating it until you reach the outcome?',
        actionChallenge:
            'Find one project or goal you are treating as a means to an end. Engage with it today as if the process were the point.',
      ),
    ],
  ),

  // ── 4. NIHILISM ──────────────────────────────────────────────────────────────
  PhilosophyModel(
    id: 'nihilism',
    name: 'Nihilism',
    emoji: '🖤',
    gradient: [Color(0xFF4A5568), Color(0xFF1A1A2E)],
    tagline: 'Nothing is inherently meaningful. Create your own or don\'t.',
    overview:
        'Nihilism — from the Latin nihil, "nothing" — is the view that life has no objective meaning, purpose, or intrinsic value. While often portrayed as the bleakest of philosophies, Nietzsche (who diagnosed nihilism rather than endorsed it) saw it as a necessary stage: the old values are dead, the new ones have not yet been created. This "active nihilism" is a clearing — painful but necessary — that forces authentic self-creation. The challenge nihilism poses is not "nothing matters" as an endpoint, but "now what?" as a beginning.',
    coreBeliefs: [
      'No objective meaning, purpose, or moral truth exists independently of human minds.',
      '"God is dead" — not a theological claim, but a cultural diagnosis: the frameworks that gave traditional life coherence have collapsed.',
      'Passive nihilism accepts meaninglessness and collapses into despair. Active nihilism uses the void to create new values.',
      'The will to power is not domination of others but self-overcoming — the drive to become who you truly are.',
      'The Übermensch (overman) is not a superman but someone who creates values rather than inheriting them.',
    ],
    keyThinkers: [
      'Friedrich Nietzsche',
      'Arthur Schopenhauer',
      'Ivan Turgenev'
    ],
    practicalApplication:
        'Nihilism at its most useful is a diagnostic, not a destination. When you notice you have been operating on values you absorbed from family, culture, or religion without ever choosing them, nihilism is the acid that dissolves them so you can examine what, if anything, you want to replace them with. The question is not "does anything matter?" but "what do I — on examination, freely — choose to treat as mattering?" Nietzsche\'s answer was: create beauty, pursue excellence, affirm life so completely that you would choose to live it again, exactly as it was. That is not despair. That is the hardest form of courage.',
    criticisms:
        'Nihilism has historically been misappropriated to justify cruelty, indifference, and atrocity on the grounds that "nothing matters anyway." Nietzsche himself was horrified by proto-Nazi misreadings of his work. Passive nihilism — the "nothing matters so why try" conclusion — is associated with depression, anhedonia, and social withdrawal. Without a constructive step beyond mere negation, nihilism offers no resources for ethics, relationships, or community. It is also arguably self-refuting: if nothing matters, neither does nihilism.',
    dailyContent: [
      DailyPhilosophyContent(
        quote:
            'God is dead. God remains dead. And we have killed him. How shall we comfort ourselves, the murderers of all murderers?',
        quoteAuthor: 'Friedrich Nietzsche',
        reflectionQuestion:
            'Which of the values you live by did you actually choose, and which did you simply inherit?',
        actionChallenge:
            'Write five values you operate by. Next to each, write where it came from. Circle the ones you\'d freely choose again.',
      ),
      DailyPhilosophyContent(
        quote: 'That which does not kill us makes us stronger.',
        quoteAuthor: 'Friedrich Nietzsche',
        reflectionQuestion:
            'What difficulty have you experienced that, honestly, made you better?',
        actionChallenge:
            'Write about one painful period of your life. Describe specifically what it built in you.',
      ),
      DailyPhilosophyContent(
        quote: 'Without music, life would be a mistake.',
        quoteAuthor: 'Friedrich Nietzsche',
        reflectionQuestion:
            'What in your life — what activity, relationship, or experience — makes it unmistakably worth living?',
        actionChallenge:
            'Protect one hour today for the thing that makes you feel most alive. Guard it as non-negotiable.',
      ),
      DailyPhilosophyContent(
        quote:
            'To live is to suffer, to survive is to find some meaning in the suffering.',
        quoteAuthor: 'Friedrich Nietzsche',
        reflectionQuestion:
            'What suffering in your life has been made more bearable by finding meaning in it?',
        actionChallenge:
            'Write about a current difficulty. Then write the best possible meaning you could honestly attach to it.',
      ),
      DailyPhilosophyContent(
        quote: 'The most courageous act is still to think for yourself. Aloud.',
        quoteAuthor: 'Coco Chanel (Nietzschean spirit)',
        reflectionQuestion:
            'Where are you staying silent about what you actually believe because it would be unpopular?',
        actionChallenge:
            'Express one genuine opinion today that you have been softening to avoid conflict.',
      ),
      DailyPhilosophyContent(
        quote:
            'In individuals, insanity is rare; but in groups, parties, nations, and epochs, it is the rule.',
        quoteAuthor: 'Friedrich Nietzsche',
        reflectionQuestion:
            'What group belief do you follow that, examined individually, you would question?',
        actionChallenge:
            'Pick one widely held belief in your circle. Argue seriously against it — in your journal, not necessarily out loud.',
      ),
      DailyPhilosophyContent(
        quote:
            'You must have chaos within you to give birth to a dancing star.',
        quoteAuthor: 'Friedrich Nietzsche',
        reflectionQuestion:
            'What internal chaos — confusion, contradiction, restlessness — might actually be creative energy?',
        actionChallenge:
            'Take the most chaotic, unresolved feeling you have and use it to create something: a drawing, a paragraph, a plan.',
      ),
    ],
  ),

  // ── 5. TAOISM ────────────────────────────────────────────────────────────────
  PhilosophyModel(
    id: 'taoism',
    name: 'Taoism',
    emoji: '☯️',
    gradient: [Color(0xFF66BB6A), Color(0xFF1B5E20)],
    tagline: 'The Tao that can be named is not the eternal Tao.',
    overview:
        'Taoism is an ancient Chinese philosophy centred on the Tao (道) — the Way, the natural order and flow underlying all existence. Where Western philosophy often asks "what should I do?" Taoism asks "how should I be?" Its key concept is wu wei (無為) — effortless, non-forced action aligned with nature rather than imposed on it. Water is the Taoist symbol: yielding, soft, but wearing away stone. Taoism teaches that striving, forcing, and over-controlling produce their own undoing, while genuine emptiness and stillness contain everything.',
    coreBeliefs: [
      'The Tao is the fundamental nature of reality — not a god, not a force, but the ground of all being. It cannot be fully described in words.',
      'Wu wei: acting in harmony with the natural flow of events rather than forcing outcomes. Effortless action, not passivity.',
      'Yin and yang: opposites are interdependent and mutually generating. Strength contains weakness; fullness contains emptiness.',
      'Te (virtue/power): living in harmony with the Tao manifests as genuine strength and natural authority.',
      'Simplicity and return: strip away artificial desires, social performance, and unnecessary complexity. What remains is what is real.',
    ],
    keyThinkers: ['Laozi', 'Zhuangzi', 'Liezi'],
    practicalApplication:
        'Taoism is most practically useful in two situations: when you are exhausted by striving, and when you are trying to force a resolution to something that needs to unfold on its own time. Wu wei does not mean doing nothing — it means doing what the situation genuinely calls for, not what your anxiety, ego, or impatience demands. The question to ask is: "Am I pushing because this action is genuinely needed, or because I am afraid of what will happen if I stop pushing?" Very often, the anxiety behind frantic effort produces exactly the outcomes it fears.',
    criticisms:
        'Taoism\'s vagueness is both its strength and weakness. "Go with the flow" can justify indecision, irresponsibility, and passivity toward genuine injustice. The Taoist tradition has been criticized for political conservatism — accepting the natural order can mean accepting oppression. Its mysticism makes it difficult to apply systematically. Western adaptations often strip away the rigorous self-cultivation practice that makes Taoism genuinely transformative, reducing it to aesthetic minimalism or pop-psychology acceptance.',
    dailyContent: [
      DailyPhilosophyContent(
        quote:
            'Knowing others is intelligence; knowing yourself is true wisdom. Mastering others is strength; mastering yourself is true power.',
        quoteAuthor: 'Laozi',
        reflectionQuestion:
            'What situation are you currently trying to control that is really asking you to understand yourself better?',
        actionChallenge:
            'Spend 10 minutes in complete stillness today. No phone, no task. Just observe what arises in you.',
      ),
      DailyPhilosophyContent(
        quote: 'Nature does not hurry, yet everything is accomplished.',
        quoteAuthor: 'Laozi',
        reflectionQuestion:
            'What are you rushing that would benefit from being given more time?',
        actionChallenge:
            'Choose one thing you\'ve been forcing. Take one deliberate step back and allow it to develop at its own pace today.',
      ),
      DailyPhilosophyContent(
        quote:
            'When you realize there is nothing lacking, the whole world belongs to you.',
        quoteAuthor: 'Laozi',
        reflectionQuestion:
            'What do you have right now that you take for granted but would desperately miss?',
        actionChallenge:
            'Write five things in your current life that are genuinely good. Sit with them for one minute each.',
      ),
      DailyPhilosophyContent(
        quote:
            'Life is a series of natural and spontaneous changes. Don\'t resist them; that only creates sorrow.',
        quoteAuthor: 'Laozi',
        reflectionQuestion:
            'What change are you resisting that has already happened?',
        actionChallenge:
            'Write about one ended chapter in your life. Then write what the next chapter might be, starting from where things actually are.',
      ),
      DailyPhilosophyContent(
        quote: 'The flame that burns twice as bright burns half as long.',
        quoteAuthor: 'Laozi',
        reflectionQuestion:
            'Where are you burning yourself out trying to maintain an unsustainable pace?',
        actionChallenge:
            'Cancel or postpone one non-essential obligation today. Rest is not laziness — it is wu wei.',
      ),
      DailyPhilosophyContent(
        quote:
            'Simplicity, patience, compassion. These three are your greatest treasures.',
        quoteAuthor: 'Laozi',
        reflectionQuestion:
            'What would become simpler in your life if you were more patient?',
        actionChallenge:
            'Identify one place where impatience is causing you to complicate things. Practice deliberate slowness there today.',
      ),
      DailyPhilosophyContent(
        quote: 'The usefulness of a pot comes from its emptiness.',
        quoteAuthor: 'Laozi',
        reflectionQuestion:
            'What would you be able to receive or create if you created more emptiness — less busyness, less noise?',
        actionChallenge:
            'Find 20 minutes of genuine empty time today. Not meditation, not a nap — just unscheduled space.',
      ),
    ],
  ),

  // ── 6. HUMANISM ──────────────────────────────────────────────────────────────
  PhilosophyModel(
    id: 'humanism',
    name: 'Humanism',
    emoji: '🌍',
    gradient: [Color(0xFF4A90D9), Color(0xFF2ECC71)],
    tagline:
        'Human dignity, reason, and compassion — nothing supernatural required.',
    overview:
        'Humanism is a philosophical and ethical orientation that affirms the value and agency of human beings, individually and collectively. It holds that through reason, evidence, and compassion — rather than divine revelation or metaphysical authority — humans can discover how to live well and build a just society. Humanism is not anti-religious in its essence but rejects supernatural explanations and authorities as the basis for ethics or knowledge. It places the full weight of responsibility for human flourishing on human beings themselves.',
    coreBeliefs: [
      'Human beings have inherent dignity and worth, regardless of their beliefs, origin, or productivity.',
      'Reason and critical thinking are the most reliable guides to truth and ethical decision-making.',
      'This life — not an afterlife — is what matters. Our responsibility is to make it as good as possible for as many as possible.',
      'Morality is built from human experience, empathy, and reason — not derived from divine command.',
      'Education, science, and democratic cooperation are the primary tools for human progress.',
    ],
    keyThinkers: [
      'Erasmus',
      'John Dewey',
      'Bertrand Russell',
      'Erich Fromm',
      'Carl Sagan'
    ],
    practicalApplication:
        'Humanism is particularly useful when you are struggling with guilt derived from religious or cultural frameworks you have outgrown, or when you are trying to build an ethical foundation without traditional belief. The humanist question is: "What would genuinely serve human flourishing — mine and others\'?" This reframes morality from obedience to a code into a genuine inquiry. Humanism also encourages civic engagement: the world does not improve by itself, and retreat into private virtue is not enough. Where are you in a position to contribute to something larger than your own life?',
    criticisms:
        'Critics argue humanism places too much faith in human reason — a faculty demonstrably prone to bias, motivated reasoning, and catastrophic error. Its optimism about progress has been challenged by the 20th century\'s atrocities, many committed in the name of rational ideologies. Humanism can be anthropocentric in ways that justify exploitation of non-human life and the natural world. Its secular basis may feel insufficient for those who find that reason alone does not fully address grief, meaning, and the confrontation with death.',
    dailyContent: [
      DailyPhilosophyContent(
        quote:
            'The purpose of life is to live it, to taste experience to the utmost, to reach out eagerly and without fear for newer and richer experience.',
        quoteAuthor: 'Eleanor Roosevelt',
        reflectionQuestion:
            'What experience have you been avoiding that you know would enrich you?',
        actionChallenge:
            'Say yes to one thing today that you would normally decline out of caution or comfort.',
      ),
      DailyPhilosophyContent(
        quote: 'Wonder is the beginning of wisdom.',
        quoteAuthor: 'Socrates',
        reflectionQuestion:
            'What do you not yet understand about a person in your life that you\'ve been assuming you do?',
        actionChallenge:
            'Ask someone a genuine question today — not to confirm what you already think, but to actually discover something.',
      ),
      DailyPhilosophyContent(
        quote: 'Do not wait for leaders; do it alone, person to person.',
        quoteAuthor: 'Mother Teresa',
        reflectionQuestion:
            'What injustice or suffering near you have you been waiting for someone else to address?',
        actionChallenge:
            'Take one small concrete action today for another person who needs it, with no expectation of recognition.',
      ),
      DailyPhilosophyContent(
        quote: 'The good life is one inspired by love and guided by knowledge.',
        quoteAuthor: 'Bertrand Russell',
        reflectionQuestion:
            'Are love and knowledge directing your current choices, or are fear and habit?',
        actionChallenge:
            'Make one decision today based on what you know to be true and who you love, rather than what you fear.',
      ),
      DailyPhilosophyContent(
        quote:
            'Educating the mind without educating the heart is no education at all.',
        quoteAuthor: 'Aristotle',
        reflectionQuestion:
            'Where are you applying intelligence without empathy in your current relationships?',
        actionChallenge:
            'Have a conversation today where you lead with curiosity and care rather than analysis and being right.',
      ),
      DailyPhilosophyContent(
        quote: 'Be the change you wish to see in the world.',
        quoteAuthor: 'Mahatma Gandhi',
        reflectionQuestion:
            'What kind of world do you want to live in, and what aspect of it are you embodying?',
        actionChallenge:
            'Choose one trait you admire in others (generosity, patience, courage) and express it once today.',
      ),
      DailyPhilosophyContent(
        quote: 'We are as much alive as we keep the earth alive.',
        quoteAuthor: 'Chief Dan George',
        reflectionQuestion:
            'How are your daily habits contributing to — or detracting from — the world you say you want?',
        actionChallenge:
            'Make one small change today that aligns your daily actions more closely with your stated values.',
      ),
    ],
  ),

  // ── 7. PRAGMATISM ────────────────────────────────────────────────────────────
  PhilosophyModel(
    id: 'pragmatism',
    name: 'Pragmatism',
    emoji: '⚙️',
    gradient: [Color(0xFF80CBC4), Color(0xFF00695C)],
    tagline: 'Truth is what works. Ideas are tools, not dogmas.',
    overview:
        'Pragmatism is a distinctly American philosophical tradition holding that the meaning and value of an idea lies in its practical consequences. Rather than asking "is this true in some abstract sense?" pragmatists ask "what difference does it make whether we believe this?" Truth is not a fixed correspondence to an independent reality but a property ideas acquire insofar as they help us navigate and act in the world. Knowledge is provisional — always subject to revision in light of new experience — and inquiry is fundamentally a problem-solving activity.',
    coreBeliefs: [
      'An idea is true to the extent that it works — that believing it leads to successful action and problem-solving.',
      'Truth is not discovered; it is made through successful practice and verified through consequences.',
      'All knowledge is provisional and fallible. We act on our best current understanding, expecting to revise.',
      'Abstract theory without practical application is philosophically suspect.',
      'Democracy, education, and open inquiry are the social institutions best suited to collective problem-solving.',
    ],
    keyThinkers: [
      'William James',
      'John Dewey',
      'Charles Sanders Peirce',
      'Richard Rorty'
    ],
    practicalApplication:
        'Pragmatism is immediately useful when you are stuck in ideological or theoretical arguments that are not helping you solve your actual problem. The pragmatist question is: "What would believing X cause me to do differently? And would those actions produce better outcomes?" This cuts through abstract debates about what is "really" true or what you "should" believe and refocuses on what is working and what is not. It also frees you from bad sunk-cost thinking: if a strategy, belief, or relationship is not producing the outcomes you need, pragmatism permits you to revise without feeling like a hypocrite.',
    criticisms:
        'Pragmatism is accused of reducing truth to usefulness — which can justify deeply immoral beliefs if they happen to "work" for someone. Critics note it lacks a robust theory of justice: what works for the powerful may not work for the marginalized. Pragmatism\'s anti-foundationalism can slide into relativism, making it hard to criticize practices that are locally "useful." The insistence on practical consequences also struggles with art, religion, and experiences that resist reduction to outcomes.',
    dailyContent: [
      DailyPhilosophyContent(
        quote: 'Act as if what you do makes a difference. It does.',
        quoteAuthor: 'William James',
        reflectionQuestion:
            'What is one area where you have been acting as if your efforts are pointless?',
        actionChallenge:
            'Take one concrete action today in that area — not because results are guaranteed, but because acting is itself meaningful.',
      ),
      DailyPhilosophyContent(
        quote:
            'The greatest discovery of my generation is that human beings can alter their lives by altering their attitudes of mind.',
        quoteAuthor: 'William James',
        reflectionQuestion:
            'What attitude — if you genuinely shifted it — would most change your current situation?',
        actionChallenge:
            'Identify one unhelpful belief you hold about yourself. Write a replacement belief that would produce better actions. Act from it once today.',
      ),
      DailyPhilosophyContent(
        quote:
            'Wisdom is knowing what to do next, skill is knowing how to do it, and virtue is doing it.',
        quoteAuthor: 'David Starr Jordan',
        reflectionQuestion:
            'What do you already know you should do next, but are avoiding?',
        actionChallenge:
            'Do the thing you already know you should do. Not perfectly — just begin.',
      ),
      DailyPhilosophyContent(
        quote:
            'The test of a first-rate intelligence is the ability to hold two opposed ideas in the mind at the same time and still retain the ability to function.',
        quoteAuthor: 'F. Scott Fitzgerald',
        reflectionQuestion:
            'Where are you forcing certainty in a situation that is genuinely uncertain?',
        actionChallenge:
            'Write two genuinely contradictory interpretations of a difficult situation in your life. Sit with both as possibly true.',
      ),
      DailyPhilosophyContent(
        quote: 'A problem well stated is a problem half solved.',
        quoteAuthor: 'John Dewey',
        reflectionQuestion:
            'What problem have you been trying to solve without first clearly defining what the actual problem is?',
        actionChallenge:
            'Write your main current problem in one clear sentence. Then rewrite it three different ways. Notice which formulation feels most accurate.',
      ),
      DailyPhilosophyContent(
        quote:
            'Failure is instructive. The person who really thinks learns quite as much from his failures as from his successes.',
        quoteAuthor: 'John Dewey',
        reflectionQuestion:
            'What recent failure have you been dismissing rather than learning from?',
        actionChallenge:
            'Write three specific lessons from a recent failure. Then write one change you will make because of them.',
      ),
      DailyPhilosophyContent(
        quote:
            'We do not learn from experience; we learn from reflecting on experience.',
        quoteAuthor: 'John Dewey',
        reflectionQuestion:
            'When did you last reflect — genuinely, not defensively — on something that did not go well?',
        actionChallenge:
            'Spend 15 minutes writing an honest post-mortem on something recent that fell short. Focus on what you would do differently.',
      ),
    ],
  ),

  // ── 8. EPICUREANISM ──────────────────────────────────────────────────────────
  PhilosophyModel(
    id: 'epicureanism',
    name: 'Epicureanism',
    emoji: '🌿',
    gradient: [Color(0xFFA5D6A7), Color(0xFF1B5E20)],
    tagline: 'Seek tranquility, not excess. The good life is quiet and free.',
    overview:
        'Epicurus (341–270 BCE) taught that the highest human good is pleasure — but not the hedonism of popular imagination. He distinguished between kinetic pleasures (active pleasures of the senses) and catastematic pleasures (stable states of tranquility and absence of pain). The goal is ataraxia — a deep, untroubled calm — and aponia, freedom from physical pain. Epicurus believed true pleasure comes from simple things: good food shared with friends, philosophical conversation, freedom from fear of death and gods. Intense excitement and luxury actually disturb the peace we seek.',
    coreBeliefs: [
      'Pleasure is the highest good, but the greatest pleasure is tranquility (ataraxia) — freedom from mental disturbance.',
      'Most desires are unnecessary. Distinguish natural/necessary desires (food, shelter, friendship) from vain ones (fame, luxury).',
      'Friendship is the greatest external source of happiness. Build it deliberately and protect it fiercely.',
      'Death is nothing to fear: "When death is, I am not; when I am, death is not."',
      'Freedom from fear — of gods, death, and pain — is the precondition of happiness.',
    ],
    keyThinkers: ['Epicurus', 'Lucretius', 'Metrodorus'],
    practicalApplication:
        'Epicureanism is most useful when you are caught in the hedonic treadmill — always pursuing the next bigger pleasure while the last one has already faded. Epicurus\'s prescription is radical simplification: identify your truly necessary desires and satisfy them reliably, then invest the remainder of your energy in deep friendships and philosophical self-understanding. He also offers a striking framework for anxiety: most of what we fear is either outside our control, unlikely, or involves death — which we will not be present to experience. The Epicurean practice is to genuinely examine your fears and ask which ones are worth the mental energy you are spending on them.',
    criticisms:
        'Epicureanism is criticized for its retreat from civic and political life — "live hidden," as the slogan goes. This privatism has been seen as irresponsible by those who believe philosophy should engage with social reality. The emphasis on friendship as the core of happiness also assumes access to good relationships that many people genuinely lack. Critics also note that Epicurus\'s Garden was exclusive — a private community of the like-minded — rather than a model for organizing broader society.',
    dailyContent: [
      DailyPhilosophyContent(
        quote:
            'Not what we have, but what we enjoy, constitutes our abundance.',
        quoteAuthor: 'Epicurus',
        reflectionQuestion:
            'What do you already have that you are not truly enjoying?',
        actionChallenge:
            'Choose one simple pleasure available to you today — a meal, a walk, a conversation — and give it your complete attention.',
      ),
      DailyPhilosophyContent(
        quote:
            'Of all the things that wisdom provides for a blessed life, by far the greatest is the possession of friendship.',
        quoteAuthor: 'Epicurus',
        reflectionQuestion:
            'Which friendship in your life have you been neglecting?',
        actionChallenge:
            'Reach out to one person you have been meaning to reconnect with. Not a group message — a genuine, personal one.',
      ),
      DailyPhilosophyContent(
        quote: 'Do not spoil what you have by desiring what you do not have.',
        quoteAuthor: 'Epicurus',
        reflectionQuestion:
            'What unnecessary desire is currently generating the most dissatisfaction in your life?',
        actionChallenge:
            'Identify one desire you could let go of today. Write why you genuinely do not need it.',
      ),
      DailyPhilosophyContent(
        quote: 'The greatest wealth is to live content with little.',
        quoteAuthor: 'Plato',
        reflectionQuestion:
            'What is the minimum you would need to feel genuinely satisfied? Do you already have it?',
        actionChallenge:
            'Write a list of everything you genuinely need to be content — not want, need. Most people find the list is shorter than expected.',
      ),
      DailyPhilosophyContent(
        quote:
            'Death is nothing to us, since when we exist, death is not yet present, and when death is present, then we do not exist.',
        quoteAuthor: 'Epicurus',
        reflectionQuestion:
            'How much of your current anxiety is about a future that may never arrive, or an ending you will not be present to experience?',
        actionChallenge:
            'Write one fear about the future. Then write an Epicurean response: does this fear serve any useful purpose in your actual present life?',
      ),
      DailyPhilosophyContent(
        quote:
            'It is not the man who has little who is poor, but the man who craves more.',
        quoteAuthor: 'Seneca',
        reflectionQuestion:
            'What craving is currently making you feel poorer than you are?',
        actionChallenge:
            'Practice one act of deliberate sufficiency today. When the craving arises, name it and let it pass without acting on it.',
      ),
      DailyPhilosophyContent(
        quote:
            'I have learned to seek my happiness by limiting my desires rather than in attempting to satisfy them.',
        quoteAuthor: 'John Stuart Mill',
        reflectionQuestion:
            'Which of your current pursuits are making you genuinely happier, and which are simply keeping you busy?',
        actionChallenge:
            'Cancel or simplify one commitment this week that you are doing out of habit or obligation rather than genuine desire.',
      ),
    ],
  ),

  // ── 9. BUDDHISM ──────────────────────────────────────────────────────────────
  PhilosophyModel(
    id: 'buddhism',
    name: 'Buddhism',
    emoji: '🪷',
    gradient: [Color(0xFFFFA726), Color(0xFFF57C00)],
    tagline: 'Suffering comes from clinging. Liberation comes from letting go.',
    overview:
        'Buddhist philosophy, originating with Siddhartha Gautama in the 5th–4th century BCE, is fundamentally a diagnosis and cure for dukkha — suffering, unsatisfactoriness, the pervasive sense that something is wrong. The Four Noble Truths: suffering exists; it arises from craving and clinging; it can cease; the Eightfold Path is the way to cessation. Key teachings include impermanence (anicca) — all phenomena arise and pass away; no fixed self (anatta) — what we call "I" is a flowing process, not a static entity; and interdependence (pratītyasamutpāda) — nothing exists independently of everything else.',
    coreBeliefs: [
      'The Four Noble Truths: life involves suffering; suffering arises from craving; craving can be released; the Eightfold Path leads to release.',
      'Impermanence (anicca): all things — emotions, relationships, the self — are in constant flux. Resistance to this causes suffering.',
      'No fixed self (anatta): the "I" is a process, not a thing. What you identify as "you" is a constantly changing stream of experiences.',
      'Interdependence: all phenomena arise in dependence on conditions. Nothing is self-caused or exists in isolation.',
      'The Eightfold Path: right view, intention, speech, action, livelihood, effort, mindfulness, and concentration.',
    ],
    keyThinkers: [
      'Siddhartha Gautama',
      'Nagarjuna',
      'Thich Nhat Hanh',
      'Pema Chödrön',
      'Shunryu Suzuki'
    ],
    practicalApplication:
        'Buddhist practice offers highly specific tools for working with suffering. When you notice distress, the inquiry is: "What am I clinging to here?" — a desire for things to be different, an identity to be preserved, an outcome to be guaranteed. The practice of observing thoughts without identifying with them (mindfulness) is not about achieving a blank mind but about creating a gap between stimulus and reaction where choice can live. Buddhism is also unusual in its direct engagement with impermanence as a comfort rather than a threat: nothing is permanent, including this pain, this anxiety, this shame.',
    criticisms:
        'Buddhist philosophy is criticized for potentially encouraging passivity toward social injustice — if suffering is caused by internal craving, structural change may seem unnecessary. The concept of no-self is philosophically challenging and can be misused to dissolve the sense of agency needed to act. Some versions of Buddhism have been used to justify hierarchical social structures. Western adoptions of Buddhist mindfulness, stripped of ethical and community context, risk becoming a tool for individual productivity rather than genuine liberation.',
    dailyContent: [
      DailyPhilosophyContent(
        quote: 'Pain is inevitable. Suffering is optional.',
        quoteAuthor: 'Buddhist teaching',
        reflectionQuestion:
            'What current pain are you amplifying through resistance, story, or clinging?',
        actionChallenge:
            'The next time something painful arises today, try to observe it without the story. What is the raw experience, separate from your interpretation?',
      ),
      DailyPhilosophyContent(
        quote: 'You can\'t stop the waves, but you can learn to surf.',
        quoteAuthor: 'Jon Kabat-Zinn',
        reflectionQuestion:
            'What emotional wave are you currently trying to stop rather than move with?',
        actionChallenge:
            'Sit quietly for 5 minutes. When a thought or feeling arises, name it ("anxiety," "impatience," "wanting") and let it pass without following it.',
      ),
      DailyPhilosophyContent(
        quote: 'Peace comes from within. Do not seek it without.',
        quoteAuthor: 'Gautama Buddha',
        reflectionQuestion:
            'What external circumstance are you waiting to change before you allow yourself to feel okay?',
        actionChallenge:
            'For one hour today, act as if the peace you are seeking is already available to you. See what changes.',
      ),
      DailyPhilosophyContent(
        quote:
            'In the end, only three things matter: how much you loved, how gently you lived, and how gracefully you let go of things not meant for you.',
        quoteAuthor: 'Buddhist teaching',
        reflectionQuestion:
            'What are you holding onto that is no longer meant for you?',
        actionChallenge:
            'Write about something you know you need to release. Then write what it would feel like to genuinely let it go.',
      ),
      DailyPhilosophyContent(
        quote: 'The mind is everything. What you think, you become.',
        quoteAuthor: 'Gautama Buddha',
        reflectionQuestion:
            'What habitual thought pattern is most shaping the texture of your daily experience?',
        actionChallenge:
            'Notice every time a particular negative thought pattern arises today. Count it. Awareness is the first step to freedom.',
      ),
      DailyPhilosophyContent(
        quote: 'If you truly loved yourself, you could never hurt another.',
        quoteAuthor: 'Gautama Buddha',
        reflectionQuestion:
            'Is there someone you have hurt recently because you were acting from self-protection rather than self-love?',
        actionChallenge:
            'Extend genuine compassion to one person today — including yourself. A simple kind word, a moment of patience, an honest apology.',
      ),
      DailyPhilosophyContent(
        quote:
            'What we think, we become. All that we are arises with our thoughts.',
        quoteAuthor: 'Gautama Buddha',
        reflectionQuestion:
            'If your thoughts today were the seeds of your future experience, what would you be planting?',
        actionChallenge:
            'When a harsh or catastrophic thought arises today, consciously replace it with a more accurate, compassionate alternative.',
      ),
    ],
  ),

  // ── 10. VIRTUE ETHICS ────────────────────────────────────────────────────────
  PhilosophyModel(
    id: 'virtue_ethics',
    name: 'Virtue Ethics',
    emoji: '🏛️',
    gradient: [Color(0xFFFFB74D), Color(0xFFE65100)],
    tagline: 'Be the kind of person for whom good actions come naturally.',
    overview:
        'Virtue ethics, originating with Aristotle in the 4th century BCE, shifts moral philosophy\'s focus from rules (what should I do?) or consequences (what will produce the best outcome?) to character (what kind of person should I be?). Aristotle held that the goal of human life is eudaimonia — often translated as "flourishing" or "the good life," but richer than "happiness." Eudaimonia is achieved by cultivating virtues — excellences of character such as courage, justice, practical wisdom, generosity, and temperance — through practice, habituation, and community.',
    coreBeliefs: [
      'The goal of ethics is not rule-following or consequence-calculation but the development of excellent character.',
      'Virtues are stable dispositions cultivated through practice — like a skill, not a one-time decision.',
      'Eudaimonia (flourishing) is the proper aim of a human life. It is active, excellent engagement with the world, not a feeling.',
      'The doctrine of the mean: each virtue lies between two vices of excess and deficiency (courage is between cowardice and recklessness).',
      'Practical wisdom (phronesis) is the master virtue — the ability to discern the right action in a specific situation.',
    ],
    keyThinkers: [
      'Aristotle',
      'Thomas Aquinas',
      'Confucius',
      'Alasdair MacIntyre',
      'Martha Nussbaum'
    ],
    practicalApplication:
        'The central virtue-ethics question is not "what is the right rule?" but "what would a person of excellent character do?" This is more useful than it sounds: rather than agonizing over abstract principles, you ask "what would a courageous, wise, and just version of me do here?" and then act from that. It also reframes ethics as identity formation over time rather than a series of discrete decisions. Character is built by accumulation: every small choice either reinforces or erodes a disposition. The question is not just "should I do this?" but "what kind of person am I becoming by doing this repeatedly?"',
    criticisms:
        'Virtue ethics is criticized for being culturally relative — different societies have called different traits virtues, including domination and aggression. It can be paternalistic: telling people how to be rather than leaving them free to determine their own values. It provides limited guidance in specific ethical dilemmas where competing virtues conflict. Critics also note it can be elitist, assuming that virtue is available to everyone equally regardless of social conditions — when in fact poverty, trauma, and systemic oppression significantly constrain character formation.',
    dailyContent: [
      DailyPhilosophyContent(
        quote:
            'We are what we repeatedly do. Excellence, then, is not an act but a habit.',
        quoteAuthor: 'Aristotle',
        reflectionQuestion:
            'What habit — practiced daily — would most improve who you are becoming?',
        actionChallenge:
            'Begin the habit today. Not a life overhaul. One small, specific practice done once, with the intention to repeat.',
      ),
      DailyPhilosophyContent(
        quote:
            'The purpose of life is not to be happy. It is to be useful, to be honorable, to be compassionate, to have it make some difference that you have lived.',
        quoteAuthor: 'Ralph Waldo Emerson',
        reflectionQuestion:
            'Are you pursuing happiness or flourishing? What is the difference for you?',
        actionChallenge:
            'Do one thing today that contributes to your character or others\' wellbeing, independent of whether it makes you feel good.',
      ),
      DailyPhilosophyContent(
        quote: 'Knowing what is right and not doing it is the worst cowardice.',
        quoteAuthor: 'Confucius',
        reflectionQuestion:
            'What do you know is right but have been avoiding because it is difficult or uncomfortable?',
        actionChallenge:
            'Take the difficult right action you have been postponing. Small version is acceptable. The point is not to avoid.',
      ),
      DailyPhilosophyContent(
        quote: 'In the middle of difficulty lies opportunity.',
        quoteAuthor: 'Albert Einstein',
        reflectionQuestion:
            'What virtue could your current difficulty be developing in you?',
        actionChallenge:
            'Name the virtue this challenge is asking of you (patience, courage, honesty). Practice it deliberately today.',
      ),
      DailyPhilosophyContent(
        quote:
            'It is the mark of an educated mind to be able to entertain a thought without accepting it.',
        quoteAuthor: 'Aristotle',
        reflectionQuestion:
            'When did you last genuinely consider a position you disagree with, rather than simply dismissing it?',
        actionChallenge:
            'Read or listen to one argument you strongly disagree with. Try to find the most reasonable version of it.',
      ),
      DailyPhilosophyContent(
        quote:
            'Courage is the first of human virtues because it makes all others possible.',
        quoteAuthor: 'Aristotle',
        reflectionQuestion:
            'What act of courage would unlock the most positive change in your life right now?',
        actionChallenge:
            'Take one courageous action today — one that involves genuine risk of discomfort or rejection.',
      ),
      DailyPhilosophyContent(
        quote: 'The one who tells the stories rules the world.',
        quoteAuthor: 'Hopi saying',
        reflectionQuestion:
            'What story are you telling yourself about your current situation that is making you smaller?',
        actionChallenge:
            'Rewrite the story of a recent event from the perspective of someone who has excellent character and is genuinely learning.',
      ),
    ],
  ),

  // ── 11. RATIONALISM ──────────────────────────────────────────────────────────
  PhilosophyModel(
    id: 'rationalism',
    name: 'Rationalism',
    emoji: '🔭',
    gradient: [Color(0xFF7E57C2), Color(0xFF311B92)],
    tagline: 'Reason alone illuminates truth. Question everything.',
    overview:
        'Rationalism holds that reason — not sense experience alone — is the primary source of genuine knowledge. Descartes famously began by doubting everything that could possibly be doubted, arriving at cogito ergo sum: "I think, therefore I am" — the one indubitable truth from which to reconstruct knowledge. Rationalists believe reality has a logical, mathematical structure that reason can discover a priori (before or independent of specific experience). Spinoza\'s Ethics, written in geometrical form, is the purest expression: all of reality deducible from first principles as theorems follow from axioms.',
    coreBeliefs: [
      'Reason, not sensory experience, is the most reliable source of genuine knowledge.',
      'Some truths are a priori — knowable by reason alone, independent of any particular experience.',
      'Reality has a logical, rational structure. The universe is in principle comprehensible to reason.',
      'The method of systematic doubt — questioning everything until you reach indubitable foundations — is the path to certain knowledge.',
      'Mathematics is the model of genuine knowledge: universal, necessary, and provable.',
    ],
    keyThinkers: [
      'René Descartes',
      'Baruch Spinoza',
      'Gottfried Leibniz',
      'Immanuel Kant'
    ],
    practicalApplication:
        'Rationalism is most practically useful as an epistemic discipline: a commitment to examining your beliefs systematically rather than inheriting them from emotion, authority, or tradition. The Cartesian practice of methodical doubt is genuinely valuable: take a belief you hold strongly and ask what would count as evidence against it. If you cannot answer that question, you are not reasoning — you are rationalizing. Rationalism also encourages intellectual humility: if reason can in principle reach truth, then genuine argument should be able to change your mind, and you should be open to that.',
    criticisms:
        'Rationalism\'s insistence on a priori knowledge has been challenged by empiricism: Hume argued that all genuine knowledge comes from experience, and that reason alone cannot tell us facts about the world. The history of "purely rational" systems — from Descartes to 20th-century utopias — suggests that reason unchecked by empirical feedback produces elegant but false systems. Rationalism also underestimates emotion\'s role in cognition: modern neuroscience suggests that reason and emotion are not opposed but interdependent. The ideal of the purely rational agent is also psychologically unlivable.',
    dailyContent: [
      DailyPhilosophyContent(
        quote: 'I think, therefore I am.',
        quoteAuthor: 'René Descartes',
        reflectionQuestion:
            'What is the most fundamental thing you are certain of about yourself and your experience?',
        actionChallenge:
            'Identify one belief you have never questioned. Spend 10 minutes genuinely trying to find reasons it might be wrong.',
      ),
      DailyPhilosophyContent(
        quote:
            'Everything should be made as simple as possible, but not simpler.',
        quoteAuthor: 'Albert Einstein',
        reflectionQuestion:
            'Where are you over-complicating something that could be understood more clearly?',
        actionChallenge:
            'Explain a complex problem in your life in three sentences. Then find the simplest possible first action.',
      ),
      DailyPhilosophyContent(
        quote:
            'He who is not contented with what he has, would not be contented with what he would like to have.',
        quoteAuthor: 'Socrates',
        reflectionQuestion:
            'What rational evidence do you have that getting what you want would actually make you happy?',
        actionChallenge:
            'Examine one desire. Write what evidence actually supports that achieving it would produce lasting satisfaction.',
      ),
      DailyPhilosophyContent(
        quote:
            'The highest activity a human being can attain is learning for understanding, because to understand is to be free.',
        quoteAuthor: 'Baruch Spinoza',
        reflectionQuestion:
            'What do you genuinely want to understand better, not for any practical purpose, but because it matters to you?',
        actionChallenge:
            'Spend 30 minutes learning something purely for understanding today — no productivity goal attached.',
      ),
      DailyPhilosophyContent(
        quote: 'Dare to know. Have courage to use your own understanding.',
        quoteAuthor: 'Immanuel Kant',
        reflectionQuestion:
            'Where are you outsourcing your thinking to an authority — social media, tradition, an expert — when you could reason it through yourself?',
        actionChallenge:
            'Form your own opinion on something you have been letting others decide for you. Write your reasoning explicitly.',
      ),
      DailyPhilosophyContent(
        quote:
            'The more we know, the more we discover how much we do not know.',
        quoteAuthor: 'René Descartes',
        reflectionQuestion:
            'What is something you were certain about that turned out to be wrong? What did it teach you?',
        actionChallenge:
            'Seek out information today that challenges a belief you currently hold with high confidence.',
      ),
      DailyPhilosophyContent(
        quote:
            'Two things fill me with ever-increasing wonder: the starry sky above me and the moral law within me.',
        quoteAuthor: 'Immanuel Kant',
        reflectionQuestion:
            'What universal principle guides your ethical decisions, regardless of consequences?',
        actionChallenge:
            'Write down your deepest ethical principle in one sentence. Then describe one situation where you fully honoured it and one where you didn\'t.',
      ),
    ],
  ),

  // ── 12. CYNICISM ─────────────────────────────────────────────────────────────
  PhilosophyModel(
    id: 'cynicism',
    name: 'Cynicism',
    emoji: '🐕',
    gradient: [Color(0xFF66BB6A), Color(0xFF2E7D32)],
    tagline: 'Social conventions are a prison. Virtue needs nothing else.',
    overview:
        'The ancient Cynics — founded by Antisthenes and made famous by Diogenes of Sinope — held that virtue is the only good and that conventional society\'s values (wealth, status, power, pleasure) are not merely unimportant but actively corrupting. The Cynic ideal was autarkeia — complete self-sufficiency — and parrhesia — radical, shameless honesty. Diogenes lived in a barrel, begged for food, and met Alexander the Great with the request "stop blocking my sun." The Cynics were the original counter-culture, and their influence runs from early Christianity through Stoicism to contemporary anti-consumerism.',
    coreBeliefs: [
      'Virtue alone is sufficient for happiness. Everything else — money, status, comfort, social approval — is worthless by comparison.',
      'Conventional society\'s values corrupt rather than support the good life.',
      'Self-sufficiency (autarkeia): minimize dependence on external things and other people\'s approval.',
      'Parrhesia (radical honesty): say what you genuinely think, regardless of social consequences.',
      'Shamelessness (anaideia): refuse to be controlled by social embarrassment or the performance of respectability.',
    ],
    keyThinkers: [
      'Diogenes of Sinope',
      'Antisthenes',
      'Crates of Thebes',
      'Hipparchia'
    ],
    practicalApplication:
        'Cynicism\'s most useful practice is ruthless examination of which of your desires and anxieties are genuinely yours and which are socially manufactured. Most of what people suffer over — social status, appearance, others\' opinions, keeping up appearances — is, in Cynic terms, purely conventional: agreed-upon fictions we have mistaken for necessities. The diagnostic question is: "Would I care about this if I lived alone on an island?" If not, it deserves far less power over you than you are currently granting it. Cynicism is also a powerful antidote to hypocrisy — the Cynic holds themselves to the same standard they apply to others.',
    criticisms:
        'Ancient Cynicism was deliberately antisocial and is difficult to apply in community life. Its celebration of radical poverty, shamelessness, and rejection of social norms can be used to justify neglect of real responsibilities. The Cynic contempt for conventional goods can become self-righteous — a performance of virtue that judges others from a position of manufactured superiority. Modern "cynicism" — as pessimistic worldly-wisdom — is nearly opposite to the ancient version, and the ancient version\'s asocial extremism is not a practical model for contemporary life.',
    dailyContent: [
      DailyPhilosophyContent(
        quote: 'He has the most who is content with the least.',
        quoteAuthor: 'Diogenes of Sinope',
        reflectionQuestion:
            'What have you been telling yourself you need that you almost certainly do not?',
        actionChallenge:
            'Give up one comfort, convenience, or luxury today voluntarily. Notice what this reveals about your actual needs.',
      ),
      DailyPhilosophyContent(
        quote: 'I am a citizen of the world.',
        quoteAuthor: 'Diogenes of Sinope',
        reflectionQuestion:
            'Which of your group identities — nationality, class, culture — are limiting your thinking or compassion?',
        actionChallenge:
            'Challenge one tribal or in-group judgment today. Extend genuine consideration to someone your group typically dismisses.',
      ),
      DailyPhilosophyContent(
        quote:
            'It is not that I am mad, it is only that my head is different from yours.',
        quoteAuthor: 'Diogenes of Sinope',
        reflectionQuestion:
            'What genuine belief or value do you hide from others because it would be considered strange or wrong?',
        actionChallenge:
            'Express one genuine, unconventional opinion today — to yourself in a journal if not aloud.',
      ),
      DailyPhilosophyContent(
        quote: 'The sun, too, shines into cesspools and is not polluted.',
        quoteAuthor: 'Diogenes of Sinope',
        reflectionQuestion:
            'Where are you withholding your genuine goodness because the situation seems unworthy of it?',
        actionChallenge:
            'Do something kind or honest in a context where it is unexpected or "not worth it." Notice what happens.',
      ),
      DailyPhilosophyContent(
        quote: 'The great thieves lead away the little thief.',
        quoteAuthor: 'Diogenes of Sinope',
        reflectionQuestion:
            'Where do you hold others to standards you do not apply to yourself?',
        actionChallenge:
            'Identify one hypocrisy — however uncomfortable — between how you judge others and how you behave yourself. Write it honestly.',
      ),
      DailyPhilosophyContent(
        quote:
            'We have two ears and one tongue so that we would listen more and talk less.',
        quoteAuthor: 'Diogenes of Sinope',
        reflectionQuestion:
            'In your most recent significant conversation, were you listening or were you waiting to speak?',
        actionChallenge:
            'In your next conversation, commit to asking two questions before sharing your own view.',
      ),
      DailyPhilosophyContent(
        quote:
            'He who is most contented with the least is nearest to the gods.',
        quoteAuthor: 'Antisthenes',
        reflectionQuestion:
            'What would become possible in your life if you genuinely needed less approval from others?',
        actionChallenge:
            'Take one action today that is right but that you know others will disapprove of or misunderstand.',
      ),
    ],
  ),
];
