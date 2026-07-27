import '../models/comparison_model.dart';

const List<ComparisonSituation> kComparisonSituations = [
  // ── BREAKUP ──────────────────────────────────────────────────────────────────
  ComparisonSituation(
    id: 'breakup',
    title: 'Going through a breakup',
    icon: '💔',
    prompt:
        'A relationship has ended and you\'re struggling with grief, anger, or loss.',
    perspectives: [
      PhilosophyPerspective(
        philosophyId: 'stoicism',
        philosophyName: 'Stoicism',
        emoji: '⚖️',
        keyInsight:
            'You cannot control what happened. You can control who you become next.',
        perspective:
            'The relationship existed; its value was real. Stoicism does not ask you to pretend otherwise. What it does ask is that you distinguish the grief — which is natural and temporary — from the judgment that your life is now ruined or incomplete. The Stoics would observe that your attachment to the outcome was always the source of the pain, not the person themselves. Marcus Aurelius: "Loss is nothing but change, and change is Nature\'s delight." Your task now is not to suppress grief but to stop constructing the story that makes it permanent.\n\nThis also the moment to examine your own character. What did you learn about yourself in this relationship — about your needs, your patterns, your areas for growth? A Stoic uses every experience, including painful ones, as training material for virtue.',
        actionStep:
            'Write three things this relationship revealed about what you genuinely value. Then write one specific way you will embody those values going forward.',
      ),
      PhilosophyPerspective(
        philosophyId: 'existentialism',
        philosophyName: 'Existentialism',
        emoji: '🌌',
        keyInsight:
            'You are not defined by what you lost. You are defined by what you choose next.',
        perspective:
            'Sartre would say: you are at a hinge point. The relationship was one project you were engaged in, one way of defining yourself. It is over. Now you face the full weight of your own freedom — and that is terrifying. The temptation is bad faith: "I cannot function without them," "I will never feel this again," "I had no choice but to act as I did." These are all ways of denying your agency and your capacity for self-creation.\n\nExistentialism does not minimize the loss. It says: you are more than this loss. You were never, at any point, defined entirely by this relationship. Your essence was never determined by their presence. Who will you choose to be now — not as a response to them, but as a genuine, self-authored act?',
        actionStep:
            'Write about one way you made yourself smaller in this relationship. Then write who you want to be — specifically, concretely — in the next chapter.',
      ),
      PhilosophyPerspective(
        philosophyId: 'buddhism',
        philosophyName: 'Buddhism',
        emoji: '🪷',
        keyInsight: 'All things are impermanent. Even this pain will change.',
        perspective:
            'Buddhism offers perhaps the most direct tool for grief: the practice of observing suffering without identifying with it. "I am heartbroken" conflates the experience of heartbreak with a fixed self who is broken. The Buddhist view is that heartbreak is arising in your experience — it is not who you are. This does not diminish it. It makes it bearable.\n\nThe suffering is also coming, in part, from clinging: to the person, to the relationship, to the version of your future you had imagined. The Buddhist practice is not to force yourself to stop caring, but to gently, repeatedly, acknowledge impermanence. This ending was always in the nature of things. Your suffering comes from the resistance to that fact, not from the fact itself.',
        actionStep:
            'Sit for 5 minutes and simply observe the feelings as sensations, without following the story. When thoughts about the past or future arise, name them ("planning," "grieving") and return to the present feeling.',
      ),
      PhilosophyPerspective(
        philosophyId: 'absurdism',
        philosophyName: 'Absurdism',
        emoji: '🎭',
        keyInsight:
            'There may be no cosmic reason for this. Revolt by living fully anyway.',
        perspective:
            'Camus would not offer you comfort in the traditional sense. He would say: this loss may have no larger meaning or purpose. The universe did not engineer it for your growth. It simply happened, as things simply happen. The Absurd response is revolt — not against the person or the ending, but against the meaninglessness. You refuse to be defined by it. You refuse to reduce your life to this loss. You live with full intensity despite it.\n\nCamus\'s Sisyphus, condemned forever to his boulder, is not defeated. He is present. He chooses to be fully engaged with his actual life rather than waiting for a redemption that will not come. This is your invitation: not to "get over it" or find hidden meaning, but to choose full presence to your own life, starting now.',
        actionStep:
            'Do one thing today that is purely about living your own life — not processing the loss, not waiting to feel better. Just an act of genuine presence.',
      ),
      PhilosophyPerspective(
        philosophyId: 'taoism',
        philosophyName: 'Taoism',
        emoji: '☯️',
        keyInsight:
            'The river changes course. This is not catastrophe — it is nature.',
        perspective:
            'The Tao teaches that all things arise and pass away in their own time, in their own way. Resistance to this flow — insisting things should be different — is the source of suffering, not the ending itself. Water does not mourn that it is no longer ice. It moves into its new form.\n\nThe Taoist practice is not to force yourself through the grief or to analyze it into submission, but to allow it to move through you at its own pace. Wu wei here means neither clinging to the relationship nor forcing yourself to be "over it." It means creating space for the natural process to unfold, trusting that you will find your new form.',
        actionStep:
            'Go for a slow, directionless walk today. No destination, no phone. Allow the walk to model what it means to move without forcing.',
      ),
      PhilosophyPerspective(
        philosophyId: 'humanism',
        philosophyName: 'Humanism',
        emoji: '🌍',
        keyInsight:
            'Your capacity for love is still intact. That is not something you lose.',
        perspective:
            'Humanism would focus on what this experience reveals about your capacity for connection, care, and vulnerability — all of which are genuinely good things, even though they caused you pain. The fact that you loved is not a mistake. It is an expression of your full humanity. The capacity for heartbreak is the same capacity as the capacity for deep connection.\n\nHumanism would also ask: what does this experience teach you about what you want and need in your relationships going forward? Not to immediately start looking for a replacement, but to better understand yourself so that future relationships are more aligned with your actual values and needs.',
        actionStep:
            'Write about one thing this relationship confirmed about who you genuinely are and what matters to you. Not what went wrong — what was right about who you were at your best.',
      ),
      PhilosophyPerspective(
        philosophyId: 'pragmatism',
        philosophyName: 'Pragmatism',
        emoji: '⚙️',
        keyInsight: 'What is working in your life right now? Start there.',
        perspective:
            'The pragmatist approach is less philosophical and more functional: grief is real, it has its own timeline, and the most useful question is "what do I need right now to function and eventually to flourish?" Pragmatism is not cold — William James himself suffered severe depression — but it is practical. What structures, habits, and people help you right now? Which thoughts, behaviors, and environments are making things worse?\n\nPragmatism also invites honest assessment: this relationship ended. Something was not working. What was it? Not to assign blame, but to understand — because understanding produces better future decisions.',
        actionStep:
            'Write three specific things that would help you feel even marginally better today (sleep, seeing a friend, exercise, creative work). Do at least one.',
      ),
      PhilosophyPerspective(
        philosophyId: 'epicureanism',
        philosophyName: 'Epicureanism',
        emoji: '🌿',
        keyInsight:
            'Tranquility is available. Seek simple pleasures and deep friendship.',
        perspective:
            'Epicurus would say that intense romantic attachment is one of the most turbulent of all desires — its fulfillment brings transient pleasure, but the craving and fear of loss create chronic disturbance. This is not a criticism of love, but a reminder that lasting happiness was never going to come from another person alone.\n\nEpicurean medicine for heartbreak: return to the sources of simple, reliable pleasure. Good food. Walks in nature. Time with friends who genuinely care about you. Philosophical conversation. These are the foundations of the good life, and they are all available to you now, without the person you lost.',
        actionStep:
            'Spend time with someone who genuinely cares about you today. Not to talk about the breakup necessarily — just to be with someone who chooses to be with you.',
      ),
      PhilosophyPerspective(
        philosophyId: 'virtue_ethics',
        philosophyName: 'Virtue Ethics',
        emoji: '🏛️',
        keyInsight:
            'How you handle this defines character. Be the person you admire.',
        perspective:
            'Virtue ethics asks: regardless of what happened, regardless of who "did what," how do you want to conduct yourself through this? What does a person of courage, justice, practical wisdom, and generosity do in the aftermath of a painful ending? How do you treat the other person? How do you treat yourself?\n\nThis is character-building material. Every ending is an opportunity to discover what you are made of — not in a performative way, but in the quiet, daily choices: whether you speak well or badly of the other person, whether you give yourself proper care, whether you allow yourself to grieve honestly rather than putting on a performance of recovery.',
        actionStep:
            'Write about how you want to be remembered by this person — not how you want to be seen, but how you want to genuinely be. Then act accordingly, starting today.',
      ),
      PhilosophyPerspective(
        philosophyId: 'nihilism',
        philosophyName: 'Nihilism',
        emoji: '🖤',
        keyInsight:
            'Nothing has ultimate meaning. That means you get to decide what this means.',
        perspective:
            'Nietzsche would resist both excessive grief and forced positivity. Neither "this is the end of everything" nor "everything happens for a reason" are honest. The relationship happened; it ended; there is no cosmic significance to either. What there is, is your life — which continues, which is yours to shape.\n\nThe Nietzschean invitation is to use this as a clearing. Strip away the false values — "I need a relationship to be whole," "I failed at love" — and examine what you genuinely want your life to be. Not as a response to this loss, but as a conscious, self-created act. What Nietzsche called the will to power is simply the drive to become more fully yourself. This is your moment for it.',
        actionStep:
            'Write: "This ending means exactly what I choose it to mean." Then write the most empowering, honest meaning you can construct from it.',
      ),
      PhilosophyPerspective(
        philosophyId: 'rationalism',
        philosophyName: 'Rationalism',
        emoji: '🔭',
        keyInsight:
            'Examine your beliefs about love. Not all of them are true.',
        perspective:
            'The rationalist approach to heartbreak is epistemic: many of the beliefs generating your suffering are unexamined and false. "I will never feel this way again" is not a fact — it is a prediction made by a mind in acute pain. "I am unlovable" is not a conclusion that can be reasoned to from this evidence. "This was my only chance" is a belief, not a truth.\n\nDescartes\' method of systematic doubt is useful here: take each catastrophic thought and subject it to genuine examination. What would count as evidence against this belief? What do you actually know versus what are you inferring? Grief is real, but many of the thoughts that amplify it are not reliable reports on reality.',
        actionStep:
            'Write your three most painful thoughts about the breakup. For each, write: (1) what evidence actually supports it and (2) what evidence contradicts it.',
      ),
      PhilosophyPerspective(
        philosophyId: 'cynicism',
        philosophyName: 'Cynicism',
        emoji: '🐕',
        keyInsight:
            'Most of what society says love should be is constructed. Strip it away.',
        perspective:
            'Diogenes would have little patience for the romantic mythology that has turned heartbreak into catastrophe. Much of the suffering in breakups comes not from the actual loss of the person but from the loss of a socially constructed narrative: the one, the soulmate, the completion of self through other. These are conventions, not truths.\n\nThe Cynic practice here is to distinguish what you actually had — specific moments of connection, care, and reality — from the overlay of expectation, narrative, and social script. The real loss is real. The projected loss — of a fantasy future, of a status ("relationship"), of a self-image — is manufactured, and considerably more of your pain may be coming from that source than you realize.',
        actionStep:
            'Write about what was genuinely real and valuable in this relationship, stripped of all narrative. Then write separately what you are mourning that was more about expectation than reality.',
      ),
    ],
  ),

  // ── ANXIETY ──────────────────────────────────────────────────────────────────
  ComparisonSituation(
    id: 'anxiety',
    title: 'Feeling anxious about the future',
    icon: '😰',
    prompt:
        'Worry and fear about what might happen are taking over your present.',
    perspectives: [
      PhilosophyPerspective(
        philosophyId: 'stoicism',
        philosophyName: 'Stoicism',
        emoji: '⚖️',
        keyInsight:
            'Anxiety is mostly about things outside your control. Redirect to what is inside it.',
        perspective:
            'Seneca wrote: "We suffer more often in imagination than in reality." Most anxiety is about projected futures — outcomes that may never arrive, controlled by forces that are not in your hands. The Stoic prescription is precise: make a list of your anxieties and next to each, mark "in my control" or "not in my control." Ruthlessly redirect your mental energy to the first column only.\n\nThis is not toxic positivity. It is focus. You cannot eliminate your future. You can do excellent work in the present, prepare wisely, act virtuously — and then release the outcome. The Stoics did not promise that virtue would be rewarded. They promised that it would be enough, regardless of how things turned out.',
        actionStep:
            'List your top three current worries. For each: write what specific action — within your control — you can take today. Then release the rest.',
      ),
      PhilosophyPerspective(
        philosophyId: 'buddhism',
        philosophyName: 'Buddhism',
        emoji: '🪷',
        keyInsight: 'The anxious mind lives in the future. Come back to now.',
        perspective:
            'Buddhist psychology is very precise about anxiety: it is the mind living in an imagined future rather than the actual present. The antidote is not to think your way out of anxiety — more thinking about the feared future only intensifies it — but to return, again and again, to the only moment that actually exists: now.\n\nMindfulness practice is not relaxation. It is training the attention. Each time you notice you have gone to the feared future, you simply return to your breath, your body, the actual sensations of this moment. Over time, this builds the capacity to notice the anxious thought without being captured by it.',
        actionStep:
            'Set a timer for 5 minutes. Focus entirely on physical sensations — what you feel in your body right now, what you hear, what you see. When the mind goes to the future, notice and return.',
      ),
      PhilosophyPerspective(
        philosophyId: 'taoism',
        philosophyName: 'Taoism',
        emoji: '☯️',
        keyInsight:
            'The future is water — it cannot be held. Flow rather than grip.',
        perspective:
            'Taoism observes that anxiety is what happens when we try to force the future into a shape we can control. Water does not worry about what shape it will take in the next vessel — it simply flows into it when it arrives. The Taoist practice is to cultivate genuine trust in the process of life, not as a spiritual bypass but as a result of observing that most of what you have feared has never arrived in the form you feared it.\n\nWu wei here means acting wisely and appropriately in the present, and then releasing the grip on outcomes. You do your part; nature does its part. Your anxiety does not improve the outcome — it only disturbs your present.',
        actionStep:
            'Write down what you are trying to control that you genuinely cannot. Then write what action is actually available to you today. Do that, and let the rest go.',
      ),
      PhilosophyPerspective(
        philosophyId: 'existentialism',
        philosophyName: 'Existentialism',
        emoji: '🌌',
        keyInsight:
            'Anxiety is the cost of freedom. It means something genuinely matters to you.',
        perspective:
            'Kierkegaard called anxiety "the dizziness of freedom." Sartre said it arises from the recognition that we are responsible for ourselves with no cosmic guarantee of how things will turn out. From the existentialist view, your anxiety is not a malfunction — it is the honest response to genuine uncertainty and genuine stakes.\n\nThe question is not how to eliminate anxiety but how to act within it. "Authentic existence" does not mean fearlessness — it means choosing and acting despite anxiety, rather than retreating into denial, distraction, or false certainty. The anxious feeling is the sign that something genuinely matters to you. Honor that by acting on it rather than hiding from it.',
        actionStep:
            'Write: what does this anxiety actually reveal about what genuinely matters to you? Then write one action that honors that value.',
      ),
      PhilosophyPerspective(
        philosophyId: 'epicureanism',
        philosophyName: 'Epicureanism',
        emoji: '🌿',
        keyInsight:
            'Most feared outcomes are either unlikely or survivable. Examine the fear honestly.',
        perspective:
            'Epicurus\'s most powerful tool was distinguishing real from imagined threats. He argued that most of what we fear is either: (a) unlikely to happen, (b) survivable if it does, or (c) involves death — in which case we won\'t be present to experience it. He asked: is this fear serving any useful function, or is it simply disturbing your peace?\n\nEpicurean practice for anxiety: sit down and actually examine the feared scenario. How likely is it, realistically? If it happened, what would you actually do? Would it really be as catastrophic as you are imagining? Most people find, on honest examination, that the fear has been vastly inflated by imagination.',
        actionStep:
            'Write out your worst fear. Then write: (1) how likely it actually is, (2) what you would do if it happened, and (3) whether you have survived comparable difficulties before.',
      ),
      PhilosophyPerspective(
        philosophyId: 'rationalism',
        philosophyName: 'Rationalism',
        emoji: '🔭',
        keyInsight:
            'Examine your catastrophic predictions. Are they actually true?',
        perspective:
            'The rationalist approach to anxiety is epistemic: anxiety almost always involves beliefs that are not well-supported by evidence. "Everything will fall apart" is a prediction. What is your actual evidence for it? What is the evidence against it? "I won\'t be able to handle it" is another belief. What does your history of handling difficulties tell you about this?\n\nDescartes\' method is useful: subject each anxious thought to systematic doubt. If you cannot identify specific evidence for the catastrophic prediction — beyond "it feels true" — then you are experiencing emotion as cognition, not actual reasoning. Reason and emotion are not opposed, but it helps to know which one is driving.',
        actionStep:
            'Write your most anxious thought as a specific prediction: "X will happen." Then write the actual evidence for and against it. Rate your confidence in each.',
      ),
      PhilosophyPerspective(
        philosophyId: 'absurdism',
        philosophyName: 'Absurdism',
        emoji: '🎭',
        keyInsight:
            'The universe has no guarantee for you. Live fully in that freedom.',
        perspective:
            'Camus would say that anxiety is what happens when we expect the universe to provide certainty it has never promised. The Absurd is precisely the gap between your need for guarantee and the silence you receive. The answer is not to find a way to make the universe promise. The answer is revolt: refusing to be diminished by the uncertainty.\n\nAbsurdism offers a strange liberation: if there is no guarantee, there is also no cosmic verdict against you. Nothing is predetermined to go wrong. The future is genuinely open. Your anxiety has been treating uncertainty as threat — but uncertainty is also opportunity, space, freedom.',
        actionStep:
            'Write: "I do not know how this will turn out." Sit with that sentence. Then write what you would do today if the uncertainty were resolved — in your favor.',
      ),
      PhilosophyPerspective(
        philosophyId: 'humanism',
        philosophyName: 'Humanism',
        emoji: '🌍',
        keyInsight: 'Humans are remarkably resilient. Trust your capacity.',
        perspective:
            'Humanism would point to the evidence: human beings have survived far worse than what you are currently anxious about, in far worse conditions, without the resources, knowledge, and support you have. Your brain\'s threat-detection system is excellent at generating anxiety but poor at proportioning it to actual risk.\n\nThe humanist response to anxiety is not to dismiss it but to put it in context: you are a capable, adaptable person in a long tradition of capable, adaptable people. The challenges you are worried about are real — but so is your capacity to meet them. Trusting that capacity is not naivety. It is evidence-based.',
        actionStep:
            'Write three times you have handled something you were anxious about better than you expected. What does this tell you about your capacity?',
      ),
      PhilosophyPerspective(
        philosophyId: 'pragmatism',
        philosophyName: 'Pragmatism',
        emoji: '⚙️',
        keyInsight:
            'Stop worrying. Start planning. Preparation dissolves anxiety.',
        perspective:
            'William James was direct about anxiety: it is often energy that should be action instead. Anxiety about the future is sometimes a signal that you have real work to do — preparation, decision-making, difficult conversations — and you are not doing it. The anxiety becomes a kind of substitute for action: by worrying, you feel as if you are engaged with the problem without the discomfort of actually doing something.\n\nThe pragmatist prescription: convert anxiety into a problem to be solved. What specifically are you afraid of? What preparation would address it? What decision would reduce the uncertainty? Do that work, and see how much of the anxiety was really procrastinated action.',
        actionStep:
            'Write: "The real action I am avoiding is ___." Then take that action — or the first step of it — today.',
      ),
      PhilosophyPerspective(
        philosophyId: 'nihilism',
        philosophyName: 'Nihilism',
        emoji: '🖤',
        keyInsight:
            'In the long run, very little of this will matter. Use that as freedom.',
        perspective:
            'Nietzsche\'s eternal recurrence thought experiment is useful for anxiety: would you want to live this moment — including the anxiety, including the situation — exactly as it is, infinitely repeated? If yes, you are in amor fati (love of fate). If no, change something.\n\nThere is also a Nietzschean comfort in perspective: the stakes that feel absolute often are not. Most of what causes the most intense anxiety — social judgment, professional failure, not measuring up to expectation — is entirely conventional, not cosmic. In a hundred years, almost none of the specific things you are anxious about will matter to anyone. Use that perspective not as nihilistic dismissal but as space for proportion.',
        actionStep:
            'Ask: "Will this matter in ten years?" If yes, act on it seriously. If no, give it proportional (much less) mental energy today.',
      ),
      PhilosophyPerspective(
        philosophyId: 'virtue_ethics',
        philosophyName: 'Virtue Ethics',
        emoji: '🏛️',
        keyInsight:
            'Courage is not the absence of fear. It is acting well despite it.',
        perspective:
            'Aristotle\'s doctrine of the mean places courage between cowardice and recklessness. Courage does not mean not feeling anxious — it means not being ruled by anxiety. The virtuous person feels fear appropriately (when genuine danger is present) and acts despite it when action is called for.\n\nThe virtue-ethics question for anxiety is: what would a genuinely courageous person do in this situation? Not someone who isn\'t afraid — someone who is afraid and acts anyway. Build the virtue through practice: each small act of courage in the face of anxiety makes courage more natural, until the disposition itself shifts.',
        actionStep:
            'Identify one thing anxiety has been preventing you from doing. Do it today — or begin it. The courageous act is the training.',
      ),
      PhilosophyPerspective(
        philosophyId: 'cynicism',
        philosophyName: 'Cynicism',
        emoji: '🐕',
        keyInsight:
            'Most anxiety is about social judgment. Reject its power over you.',
        perspective:
            'Diogenes would observe that most of what people are anxious about is social performance anxiety in disguise: fear of judgment, failure in the eyes of others, loss of status or appearance. These are not genuine threats — they are the machinery of social control.\n\nThe Cynic practice is deliberate shamelessness: do the things you are afraid of doing, publicly, to demonstrate to yourself that the social consequences are not as catastrophic as your anxiety predicts. Not recklessly, but with the genuine experimental spirit of testing whether the feared social judgment is as unbearable as it appears from the outside.',
        actionStep:
            'Identify one source of anxiety that is really about what others will think. Do the thing anyway — once — and observe what actually happens versus what you feared.',
      ),
    ],
  ),

  // ── MOTIVATION ───────────────────────────────────────────────────────────────
  ComparisonSituation(
    id: 'motivation',
    title: 'Can\'t find motivation',
    icon: '😶',
    prompt:
        'You know what you should do but can\'t bring yourself to start or continue.',
    perspectives: [
      PhilosophyPerspective(
        philosophyId: 'stoicism',
        philosophyName: 'Stoicism',
        emoji: '⚖️',
        keyInsight:
            'Stop waiting to feel motivated. Act first. The feeling follows.',
        perspective:
            'The Stoics would have no patience for waiting for motivation to arrive before acting. Marcus Aurelius wrote his Meditations as personal commands to himself precisely because he did not feel like doing the right thing — he understood that right action is a choice, not a mood. "You have power over your mind, not outside events." Motivation is an external event. Action is within your control.\n\nThe Stoic prescription: begin. Not perfectly, not enthusiastically — just begin. The philosophical tradition of virtuous action requires practice, not inspiration. Act as the virtuous person would act, and the character forms around the action.',
        actionStep:
            'Do the task for exactly 10 minutes. Set a timer. You do not need to feel motivated to work for 10 minutes. Start.',
      ),
      PhilosophyPerspective(
        philosophyId: 'existentialism',
        philosophyName: 'Existentialism',
        emoji: '🌌',
        keyInsight:
            'Lack of motivation is often a crisis of meaning. Ask what you actually care about.',
        perspective:
            'Sartre would say that if you cannot find motivation for something, the honest question is: do you actually value this, or have you been doing it because you feel you should? The collapse of motivation is often a signal — not of laziness, but of bad faith. You have been acting as if this task, goal, or life direction is meaningful to you when it actually is not.\n\nExistentialism asks: what do you genuinely care about? Not what you\'re supposed to care about, not what will impress people, not what follows logically from your past choices — what actually matters to you? If your current work is not connected to that, no amount of discipline will make it feel alive.',
        actionStep:
            'Write: "If I had complete freedom, I would spend my time ___." Then write how your current work does or does not connect to that. Be honest.',
      ),
      PhilosophyPerspective(
        philosophyId: 'pragmatism',
        philosophyName: 'Pragmatism',
        emoji: '⚙️',
        keyInsight: 'Motivation follows action, not the other way around.',
        perspective:
            'William James\'s insight into motivation is still one of the most useful in psychology: "Action seems to follow feeling, but really action and feeling go together; and by regulating the action, which is under the more direct control of the will, we can indirectly regulate the feeling." In other words: motivation does not cause action. Action generates motivation.\n\nThe pragmatist prescription is deliberately mechanical: identify the smallest possible first action and take it. Not to feel motivated — to build evidence that you can do this, which generates momentum, which produces the motivation you were waiting for.',
        actionStep:
            'Name the smallest possible version of the first action. So small it would be embarrassing not to do it. Do that.',
      ),
      PhilosophyPerspective(
        philosophyId: 'virtue_ethics',
        philosophyName: 'Virtue Ethics',
        emoji: '🏛️',
        keyInsight:
            'Self-discipline is a virtue built through practice. Each time you act without motivation, you become more capable.',
        perspective:
            'Aristotle was clear that virtue is not a feeling — it is a habit. Motivation is a feeling. Self-discipline is the virtue that allows you to act when motivation is absent. And like all virtues, it is built through practice — not through motivation, not through willpower as a reservoir to draw on, but through repeated small acts that build the disposition.\n\nEvery time you act well without motivation, you are forming character. Every time you wait for motivation before acting, you are forming the habit of waiting. The question is not "how do I feel motivated?" but "what kind of person am I building with each choice?"',
        actionStep:
            'Do the first part of the task today regardless of how you feel. Write afterwards: "I did it without motivation." This is virtue in practice.',
      ),
      PhilosophyPerspective(
        philosophyId: 'nihilism',
        philosophyName: 'Nihilism',
        emoji: '🖤',
        keyInsight:
            'If nothing matters, nothing stops you either. Create your own reason.',
        perspective:
            'Nietzsche diagnosed the collapse of motivation — "what is the point?" — as a form of passive nihilism: the default response when inherited values have collapsed and new ones have not yet been created. The question is not how to restore the old motivation but how to create genuine, self-authored reasons to act.\n\nThe will to power here is not ambition for its own sake but the drive to become more fully yourself. The task is to find — genuinely, not performatively — what you want to create or build or experience. Then motivation is not about discipline but about desire. Nietzsche\'s prescription: become what you are.',
        actionStep:
            'Write what you would do if you were certain no one would ever know about it, judge it, or reward you for it. Do some version of that today.',
      ),
      PhilosophyPerspective(
        philosophyId: 'buddhism',
        philosophyName: 'Buddhism',
        emoji: '🪷',
        keyInsight:
            'Observe the resistance without identifying with it. You are not your inertia.',
        perspective:
            'Buddhist psychology is subtle about motivation: the feeling "I can\'t do this" or "I don\'t want to" is a mental event arising in your experience — it is not who you are. The practice is to observe the resistance without following it. You notice the thought "I don\'t feel like it" and then, without suppressing it or amplifying it, you act anyway. The resistance is not a command. It is weather.\n\nThe Buddhist insight also addresses the perfectionism that often masquerades as lack of motivation: the fear that if you start and produce something imperfect, it will confirm a catastrophic story about yourself. Impermanence applies here too: this draft, this work, this attempt is not permanent and will not define you.',
        actionStep:
            'Notice the resistance without following it. Then observe: what story is attached to the feeling? Write it down, then act anyway for 10 minutes.',
      ),
      PhilosophyPerspective(
        philosophyId: 'taoism',
        philosophyName: 'Taoism',
        emoji: '☯️',
        keyInsight:
            'Wu wei: effortless action comes from alignment, not force.',
        perspective:
            'The Tao Te Ching does not believe in willpower as a solution. If you are forcing yourself to do something that feels completely against your grain, you are not practicing wu wei — you are fighting the Tao. The question is whether the lack of motivation is a temporary state to move through or a signal that you are genuinely misaligned with your own nature.\n\nThe Taoist approach: distinguish between the natural resistance that accompanies beginning anything meaningful, and the deeper signal that this direction is wrong for you. The first requires gentle persistence. The second requires courage to change direction.',
        actionStep:
            'Sit quietly for 5 minutes and ask: "Does this lack of motivation feel like resistance to starting, or does it feel like genuine misalignment with what I want?" The answers require different responses.',
      ),
      PhilosophyPerspective(
        philosophyId: 'humanism',
        philosophyName: 'Humanism',
        emoji: '🌍',
        keyInsight: 'Connect the work to something larger than yourself.',
        perspective:
            'Humanism suggests that motivation is most reliable when connected to something beyond personal benefit or discipline: contribution, impact, meaning for others. The humanist question is: how does this work connect to what is good for others, for your community, for the project of human flourishing? Even a small connection can be powerful.\n\nHumanism also takes seriously the conditions of motivation. Are you rested? Are your basic needs met? Are you isolated? Human beings are social creatures who do their best work in connection with others and with a sense of contribution. External conditions matter.',
        actionStep:
            'Write one specific way the work you\'re avoiding ultimately serves someone other than yourself. Begin with that person in mind.',
      ),
      PhilosophyPerspective(
        philosophyId: 'epicureanism',
        philosophyName: 'Epicureanism',
        emoji: '🌿',
        keyInsight:
            'Have you rested enough? Sustainable output requires restoration.',
        perspective:
            'Epicurus would ask a question many people find uncomfortable: have you been trying to force output from a depleted system? The Epicurean economy is one of sustainable pleasure — which requires proper rest, simple enjoyment, and freedom from chronic overextension. If you cannot find motivation, the problem may not be discipline but exhaustion.\n\nEpicurus was radical in his insistence that a good life is a simple, pleasurable, sustainable life — not a relentless optimization project. Sometimes the honest Epicurean response to lack of motivation is: rest, genuinely, without guilt. Then return.',
        actionStep:
            'Before forcing the work: have you slept? Eaten? Moved? Address the simplest physical need first. Then see what changes.',
      ),
      PhilosophyPerspective(
        philosophyId: 'rationalism',
        philosophyName: 'Rationalism',
        emoji: '🔭',
        keyInsight:
            'Examine the belief: "I need to feel motivated to act." Is that actually true?',
        perspective:
            'The rationalist would subject the premise "I need to feel motivated to do this" to examination. Is this true? Where did this belief come from? Is there evidence that acting without motivation is impossible — or merely that it is uncomfortable?\n\nEvidence: you have certainly acted without motivation before. You have gotten out of bed on hard days, completed work when depleted, done things you did not want to do and survived. The belief "I can\'t" is not a fact. It is a story. Reason can challenge it.',
        actionStep:
            'Write: "I believe I cannot act without motivation because ___." Then find three counterexamples from your own experience.',
      ),
      PhilosophyPerspective(
        philosophyId: 'absurdism',
        philosophyName: 'Absurdism',
        emoji: '🎭',
        keyInsight: 'There is no ultimate purpose. Choose to create anyway.',
        perspective:
            'Camus\'s artist — who creates without certainty that it matters, who works without cosmic validation — is the absurdist model for motivation. The painter paints. The writer writes. Not because the universe rewards them, not because they know it will be good, but because they choose to be fully engaged with the activity of creation rather than waiting for meaning to arrive first.\n\nAbsurdist motivation is pure revolt: the choice to make and do and engage, as an act of resistance against meaninglessness. Not because you feel like it, but because the alternative — waiting — is its own kind of surrender.',
        actionStep:
            'Create something — write a paragraph, draw a sketch, build something small — with no goal attached. The act of creating, not the product, is the point.',
      ),
      PhilosophyPerspective(
        philosophyId: 'cynicism',
        philosophyName: 'Cynicism',
        emoji: '🐕',
        keyInsight:
            'Is this task genuinely worth doing? If not, stop. If yes, do it without complaint.',
        perspective:
            'Diogenes would cut through motivational theory immediately: Is this task genuinely worth doing? If not, stop doing it. If yes, do it. The Cynics had no patience for elaborate psychological frameworks for doing things you know you should do. Either it matters or it doesn\'t.\n\nThe Cynic question is clarifying: much of what people call lack of motivation is actually unacknowledged resentment at doing things they don\'t believe in. The Cynic prescription: be honest about whether this is worth your life energy. If it is, act. If it\'s not, stop and do something worth doing instead.',
        actionStep:
            'Write: "This task is worth doing because ___." If you can write an honest answer, begin. If you cannot, seriously reconsider whether you should be doing it at all.',
      ),
    ],
  ),

  // ── PURPOSE ──────────────────────────────────────────────────────────────────
  ComparisonSituation(
    id: 'purpose',
    title: 'Don\'t know my purpose',
    icon: '🧭',
    prompt:
        'You feel lost or directionless, unsure what your life is supposed to be about.',
    perspectives: [
      PhilosophyPerspective(
        philosophyId: 'existentialism',
        philosophyName: 'Existentialism',
        emoji: '🌌',
        keyInsight:
            'You have no pre-given purpose. You create one through living.',
        perspective:
            'Sartre\'s most important contribution to this question is radical: there is no purpose waiting for you to discover. "Existence precedes essence" means you have no fixed nature or destiny. You are condemned to create yourself through choice and action. The search for "my purpose" can itself be a form of bad faith — waiting for an answer that will never arrive from outside you.\n\nThe existentialist reframe: instead of asking "what is my purpose?" ask "what do I choose to devote myself to?" The purpose is not found — it is made, through commitment, action, and the willingness to be accountable for your choices. Begin with what genuinely engages you and commit to it.',
        actionStep:
            'Write: "I choose to devote myself to ___ because ___." Complete both blanks honestly. This is not your permanent answer — it is a commitment for today.',
      ),
      PhilosophyPerspective(
        philosophyId: 'virtue_ethics',
        philosophyName: 'Virtue Ethics',
        emoji: '🏛️',
        keyInsight:
            'Your purpose is to flourish. Find the activities that engage your deepest capacities.',
        perspective:
            'Aristotle\'s answer to this question is both reassuring and demanding. Every human being has a purpose — eudaimonia, flourishing — and it is realized through the full exercise of your distinctly human capacities: reason, virtue, love, creativity, political engagement. The question is not "what is my unique cosmic calling?" but "what activities bring me into full, excellent engagement with the world?"\n\nAristotle also observed that eudaimonia requires action — it is not a state you achieve and then maintain, but an ongoing way of living. Your purpose is not a destination but a quality of engagement available to you in any direction you genuinely commit to.',
        actionStep:
            'Write five activities that fully absorb you — where time disappears and you are completely present. These are clues to where your flourishing lives.',
      ),
      PhilosophyPerspective(
        philosophyId: 'buddhism',
        philosophyName: 'Buddhism',
        emoji: '🪷',
        keyInsight:
            'The search for a fixed purpose can itself be clinging. Purpose is found in presence.',
        perspective:
            'Buddhist philosophy would ask: "Who is the one looking for a purpose?" The search for a fixed, permanent purpose is often a search for a fixed, permanent self — which Buddhism sees as another form of clinging. The "self" that would have a purpose is not a static entity. It is a process.\n\nThis is not a nihilistic answer. Buddhist practice actually generates a clear sense of direction — but it comes from moment-to-moment alignment with one\'s deepest values (compassion, wisdom, liberation from suffering), not from a narrative about a unique destiny. Purpose, in Buddhist terms, is less a story about your life and more a quality of presence in each moment.',
        actionStep:
            'Instead of asking "what is my purpose?" ask "what can I contribute to the people around me today?" Act from that.',
      ),
      PhilosophyPerspective(
        philosophyId: 'stoicism',
        philosophyName: 'Stoicism',
        emoji: '⚖️',
        keyInsight:
            'Virtue is the purpose. How you act matters more than what you achieve.',
        perspective:
            'The Stoics had a clear answer to the purpose question: to live according to virtue and reason, in alignment with nature. This is not as vague as it sounds. It means: be as wise, just, courageous, and temperate as you can be in your actual circumstances. The purpose is not found in a particular career or calling but in the quality of engagement with whatever circumstances you find yourself in.\n\nMarcus Aurelius was an emperor who didn\'t want to be an emperor. He found his purpose not in the role but in how he inhabited it — with justice, reason, and a relentless commitment to excellence of character. The question is not what to do with your life, but how to do whatever you are doing.',
        actionStep:
            'Write: "In my current situation, what would it look like to act with complete wisdom, justice, and care?" That is your purpose for today.',
      ),
      PhilosophyPerspective(
        philosophyId: 'humanism',
        philosophyName: 'Humanism',
        emoji: '🌍',
        keyInsight:
            'Purpose is found in contribution. What does the world need that you can provide?',
        perspective:
            'Humanism offers a practical answer to the purpose question: purpose is found in contribution to human flourishing. Not in a grand, heroic sense — but in the specific, concrete ways your particular combination of skills, experience, and care can serve other people.\n\nThe humanist exercise: consider the intersection of what you are good at, what you find meaningful, and what the world or your community genuinely needs. Purpose does not require a cosmic calling — it requires engagement with real human needs and the willingness to develop the capacities to address them.',
        actionStep:
            'Write: "The people I most want to help are ___, and the specific contribution I could make is ___." This is a working definition of purpose.',
      ),
      PhilosophyPerspective(
        philosophyId: 'taoism',
        philosophyName: 'Taoism',
        emoji: '☯️',
        keyInsight:
            'You do not find your path. You walk it, and it reveals itself.',
        perspective:
            'The Tao Te Ching does not offer purpose as a destination to reach but as a quality of movement. "The Tao that can be named is not the eternal Tao" — any fixed definition of your purpose is already a reduction of something living and dynamic into something static.\n\nThe Taoist approach to purpose is: move toward what draws you, away from what depletes you, with honesty and simplicity. The path clarifies as you walk it. Obsessive searching for "the purpose" from a stationary position generates only more confusion. Begin moving in the direction that feels most alive, and observe what the movement reveals.',
        actionStep:
            'What draws you, right now, that you have been postponing until you "figure out your purpose"? Do that thing. The path begins under your feet.',
      ),
      PhilosophyPerspective(
        philosophyId: 'pragmatism',
        philosophyName: 'Pragmatism',
        emoji: '⚙️',
        keyInsight:
            'Stop searching for purpose abstractly. Experiment with what works.',
        perspective:
            'The pragmatist would find the abstract search for "my purpose" philosophically suspect. Dewey: "A problem well stated is a problem half solved." The question "what is my purpose?" is poorly stated — it presupposes there is a fixed answer to be discovered. Better questions: What produces genuine engagement and energy for me? What do I want to be better at? What experiments have I tried?\n\nPragmatism treats purpose as something built through iterative experimentation — you try things, observe what works, revise and improve. The person who finds their purpose is not the one who found the right answer but the one who acted most persistently and reflectively.',
        actionStep:
            'Design one small experiment this week: try one activity, project, or way of contributing you are genuinely curious about. Treat it as data, not destiny.',
      ),
      PhilosophyPerspective(
        philosophyId: 'nihilism',
        philosophyName: 'Nihilism',
        emoji: '🖤',
        keyInsight:
            'No purpose is given. This is terrifying and also total freedom.',
        perspective:
            'Nietzsche would say: the fact that you feel the absence of purpose is itself significant. You are experiencing the death of the inherited narratives — religious, cultural, familial — that once provided automatic purpose. This is a clearing. It is painful. It is also the precondition of genuine self-creation.\n\nNietzsche\'s response is not to restore false certainty but to use the void deliberately: examine what you actually want from your life, stripped of all obligation to meet others\' expectations. Create your own values. Become what you are. The Übermensch does not find purpose — the Übermensch creates it.',
        actionStep:
            'Write: "If I could live any way I wanted with no expectations from anyone, I would ___." This is the raw material of self-authored purpose.',
      ),
      PhilosophyPerspective(
        philosophyId: 'absurdism',
        philosophyName: 'Absurdism',
        emoji: '🎭',
        keyInsight:
            'Purpose is not given and cannot be found. Revolt against that fact by living fully.',
        perspective:
            'Camus would say you will not find a cosmic purpose because none exists. The universe has no plan for you. This is the Absurd. The question is whether you can respond with revolt — choosing full engagement with your actual life — rather than either despair (passive nihilism) or self-deception (pretending a purpose has been revealed).\n\nSisyphus is purposeless in the cosmic sense. And yet — Camus insists — he is happy. Because he has chosen to be fully present to his actual experience, refusing to wait for external validation that will never come. This is the invitation: live fully, intensely, without waiting for permission.',
        actionStep:
            'Do one thing today purely because you want to, with no concern for whether it is productive, purposeful, or impressive. This is revolt.',
      ),
      PhilosophyPerspective(
        philosophyId: 'epicureanism',
        philosophyName: 'Epicureanism',
        emoji: '🌿',
        keyInsight:
            'Purpose is simpler than you think: live well, love well, think well.',
        perspective:
            'Epicurus would cut through the grandiosity of the "purpose" question immediately. The goal of life is tranquility, freedom from fear and pain, and the pleasure of genuine friendship and philosophical understanding. This is available to you today, in your current circumstances. You do not need a cosmic calling or a unique contribution to live a good life.\n\nThe Epicurean purpose is simultaneously humble and radical: live simply, cultivate deep friendships, engage in honest self-examination, free yourself from unnecessary desires. This is enough. More than enough. Most people die having never genuinely achieved this, while spending their lives searching for something grander.',
        actionStep:
            'Write three things you could do this week that would contribute to a genuinely simple, pleasant, honest life. Do one of them today.',
      ),
      PhilosophyPerspective(
        philosophyId: 'rationalism',
        philosophyName: 'Rationalism',
        emoji: '🔭',
        keyInsight: 'Reason can clarify your values. Start there.',
        perspective:
            'The rationalist approach to purpose: if you want to know your purpose, reason through your values. What do you believe is genuinely good? What do you think genuinely matters in a human life? What, on honest examination, do you want your life to have been for? You cannot reason your way to a cosmic purpose, but you can reason your way to clarity about your genuine values — and purpose built on examined values is more durable than one inherited or imposed.\n\nKant\'s categorical imperative is useful here: what would it be like if everyone lived as you are living? Is that a world you would want? This is a rational test for whether your current life direction is genuinely aligned with what you believe matters.',
        actionStep:
            'Write your answer to: "I believe a human life is well-lived when it ___." This is your rational foundation. Build purpose on it.',
      ),
      PhilosophyPerspective(
        philosophyId: 'cynicism',
        philosophyName: 'Cynicism',
        emoji: '🐕',
        keyInsight:
            'Purpose is living honestly with as little pretense as possible.',
        perspective:
            'Diogenes had a very clear purpose: to expose pretension, live honestly, require nothing from convention, and demonstrate by example that virtue requires no external scaffolding. His "purpose" was radical honesty and radical self-sufficiency.\n\nThe Cynic challenge: most of the searching for purpose is actually searching for social validation — a role that others will recognize as meaningful and impressive. Strip that away. What would you do with your life if no one would ever know about it, respect you for it, or validate it? That — whatever it is — is closer to genuine purpose.',
        actionStep:
            'Write: "If no one would ever know or approve of how I spent my life, I would ___." Consider whether any of that is actually available to you.',
      ),
    ],
  ),

  // ── FAILURE ──────────────────────────────────────────────────────────────────
  ComparisonSituation(
    id: 'failure',
    title: 'Afraid of failing',
    icon: '😨',
    prompt:
        'Fear of failure is stopping you from trying or making you miserable when you do.',
    perspectives: [
      PhilosophyPerspective(
        philosophyId: 'stoicism',
        philosophyName: 'Stoicism',
        emoji: '⚖️',
        keyInsight: 'The outcome is not in your control. Excellent effort is.',
        perspective:
            'Stoicism is the philosophy most directly designed for this situation. Epictetus taught: there is your effort, your preparation, your attitude — these are within your power. The outcome is not. A Stoic archer aims with complete skill and care, releases the arrow, and is at peace whether it hits or misses — because the archer has done their part.\n\nFear of failure is always fear of an outcome. Redirect the energy: what is the best effort you can make? What excellent preparation can you do? Give that everything. The result is not yours to control, and therefore not yours to fear.',
        actionStep:
            'Write the difference between what you control (preparation, effort, attitude) and what you do not (outcome, others\' reactions). Commit fully to the first.',
      ),
      PhilosophyPerspective(
        philosophyId: 'existentialism',
        philosophyName: 'Existentialism',
        emoji: '🌌',
        keyInsight:
            'Not trying is the only true failure. Everything else is data.',
        perspective:
            'Sartre would say that the fear of failure is a form of bad faith: refusing to fully commit because you want to preserve the comfortable fiction that you "could have" succeeded if you had "really tried." By not fully trying, you protect your self-image at the cost of your authenticity.\n\nAuthentic existence requires bringing yourself fully to your projects, accepting that you might fail, and owning the result either way. The alternative — withholding yourself to avoid risk — is a kind of slow self-extinction. You define yourself through action. By not acting, you are choosing, just as much as when you act.',
        actionStep:
            'Write: "The real reason I am afraid to try is ___." Usually it is a story about identity ("if I fail, it proves I\'m not ___"). Name the story. Then try anyway.',
      ),
      PhilosophyPerspective(
        philosophyId: 'pragmatism',
        philosophyName: 'Pragmatism',
        emoji: '⚙️',
        keyInsight: 'Failure is information. You cannot improve without it.',
        perspective:
            'Dewey was unambiguous: "Failure is instructive. The person who really thinks learns quite as much from his failures as from his successes." The pragmatist sees failure not as evidence against you but as feedback about what needs adjustment. The question is not "did I fail?" but "what did I learn that I can apply next time?"\n\nFear of failure is often fear of evidence — the terror that trying and failing will somehow confirm a terrible belief about yourself. The pragmatist response: one failure is data, not destiny. Your theory about yourself needs more trials. Try more.',
        actionStep:
            'Write a specific failure from your past. What did it actually teach you? What would you not know now if you hadn\'t failed then?',
      ),
      PhilosophyPerspective(
        philosophyId: 'absurdism',
        philosophyName: 'Absurdism',
        emoji: '🎭',
        keyInsight:
            'The universe does not care about your success or failure. Act with full commitment anyway.',
        perspective:
            'The absurdist insight into failure is liberating if genuinely understood: there is no cosmic verdict being rendered about you when you fail. Failure has no ultimate meaning. Your value as a human being is not indexed to your outcomes. This is not a comforting platitude — it is a philosophical position about the nature of the universe.\n\nCamus\'s response: do not perform for an audience that does not exist. Act with full commitment to your own standard of excellence, expect nothing from the result, and revolt against the anxiety that comes from treating failure as a cosmic judgment. Sisyphus pushes the boulder with everything he has — not because he expects it to stay up, but because full engagement is the only honest response to existence.',
        actionStep:
            'Act today with full effort on something you\'ve been withholding from, with deliberate indifference to the outcome. Give everything to the doing.',
      ),
      PhilosophyPerspective(
        philosophyId: 'virtue_ethics',
        philosophyName: 'Virtue Ethics',
        emoji: '🏛️',
        keyInsight:
            'Courage is the virtue that makes all other virtues possible. Practice it.',
        perspective:
            'Aristotle placed courage — action in the face of genuine fear about genuine stakes — as a foundational virtue, because without it no other virtue can be fully expressed. You cannot be generous if fear of judgment stops you from giving. You cannot be just if fear of consequences makes you dishonest. You cannot develop wisdom if fear of being wrong prevents you from committing to positions.\n\nThe virtue-ethics view of failure: it is not a verdict but a normal part of the learning process that builds excellence. Athletes fail constantly before they excel. Artists produce poor work before they produce great work. Character is built through engagement, not avoidance.',
        actionStep:
            'Identify one thing you have been withholding from out of fear. Make the courageous attempt today. The quality of the attempt matters more than the outcome.',
      ),
      PhilosophyPerspective(
        philosophyId: 'buddhism',
        philosophyName: 'Buddhism',
        emoji: '🪷',
        keyInsight:
            'Fear of failure is clinging to a self-image that needs to be protected.',
        perspective:
            'Buddhist psychology identifies fear of failure as a form of ego-protection: the suffering comes not from failure itself but from the story that failure tells about a fixed self. "I failed, therefore I am a failure" is the move that generates the most suffering. But the "I" who could be permanently defined by a failure is not real — it is a construct.\n\nThe practice is to hold even catastrophic failure lightly: this happened; it is impermanent; it does not constitute the totality of what you are. Compassion for yourself when you fail is not weakness — it is the accurate recognition that you are doing your best in conditions of genuine uncertainty.',
        actionStep:
            'Write about a past failure with the compassion you would offer a close friend. Then extend that same compassion to your current fear.',
      ),
      PhilosophyPerspective(
        philosophyId: 'nihilism',
        philosophyName: 'Nihilism',
        emoji: '🖤',
        keyInsight:
            'Failure has no ultimate significance. Neither does success. Act freely.',
        perspective:
            'Nietzsche\'s amor fati — love of fate — applied to failure means: not just accepting failure as inevitable, but embracing it as part of what makes life worth living. The person who has never genuinely risked failure has never genuinely lived. The scars of attempted things are evidence of a life actually engaged with.\n\nThe nihilist reframe: you are operating as if failure is cosmically significant. It isn\'t. Not in a nihilistic way that makes nothing matter — in the Nietzschean way that removes false significance from outcomes and returns attention to the quality of engagement. Risk and fail freely. What you discover about yourself will be worth far more than the safety of never trying.',
        actionStep:
            'Write: "If failure had no significance whatsoever, I would try ___." Then try it.',
      ),
      PhilosophyPerspective(
        philosophyId: 'taoism',
        philosophyName: 'Taoism',
        emoji: '☯️',
        keyInsight:
            'Failure and success are two faces of the same thing. Release attachment to both.',
        perspective:
            'The Tao Te Ching: "Success is as dangerous as failure. Hope is as hollow as fear." The Taoist view dissolves the binary: both success and failure are outcomes of the process of living and acting, and attachment to either disturbs the equanimity that is the Taoist ideal.\n\nMore practically: fear of failure often comes from over-identification with outcome. The Taoist practice is to identify with the process — the effort, the craft, the engagement — rather than with results. A tree does not measure its success by how many fruits fall and how many are eaten. It grows according to its nature.',
        actionStep:
            'Work on something today with complete focus on the quality of your process, deliberately releasing any attention to the outcome.',
      ),
      PhilosophyPerspective(
        philosophyId: 'humanism',
        philosophyName: 'Humanism',
        emoji: '🌍',
        keyInsight:
            'Every human fails. It is the condition of being ambitious. You are not uniquely fragile.',
        perspective:
            'Humanism places failure in the context of the human condition: every person who has accomplished anything significant has failed, repeatedly and sometimes spectacularly, along the way. Your fear of failure implicitly assumes that others are not failing — which is an illusion created by the fact that people share their successes more readily than their failures.\n\nThe humanist perspective also reminds you that your value as a person is not contingent on your performance. You have inherent dignity regardless of outcomes. The fear of failure often carries an implicit threat to self-worth — and humanism pushes back on that foundation with the assertion of unconditional human dignity.',
        actionStep:
            'Research one person you admire. Find out about their major failures. Notice that failure did not end them — it was part of their story.',
      ),
      PhilosophyPerspective(
        philosophyId: 'epicureanism',
        philosophyName: 'Epicureanism',
        emoji: '🌿',
        keyInsight:
            'The turbulence of ambition may not be worth the disturbance it causes.',
        perspective:
            'Epicurus would gently ask: is this goal, with its attendant fear and anxiety, actually worth pursuing? Does the hope of success — if realized — actually produce the tranquility you want, or does it simply generate new desires and new fears? Many of the things people most fear failing at are things that, if achieved, would not produce the happiness promised.\n\nThis is not an argument for never trying. It is an argument for honest examination: are you pursuing this because you genuinely value it, or because social pressure makes you feel you must? Epicurean contentment does not require impressive achievements.',
        actionStep:
            'Write honestly: "If I achieved this and nothing else changed in my life, would I actually be happier?" Use the answer.',
      ),
      PhilosophyPerspective(
        philosophyId: 'rationalism',
        philosophyName: 'Rationalism',
        emoji: '🔭',
        keyInsight: 'Examine the belief: what, exactly, would failure prove?',
        perspective:
            'The rationalist would subject the fear of failure to Cartesian examination. What would failure actually demonstrate? Usually, fear of failure involves an unstated logical move: "If I fail at X, this proves Y about me." But this inference is almost never valid. Failing at a job interview does not prove you are incompetent. Failing in a relationship does not prove you are unlovable. The catastrophic conclusion does not follow from the evidence.\n\nOnce you identify the specific catastrophic interpretation, you can examine whether it is logically supported. Usually it is not. The fear is not really about the failure — it is about the story you have committed to telling yourself if the failure occurs.',
        actionStep:
            'Write: "If I fail, I will tell myself ___." Then write: "Is that actually true? What is the evidence? What is the alternative interpretation?"',
      ),
      PhilosophyPerspective(
        philosophyId: 'cynicism',
        philosophyName: 'Cynicism',
        emoji: '🐕',
        keyInsight:
            'Most fear of failure is fear of social judgment. And social judgment is worthless.',
        perspective:
            'Diogenes\'s shamelessness (anaideia) was specifically designed for this: refusing to be controlled by the fear of others\' contempt. Most fear of failure is not about consequences — it is about how others will see you, what they will say, whether you will be respected or mocked. These are conventional concerns, and the Cynic view is that they are not worth a single genuine act of living.\n\nThe Cynic diagnostic: strip away the social dimension of your fear and see what remains. If failure in private, known only to you, would feel fine — then your fear is purely social, and the Cynic would say: that fear is not worth an hour of your life.',
        actionStep:
            'Ask: "If no one would ever know I failed, would I still be afraid?" If no — the fear is social performance anxiety. Notice how much power you are giving to what others will think.',
      ),
    ],
  ),

  // ── ANGER ────────────────────────────────────────────────────────────────────
  ComparisonSituation(
    id: 'anger',
    title: 'Angry at someone who hurt me',
    icon: '😡',
    prompt:
        'Someone wronged you and you can\'t let go of the anger or resentment.',
    perspectives: [
      PhilosophyPerspective(
        philosophyId: 'stoicism',
        philosophyName: 'Stoicism',
        emoji: '⚖️',
        keyInsight:
            'Your anger is your judgment. You can examine and change your judgments.',
        perspective:
            'The Stoics did not say anger is wrong — they said it arises from false judgments. Specifically, the judgment that someone\'s wrong action against you has damaged something genuinely valuable. Seneca\'s treatise On Anger is remarkably direct: anger is almost always disproportionate to its object, and it punishes the person who holds it far more than the person who provoked it.\n\nThe Stoic question is not "were they wrong?" (they may well have been) but "is your ongoing anger serving your virtue?" Usually not. Anger sustained as resentment is poison you drink while expecting the other person to suffer.',
        actionStep:
            'Write what the anger is costing you — in peace, attention, relationships, energy. Is this cost justified by anything the anger is accomplishing?',
      ),
      PhilosophyPerspective(
        philosophyId: 'buddhism',
        philosophyName: 'Buddhism',
        emoji: '🪷',
        keyInsight:
            'Holding anger is like holding a burning coal. You are the one being burned.',
        perspective:
            'Buddhist teaching on anger is vivid: holding resentment against someone is like holding a burning coal with the intention of throwing it at them. The coal burns you first. The practice is not to suppress anger — suppression creates more suffering — but to observe it with awareness rather than feeding it with story.\n\nBuddhism also offers a powerful practice for sustained anger: consider the person who hurt you as someone who themselves is suffering, acting from their own ignorance and pain. This is not excusing them. It is placing their behavior in a context that makes it comprehensible — and compassion for their suffering does not require agreement with their actions.',
        actionStep:
            'Spend 5 minutes contemplating the person who hurt you: what fear, pain, or ignorance might have driven their behavior? This is not forgiveness — it is understanding.',
      ),
      PhilosophyPerspective(
        philosophyId: 'existentialism',
        philosophyName: 'Existentialism',
        emoji: '🌌',
        keyInsight: 'Your response to being hurt is a choice that defines you.',
        perspective:
            'Sartre would observe: you cannot change what they did. You can choose your response. Choosing to maintain anger as a dominant orientation to your life is a choice — one that defines you as much as any other. Bad faith would be saying "I can\'t help being angry" — this is denying your freedom. You are choosing to be angry every moment you do not choose otherwise.\n\nThis is not dismissive of genuine harm. It is a call to responsibility: the person who hurt you has had their effect. What do you want your response to be? What kind of person do you want to be in the aftermath? That is now entirely your choice.',
        actionStep:
            'Write: "By staying angry, I am choosing to ___." Complete it honestly. Then write what you would choose if you were acting from your best self.',
      ),
      PhilosophyPerspective(
        philosophyId: 'virtue_ethics',
        philosophyName: 'Virtue Ethics',
        emoji: '🏛️',
        keyInsight:
            'Justice matters. So does the kind of person you become in pursuing it.',
        perspective:
            'Virtue ethics takes justice seriously — wrongs matter, and appropriate anger at genuine injustice is not a character flaw. The Aristotelian virtue is not the absence of anger but right anger: at the right person, for the right reasons, to the right degree, at the right time, for the right purpose. Righteous indignation is the virtuous mean between hot-headedness (excess) and passivity that cannot be moved by genuine wrong (deficiency).\n\nThe question is: has your anger maintained its proportionality and purpose, or has it become a character-distorting force that is doing more damage to your relationships and character than to the person who wronged you?',
        actionStep:
            'Write whether your anger is proportionate to the actual wrong, and whether it is being directed in ways that produce justice or merely pain.',
      ),
      PhilosophyPerspective(
        philosophyId: 'taoism',
        philosophyName: 'Taoism',
        emoji: '☯️',
        keyInsight:
            'Water yields to the rock and wears it away. Force creates resistance.',
        perspective:
            'The Tao observes that resistance intensifies resistance. Anger directed at someone who wronged you often creates a locked dynamic — the harder you push, the more entrenched both parties become. Water does not force. It flows around, through, and eventually past every obstacle.\n\nThis is not a prescription for passivity in the face of injustice. It is an observation about method: sustained anger is forceful and creates friction. The Taoist response often finds more resolution through releasing the grip than through intensifying the struggle. When you stop defining yourself by this wrong, the wrong itself loses power over you.',
        actionStep:
            'For one day, spend no mental energy on this person or this wrong. Not as forgiveness, but as an experiment in wu wei. Notice what opens up in the space.',
      ),
      PhilosophyPerspective(
        philosophyId: 'pragmatism',
        philosophyName: 'Pragmatism',
        emoji: '⚙️',
        keyInsight: 'What is this anger accomplishing? Is it working?',
        perspective:
            'The pragmatist question is simple and powerful: what is your anger actually achieving? Not what you feel it should achieve, or what would be just — but what is it actually producing in the real world? If holding the anger is leading to meaningful resolution, dialogue, or change, it may be serving a purpose. If it is producing only internal suffering and relationship deterioration, it is not working.\n\nJohn Dewey: "Conflict is the gadfly of thought." Anger is information — it tells you a value was violated. Once you have heard that message, the question is what action it calls for, not how long you can sustain the feeling.',
        actionStep:
            'Write what outcome you want from this situation. Then write what actions would actually produce that outcome. Does sustained anger help or hinder?',
      ),
      PhilosophyPerspective(
        philosophyId: 'humanism',
        philosophyName: 'Humanism',
        emoji: '🌍',
        keyInsight: 'Forgiveness is not for them. It is for you.',
        perspective:
            'Humanism takes seriously both the wrong done and the humanity of the person who did it. Both are true simultaneously: the action was harmful, and the person who performed it is a full human being with their own history, fear, and limitations. These are not contradictions — they are the complexity of human reality.\n\nHumanist psychology also emphasizes that forgiveness — when it is genuine, not forced — is primarily an act of self-care, not a gift to the other person. You are not excusing their behavior. You are releasing the injury from the center of your attention so that you can return your energy to your own life.',
        actionStep:
            'Write a distinction between forgiving the person and accepting the behavior. The first may be possible and healthy. The second is not required.',
      ),
      PhilosophyPerspective(
        philosophyId: 'nihilism',
        philosophyName: 'Nihilism',
        emoji: '🖤',
        keyInsight:
            'In perspective, this moment will pass. Use the energy for self-creation.',
        perspective:
            'Nietzsche\'s perspective on resentment (ressentiment) is one of his most important ideas: he saw sustained, powerless anger toward those who have power over you as one of the most psychologically destructive forces there is. Ressentiment redefines the world in terms of what has been done to you — making your suffering, your victimhood, your anger the organizing principle of your existence. This is the opposite of the will to power.\n\nThe Nietzschean response: convert the energy. Anger is information and power. Use it to build something, create something, become something stronger. The best revenge is living well — but more importantly, the best life is one directed by your own values, not defined by someone else\'s wrong.',
        actionStep:
            'Write what you would build, create, or become if you channeled the energy of this anger into self-creation rather than resentment.',
      ),
      PhilosophyPerspective(
        philosophyId: 'absurdism',
        philosophyName: 'Absurdism',
        emoji: '🎭',
        keyInsight:
            'They acted; it happened; the universe is indifferent. Choose what to do with your remaining life.',
        perspective:
            'Camus would not validate the anger and would not dismiss it either. He would say: this happened. It is real. There may be no cosmic justice or correction. The universe is indifferent to both your injury and your anger. So: what now?\n\nThe absurdist revolt here is to refuse to let someone else\'s wrong action determine the quality of your ongoing life. You continue. You live fully. Not because justice will be done, or because the anger is wrong, but because the only authentic response to existence — including its injuries — is continued, full engagement with your actual life.',
        actionStep:
            'Write: "This person took ___ from me. I refuse to let them also take ___." Use that second answer to decide how to spend today.',
      ),
      PhilosophyPerspective(
        philosophyId: 'epicureanism',
        philosophyName: 'Epicureanism',
        emoji: '🌿',
        keyInsight:
            'Anger disturbs your peace. The injury already happened. Don\'t let it continue.',
        perspective:
            'Epicurus would be very direct: the person wronged you once. Every moment of sustained anger is a subsequent choice to allow them to wrong you again. Anger is a disturbance to ataraxia — the deep tranquility that is the highest good. It is, in Epicurean terms, almost never worth the cost to your peace of mind.\n\nThis is not passive acceptance. It is the recognition that your wellbeing is your own responsibility, and that choosing to maintain a disturbed state in response to someone else\'s action is a choice you are making — not something being done to you.',
        actionStep:
            'For the next hour, deliberately choose to protect your peace. When thoughts of the anger arise, name them and return attention to the present moment.',
      ),
      PhilosophyPerspective(
        philosophyId: 'rationalism',
        philosophyName: 'Rationalism',
        emoji: '🔭',
        keyInsight: 'Examine the anger carefully. What exactly is it based on?',
        perspective:
            'The rationalist approach: examine the specific claims underlying the anger. Was the action genuinely wrong, or does it merely feel wrong from your perspective? What would a fully informed, impartial observer conclude? This is not to doubt your experience but to ensure that the anger is based on accurate understanding rather than interpretation, assumption, or incomplete information.\n\nRationalism also asks: what do you want as the outcome? Then: what actions are most likely to produce that outcome? Sustained anger is rarely the answer — but clarifying what specifically was wrong and what would constitute appropriate resolution often produces both better outcomes and a reduction in the destructive aspects of the feeling.',
        actionStep:
            'Write the most accurate, specific account of what happened and why it was wrong. Then write what resolution you actually want.',
      ),
      PhilosophyPerspective(
        philosophyId: 'cynicism',
        philosophyName: 'Cynicism',
        emoji: '🐕',
        keyInsight:
            'Your anger may contain truth. Speak it plainly and move on.',
        perspective:
            'Diogenes was famous for parrhesia — radical, unflinching honesty about what he observed, with no diplomatic softening. The Cynic response to being wronged is: say exactly what was wrong, directly to the person if possible, with no performance of injured feelings and no sustained resentment. Honesty discharged is anger dissolved.\n\nThe Cynic also observes that most resentment is sustained not because justice hasn\'t been served but because the truth hasn\'t been spoken plainly. The injured person ruminates and suffers precisely because they are not saying the true thing. Say the true thing. Then be done.',
        actionStep:
            'Write exactly what you would say to this person if you could say anything with total honesty, no diplomatic filtering, and no fear of consequences. You do not have to send it.',
      ),
    ],
  ),

  // ── DECISION ─────────────────────────────────────────────────────────────────
  ComparisonSituation(
    id: 'decision',
    title: 'Need to make a big decision',
    icon: '🤔',
    prompt:
        'You are facing a significant choice and feel paralyzed or overwhelmed.',
    perspectives: [
      PhilosophyPerspective(
        philosophyId: 'stoicism',
        philosophyName: 'Stoicism',
        emoji: '⚖️',
        keyInsight: 'Ask what the virtuous person does. Then do that.',
        perspective:
            'The Stoic decision-making framework is elegant: rather than optimizing for outcomes (which are not fully in your control), optimize for character. "What would a wise, just, courageous, and temperate person do in this situation?" Often this question cuts through ambivalence remarkably quickly — because deep down you know what the right action is. The difficulty is usually not epistemic (not knowing what\'s right) but moral (courage to do it).\n\nMarcus Aurelius also used the view from above: imagine looking at your decision from the perspective of a cosmic observer who cares about virtue and reason, not about your personal comfort or reputation. What does that observer advise?',
        actionStep:
            'Write: "The most virtuous, wise, and courageous action available to me here is ___." Then write what is stopping you from taking it.',
      ),
      PhilosophyPerspective(
        philosophyId: 'pragmatism',
        philosophyName: 'Pragmatism',
        emoji: '⚙️',
        keyInsight:
            'A decision is a bet on consequences. Examine the expected outcomes carefully.',
        perspective:
            'William James and Dewey were very practical about decision-making: trace the actual consequences of each option as specifically as possible. Not in terms of feelings or identity, but in terms of what will actually happen in the world, to specific people, over specific timeframes. Then ask which set of consequences you would most want to produce.\n\nPragmatism also liberates you from the demand for certainty: decisions are bets, not guarantees. A good decision is one made thoughtfully with the best available information, not one that happens to produce a good outcome. You cannot know in advance which bets will pay off. Your job is to reason well and act.',
        actionStep:
            'For each option: write the most likely outcomes in 6 months and 2 years. Focus on concrete realities, not feelings. Which outcomes do you most want?',
      ),
      PhilosophyPerspective(
        philosophyId: 'existentialism',
        philosophyName: 'Existentialism',
        emoji: '🌌',
        keyInsight:
            'Every choice is an act of self-creation. Ask who you want to become.',
        perspective:
            'For Sartre, the most important question in any significant decision is not "which option is better?" but "which choice creates the person I want to be?" Because you define yourself through your choices, every major decision is an act of self-authorship. The decision is not just about the outcome — it is about who you are declaring yourself to be.\n\nSartre\'s other contribution: stop looking for external validation of your decision. No philosopher, no friend, no framework can choose for you. The anguish of this — the vertigo of genuine freedom — is the sign that you are taking your own freedom seriously. Make the choice. Own it.',
        actionStep:
            'Write: "The person I want to be chooses ___." Then: "The reason I am delaying is ___." Usually the second answer reveals what needs to be addressed first.',
      ),
      PhilosophyPerspective(
        philosophyId: 'rationalism',
        philosophyName: 'Rationalism',
        emoji: '🔭',
        keyInsight: 'Clarify your values first. The decision flows from them.',
        perspective:
            'Rational decision-making requires first understanding your premises — your values. Without that foundation, you cannot evaluate options. Kant\'s approach: identify the principles you hold universally, then apply them to the specific case. Descartes\' approach: clear away confusion by methodically defining the problem, listing what is actually known, and distinguishing it from what is assumed or feared.\n\nDecision paralysis is often not a lack of options but a lack of clarity about values. Once you know what genuinely matters to you most — not in the abstract, but in this specific situation — the decision usually becomes significantly clearer.',
        actionStep:
            'Write your three most important values. Then evaluate each option against each value. Which option best honors all three, or which values does each option prioritize?',
      ),
      PhilosophyPerspective(
        philosophyId: 'taoism',
        philosophyName: 'Taoism',
        emoji: '☯️',
        keyInsight:
            'Be still. The right course often reveals itself when you stop forcing.',
        perspective:
            'Taoism is unusual among decision frameworks in recommending stillness before action. The rushing, anxious mind trying to "figure out" a decision is not the optimal tool. The Taoist practice is to become very quiet, reduce the urgency, and allow the felt sense of rightness to emerge from beneath the noise of calculation and fear.\n\nThis is not superstition — it is the recognition that beneath the surface level of anxious cognition, deeper levels of integrated knowing often operate. wu wei in decision-making means not forcing a resolution before it is ready, and not acting out of fear or urgency when patience is available.',
        actionStep:
            'Set the decision aside for 24 hours. Go for a walk. Sleep on it. Then, before consulting your analysis again, write the first answer that comes naturally. It is often correct.',
      ),
      PhilosophyPerspective(
        philosophyId: 'virtue_ethics',
        philosophyName: 'Virtue Ethics',
        emoji: '🏛️',
        keyInsight:
            'Find a mentor. Ask what a person of excellent character would do.',
        perspective:
            'Aristotle\'s practical wisdom (phronesis) is not a set of rules but an ability developed through experience, reflection, and apprenticeship. The way to develop it is to observe and learn from people of excellent character — mentors, exemplars. "What would a wise person do here?" is not a rhetorical question — it is a specific inquiry into a specific person\'s judgment.\n\nVirtue ethics also advises: consider the precedent you are setting for your character. What kind of decision-maker are you becoming with each choice? Are you building the habit of careful, courageous, honest deliberation?',
        actionStep:
            'Name the person you most respect who has faced similar decisions. Write what they would likely decide and why. Test your reasoning against theirs.',
      ),
      PhilosophyPerspective(
        philosophyId: 'buddhism',
        philosophyName: 'Buddhism',
        emoji: '🪷',
        keyInsight: 'Act from compassion and wisdom, not from fear or craving.',
        perspective:
            'Buddhist decision-making has a clear orienting principle: actions motivated by greed, hatred, and delusion lead to suffering; actions motivated by generosity, compassion, and wisdom lead to liberation. Before choosing, examine your motivation: are you acting from what you genuinely believe is right, or from fear of loss, desire for approval, or avoidance of discomfort?\n\nThe Buddhist also notes that no decision has permanent consequences — all outcomes are impermanent. This can reduce the paralyzing weight of "getting it right." There is no final, irreversible verdict. There are only moments, choices, and the opportunity to learn and adjust.',
        actionStep:
            'Write the motivation behind each option: is it fear-based or value-based? Choose the option you can make with the cleanest motivation.',
      ),
      PhilosophyPerspective(
        philosophyId: 'humanism',
        philosophyName: 'Humanism',
        emoji: '🌍',
        keyInsight:
            'Which choice serves human flourishing — yours and others\'?',
        perspective:
            'The humanist decision principle: which option best serves genuine human flourishing — your own and that of those affected by your choice? This is not pure altruism — your own flourishing matters too. But choices that sacrifice others\' wellbeing for personal gain, or that sacrifice your own wellbeing for others\' approval, both fail the humanist standard.\n\nHumanism also encourages consulting others honestly — not for validation but for perspective. The person who has faced a similar decision and can share their experience honestly is one of the most valuable resources in human life.',
        actionStep:
            'Write who is affected by this decision. Then write what outcome would best serve their flourishing alongside yours.',
      ),
      PhilosophyPerspective(
        philosophyId: 'epicureanism',
        philosophyName: 'Epicureanism',
        emoji: '🌿',
        keyInsight:
            'Which option leads to genuine tranquility rather than turbulence?',
        perspective:
            'Epicurus would apply a clear test: which option leads to ataraxia — genuine, sustainable tranquility — and which leads to chronic turbulence, craving, and fear? This is often different from which option leads to the most exciting outcome. Excitement and pleasure are not the same as the deep peace that Epicurus valued.\n\nThe Epicurean test also asks: what will you fear losing if you take this option? The greater the attachment that must be created, the more potential for suffering. Options that align with your genuine, natural needs tend toward tranquility. Options that satisfy vain desires or require dependence on unstable external goods tend toward turbulence.',
        actionStep:
            'For each option: write the ongoing maintenance cost to your peace of mind. Which option, once made, will allow you to rest?',
      ),
      PhilosophyPerspective(
        philosophyId: 'nihilism',
        philosophyName: 'Nihilism',
        emoji: '🖤',
        keyInsight:
            'No choice is cosmically predetermined. Choose what you most want to become.',
        perspective:
            'Nietzsche\'s eternal recurrence is one of the most powerful decision tools: imagine you will live this moment — including this decision and all its consequences — an infinite number of times, exactly as it is. Which option could you affirm? Which would you eventually be crushed by the repetition of?\n\nNietzsche also would say: most decision-making anxiety comes from the worry about what others will think, or whether it is "right" by some external standard. Strip that away. What do you want your life to be? The decision that creates the life you most want to live is the right decision.',
        actionStep:
            'Apply the eternal recurrence test: which choice, lived forever, could you ultimately embrace? Which would you eventually become unable to bear?',
      ),
      PhilosophyPerspective(
        philosophyId: 'absurdism',
        philosophyName: 'Absurdism',
        emoji: '🎭',
        keyInsight:
            'Choose the option that most fully expresses who you are right now.',
        perspective:
            'Camus would note that both options are fine, because there is no cosmic ledger scoring your decisions. This does not mean it does not matter — it means your freedom is complete. You are not bound by a fate or a destiny. You choose, and the act of choosing with full consciousness is itself the revolt against meaninglessness.\n\nThe absurdist prescription: choose with full commitment to the option that most aligns with your most honest sense of yourself. Not what is strategically optimal, not what others would choose, but what you — fully present to your own life — want to choose. Then live it completely, without hedging.',
        actionStep:
            'Commit to a choice right now, in writing. You can revise it tomorrow. But choose, clearly and completely, and notice what it feels like to be fully decided.',
      ),
      PhilosophyPerspective(
        philosophyId: 'cynicism',
        philosophyName: 'Cynicism',
        emoji: '🐕',
        keyInsight:
            'Strip away reputation and appearance. What do you actually want?',
        perspective:
            'Diogenes would immediately ask: how much of this decision\'s difficulty is about what others will think? Most decision paralysis involves the social element — how each option will be perceived, whether it will impress or disappoint others, what story it tells about you to the world. The Cynic strips all of that away.\n\nIgnore the audience. What do you actually want? Not what will look good, not what is conventional, not what your parents would approve of — what do you want? Often the decision becomes remarkably clear when the social performance dimension is removed.',
        actionStep:
            'Write the option you would choose if no one would ever know about it and you would never be judged for it. Notice if that is different from what you are currently leaning toward.',
      ),
    ],
  ),

  // ── FEELING LOST ─────────────────────────────────────────────────────────────
  ComparisonSituation(
    id: 'lost',
    title: 'Feeling lost',
    icon: '🧩',
    prompt:
        'You feel disconnected, without direction, unsure who you are or where you\'re going.',
    perspectives: [
      PhilosophyPerspective(
        philosophyId: 'existentialism',
        philosophyName: 'Existentialism',
        emoji: '🌌',
        keyInsight:
            'Feeling lost means you are free. That is exactly where authenticity begins.',
        perspective:
            'Sartre would say: the feeling of being lost is what happens when inherited meanings collapse and you have not yet created new ones. This is not a pathology — it is the condition of genuine freedom. Most people never feel this way because they are comfortable within the pre-given meanings of family, culture, and social role. The fact that you are questioning is the sign of authentic existence beginning.\n\nThe existentialist prescription: stop trying to find yourself and start creating yourself. The self is not a pre-existing thing to be discovered — it is made through choices and commitments. Begin anywhere. Make a commitment, however small. The direction will clarify as you move.',
        actionStep:
            'Make one commitment today — not a life plan, just one thing you will do consistently for the next two weeks. Begin it today.',
      ),
      PhilosophyPerspective(
        philosophyId: 'taoism',
        philosophyName: 'Taoism',
        emoji: '☯️',
        keyInsight:
            'Being lost is not a problem to be solved. It is a place to be inhabited.',
        perspective:
            'Laozi wrote: "The Tao that can be told is not the eternal Tao." The Taoist view is that the desire to always know where you are and where you are going is itself a source of suffering. The Way reveals itself through movement, not through having a map in advance.\n\nThe practice of dwelling in not-knowing — of being genuinely present to the confusion and the openness rather than fleeing it — is itself a profound Taoist practice. Most wisdom comes in the spaces between certainties. Being lost, if held with equanimity rather than panic, is actually a state of great openness.',
        actionStep:
            'For one day, stop trying to figure it out. Give yourself explicit permission to not know. Observe what is present in the not-knowing.',
      ),
      PhilosophyPerspective(
        philosophyId: 'stoicism',
        philosophyName: 'Stoicism',
        emoji: '⚖️',
        keyInsight:
            'Direction comes from values, not from plans. What do you value?',
        perspective:
            'The Stoics did not experience "feeling lost" as we understand it, because their orientation was not about direction toward a destination but about the quality of engagement with the present moment. Marcus Aurelius did not need to know where he was "going" because his orientation was internal: am I acting with virtue? Am I engaging with reason? Am I being just?\n\nWhen you feel lost in terms of direction, the Stoic prescription is to return to the internal compass: what do you value? What kind of person do you want to be? Act from those values in your current circumstances. The feeling of lostness is usually an external orientation problem. The solution is an internal one.',
        actionStep:
            'Write three values you hold most deeply. Then write one action aligned with each that you could take today.',
      ),
      PhilosophyPerspective(
        philosophyId: 'buddhism',
        philosophyName: 'Buddhism',
        emoji: '🪷',
        keyInsight:
            'The sense of being lost is the sense of self looking for itself. You are already here.',
        perspective:
            'Buddhist philosophy offers a paradoxical response to feeling lost: you are lost because you are looking for something — a self, a direction, a home — in the wrong place. The very looking intensifies the feeling of lostness. The Buddhist practice is to stop looking and simply be.\n\nThe concept of no-self suggests that the "me" who is lost may not be as fixed or real as it feels. What are you, right now, beyond the story of being lost? What is actually here — sensation, breath, sound, presence? The present moment is always available as a home, and it requires no navigation.',
        actionStep:
            'Sit quietly for 10 minutes with no agenda. Not meditating on a goal — just being present to whatever is here. Notice what is already present before you add the feeling of lostness.',
      ),
      PhilosophyPerspective(
        philosophyId: 'humanism',
        philosophyName: 'Humanism',
        emoji: '🌍',
        keyInsight:
            'Feeling lost often means you need connection more than direction.',
        perspective:
            'Humanist psychology has consistently found that the feeling of lostness is frequently a relational problem as much as a directional one. Humans are fundamentally social beings. When we feel disconnected from others — from genuine community, shared purpose, and authentic relationship — we experience it as lostness even when the external circumstances are objectively good.\n\nThe humanist prescription: before seeking direction, seek connection. Not online, not performative — genuinely engaging with other human beings about what is real and what matters. Meaning is co-created in relationship, not discovered in solitude.',
        actionStep:
            'Reach out today to one person you trust and tell them honestly where you are. Not to ask for advice — just to be witnessed. Connection precedes direction.',
      ),
      PhilosophyPerspective(
        philosophyId: 'pragmatism',
        philosophyName: 'Pragmatism',
        emoji: '⚙️',
        keyInsight:
            'You do not need to know the whole path. You only need to take the next step.',
        perspective:
            'Pragmatism is specifically designed for this feeling. Dewey: the person who feels lost is usually trying to see the whole path before taking any step. But paths clarify through movement, not through standing still and thinking harder. The next step is almost always available, even when the destination is not.\n\nThe pragmatist prescription: what is the smallest, most obvious next thing you could do? Not the right thing — just a thing, with genuine engagement. The direction will reveal itself through engagement, not through further contemplation.',
        actionStep:
            'Write three specific actions you could take this week that seem marginally interesting or useful. Pick the most interesting one and begin.',
      ),
      PhilosophyPerspective(
        philosophyId: 'virtue_ethics',
        philosophyName: 'Virtue Ethics',
        emoji: '🏛️',
        keyInsight:
            'Character provides direction. Become the kind of person you admire.',
        perspective:
            'Aristotle\'s answer to lostness is character-based rather than goal-based. You do not need a life plan — you need a commitment to becoming a certain kind of person. Once that is clear, direction follows: a courageous, wise, and just person takes the courageous, wise, and just action available in each moment.\n\nThe person you most admire is a clue: what qualities do they embody? What kind of character have they built? The path from here to there is made up of small daily choices, not grand plans. Begin with character, and direction follows.',
        actionStep:
            'Write the character traits of the person you most want to become. Then write one small action that would express one of those traits today.',
      ),
      PhilosophyPerspective(
        philosophyId: 'nihilism',
        philosophyName: 'Nihilism',
        emoji: '🖤',
        keyInsight:
            'The map was always an illusion. Now you can draw your own.',
        perspective:
            'Nietzsche saw the feeling of lostness — the "death of God," the collapse of inherited meaning — as the necessary precondition of genuine self-creation. You are lost because the old maps no longer work. That is not a problem — it is an opportunity. The Nietzschean prescription is not to find a new pre-made map but to learn to navigate without one.\n\nThis is uncomfortable. But the alternative — adopting a new ready-made identity or ideology to replace the one that collapsed — is just another form of borrowed meaning. The will to power here is the courage to create your own map from scratch.',
        actionStep:
            'Write: "The story I used to tell about who I am was ___. Now that it no longer fits, the story I am beginning to tell is ___." Complete both.',
      ),
      PhilosophyPerspective(
        philosophyId: 'absurdism',
        philosophyName: 'Absurdism',
        emoji: '🎭',
        keyInsight:
            'You are lost in a world that has no map. That is not your failure — it is the human condition.',
        perspective:
            'Camus would refuse to offer you a destination and would not pretend one exists. Feeling lost is the honest, clear-eyed experience of the Absurd: you want meaning and direction, and the universe offers silence. This is not your fault. This is the condition of being human and clear-eyed.\n\nThe Camus response: revolt and live. Not from direction, not from certainty, not from a known destination — but from full engagement with the actual life available to you right now. The person who is lost but living fully is ahead of the person who has found a comfortable illusion of being found.',
        actionStep:
            'Do one thing today that makes you feel fully alive — not because it leads anywhere, but because the experience itself is worth having.',
      ),
      PhilosophyPerspective(
        philosophyId: 'rationalism',
        philosophyName: 'Rationalism',
        emoji: '🔭',
        keyInsight:
            'Clarity comes from examining your beliefs, not adding more information.',
        perspective:
            'The rationalist would suggest that lostness is often the result of confused beliefs rather than absent answers. You feel lost not because the answer doesn\'t exist but because you are asking the wrong questions, or because your beliefs about what constitutes a good life are contradictory and have not been examined.\n\nThe Cartesian approach: systematically examine what you actually believe about what matters. What do you believe about the good life? What do you believe about your own capacities? What do you believe about what is possible for you? Often, lostness dissolves when the underlying confusion is made explicit and examined.',
        actionStep:
            'Write five things you believe about what makes life worth living. Then check for contradictions. Where you are living in contradiction, you will feel lost.',
      ),
      PhilosophyPerspective(
        philosophyId: 'epicureanism',
        philosophyName: 'Epicureanism',
        emoji: '🌿',
        keyInsight:
            'You already have what you need for a good life. Look more closely.',
        perspective:
            'Epicurus would say that the search for direction, purpose, and a clear path is, itself, a sign of desires that have grown too large. The good life does not require grand direction or cosmic purpose. It requires good food, genuine friendship, philosophical conversation, and freedom from unnecessary fear. These are available to you today, regardless of whether you know where you are "going."\n\nThe Epicurean diagnosis of lostness: you have been trained to want too much — a destination, a purpose, a clear identity — when the simpler pleasures of genuine presence are available right now and have always been enough.',
        actionStep:
            'Without any reference to direction or purpose: what would make today genuinely pleasant? Do that.',
      ),
      PhilosophyPerspective(
        philosophyId: 'cynicism',
        philosophyName: 'Cynicism',
        emoji: '🐕',
        keyInsight:
            'Most "lostness" is manufactured by the demand to have a story. Drop the story.',
        perspective:
            'Diogenes was never lost because he had stripped away all the social narratives that generate the demand for a coherent self-story. He did not need a career identity, a cultural role, a consistent narrative, or a plan. He needed food, sleep, sunlight, and honest engagement. That was enough.\n\nThe Cynic diagnosis: much of what people call "feeling lost" is the anxiety of not having an impressive narrative to tell about themselves — a story that will satisfy social expectations for direction, purpose, and progress. Strip that demand away. What remains? Usually more than enough.',
        actionStep:
            'Write: "I feel lost because I do not have a story that says ___." Then ask: who needs that story? Do you actually, or is this someone else\'s expectation?',
      ),
    ],
  ),
];
