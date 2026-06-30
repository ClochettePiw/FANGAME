#-------------------------------------------------------------------------------
# These are used to define what the Follower will say when spoken to in general
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# All dialogues with the Music Note animation
#-------------------------------------------------------------------------------
EventHandlers.add(:following_pkmn_talk, :music_generic, proc { |pkmn, random_val|
  if random_val == 0
    FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_MUSIC)
    pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
    messages = [
      _INTL("{1} semble vouloir jouer avec {2}."),
      _INTL("{1} chante et fredonne."),
      _INTL("{1} regarde {2} avec une expression joyeuse."),
      _INTL("{1} se balance et danse comme bon lui semble."),
      _INTL("{1} saute avec insouciance !"),
      _INTL("{1} montre son agilité !"),
      _INTL("{1} se déplace joyeusement !"),
      _INTL("Waouh ! {1} s'est soudain mis à danser de joie !"),
      _INTL("{1} suit régulièrement {2} !"),
      _INTL("{1} gambade joyeusement."),
      _INTL("{1} grignote le sol de façon joueuse."),
      _INTL("{1} mordille les pieds de {2} pour jouer !"),
      _INTL("{1} suit {2} de très près !"),
      _INTL("{1} se retourne et regarde {2}."),
      _INTL("{1} s'entraîne à montrer toute sa puissance !"),
      _INTL("{1} a envie de courir partout !"),
      _INTL("{1} se promène en profitant du paysage."),
      _INTL("{1} semble apprécier un peu tout ça !"),
      _INTL("{1} est joyeux !"),
      _INTL("{1} semble chanter quelque chose ?"),
      _INTL("{1} danse joyeusement !"),
      _INTL("{1} danse une gigue pleine d'énergie !"),
      _INTL("{1} est si heureux qu'il s'est mis à chanter !"),
      _INTL("{1} lève la tête et hurle !"),
      _INTL("{1} semble plein d'optimisme."),
      _INTL("On dirait que {1} a envie de danser !"),
      _INTL("{1} s'est soudain mis à chanter ! Il semble en pleine forme."),
      _INTL("On dirait que {1} veut danser avec {2} !")
    ]    
    value = rand(messages.length)
    case value
    # Special move route to go along with some of the dialogue
    when 3, 9
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 80])
      FollowingPkmn.move_route([
        PBMoveRoute::TURN_RIGHT,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::JUMP, 0, 0,
        PBMoveRoute::WAIT, 10,
        PBMoveRoute::TURN_UP,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::JUMP, 0, 0,
        PBMoveRoute::WAIT, 10,
        PBMoveRoute::TURN_LEFT,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::JUMP, 0, 0,
        PBMoveRoute::WAIT, 10,
        PBMoveRoute::TURN_DOWN,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::JUMP, 0, 0
      ])
    when 4, 5
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 40])
      FollowingPkmn.move_route([
        PBMoveRoute::JUMP, 0, 0,
        PBMoveRoute::WAIT, 10,
        PBMoveRoute::JUMP, 0, 0,
        PBMoveRoute::WAIT, 10,
        PBMoveRoute::JUMP, 0, 0
      ])
    when 6, 17
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 40])
      FollowingPkmn.move_route([
        PBMoveRoute::TURN_RIGHT,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_DOWN,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_LEFT,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_UP
      ])
    when 7, 28
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 60])
      FollowingPkmn.move_route([
        PBMoveRoute::TURN_RIGHT,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_UP,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_LEFT,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_DOWN,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_RIGHT,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_UP,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_LEFT,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_DOWN,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::JUMP, 0, 0,
        PBMoveRoute::WAIT, 10,
        PBMoveRoute::JUMP, 0, 0
      ])
    when 21, 22
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 50])
      FollowingPkmn.move_route([
        PBMoveRoute::TURN_RIGHT,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_UP,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_LEFT,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_DOWN,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::JUMP, 0, 0,
        PBMoveRoute::WAIT, 10,
        PBMoveRoute::JUMP, 0, 0
      ])
    end
    pbMessage(_INTL(messages[value], pkmn.name, $player.name))
    next true
  end
})
#-------------------------------------------------------------------------------
# All dialogues with the Angry animation
#-------------------------------------------------------------------------------
EventHandlers.add(:following_pkmn_talk, :angry_generic, proc { |pkmn, random_val|
  if random_val == 1
    FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_ANGRY)
    pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
    messages = [
      _INTL("{1} a poussé un rugissement !"),
      _INTL("{1} fait une grimace de colère !"),
      _INTL("{1} semble en colère pour une raison inconnue."),
      _INTL("{1} a mordillé les pieds de {2}."),
      _INTL("{1} s'est retourné, affichant une expression de défi."),
      _INTL("{1} essaie d'intimider les adversaires de {2} !"),
      _INTL("{1} a envie de se battre !"),
      _INTL("{1} est prêt à combattre !"),
      _INTL("On dirait que {1} se battrait avec n'importe qui en ce moment !"),
      _INTL("{1} grogne d'une manière qui ressemble presque à des paroles...")
    ]
    value = rand(messages.length)
    # Special move route to go along with some of the dialogue
    case value
    when 6, 7, 8
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 25])
      FollowingPkmn.move_route([
        PBMoveRoute::JUMP, 0, 0,
        PBMoveRoute::WAIT, 10,
        PBMoveRoute::JUMP, 0, 0
      ])
    end
    pbMessage(_INTL(messages[value], pkmn.name, $player.name))
    next true
  end
})
#-------------------------------------------------------------------------------
# All dialogues with the Neutral Animation
#-------------------------------------------------------------------------------
EventHandlers.add(:following_pkmn_talk, :ellipses_generic, proc { |pkmn, random_val|
  if random_val == 2
    FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_ELIPSES)
    pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
    messages = [
      _INTL("{1} regarde fixement vers le bas."),
      _INTL("{1} renifle autour de lui."),
      _INTL("{1} est profondément concentré."),
      _INTL("{1} a fait face à {2} et a hoché la tête."),
      _INTL("{1} fixe intensément les yeux de {2}."),
      _INTL("{1} observe les environs."),
      _INTL("{1} se concentre avec un regard perçant !"),
      _INTL("{1} regarde autour de lui sans vraiment prêter attention."),
      _INTL("{1} a bâillé très fort !"),
      _INTL("{1} se détend confortablement."),
      _INTL("{1} concentre son attention sur {2}."),
      _INTL("{1} fixe intensément le vide."),
      _INTL("{1} se concentre."),
      _INTL("{1} a fait face à {2} et a hoché la tête."),
      _INTL("{1} regarde les empreintes de pas de {2}."),
      _INTL("{1} semble vouloir jouer et fixe {2} avec attente."),
      _INTL("{1} semble réfléchir profondément à quelque chose."),
      _INTL("{1} ne fait pas attention à {2}... il semble penser à autre chose."),
      _INTL("{1} semble très sérieux."),
      _INTL("{1} semble désintéressé."),
      _INTL("L'esprit de {1} semble ailleurs."),
      _INTL("{1} semble observer les environs plutôt que {2}."),
      _INTL("{1} a l'air un peu ennuyé."),
      _INTL("{1} a une expression très intense."),
      _INTL("{1} fixe le lointain."),
      _INTL("{1} semble examiner attentivement le visage de {2}."),
      _INTL("{1} semble essayer de communiquer avec ses yeux."),
      _INTL("... {1} semble avoir éternué !"),
      _INTL("... {1} a remarqué que les chaussures de {2} sont un peu sales."),
      _INTL("{1} a dû manger quelque chose d'étrange, il fait une drôle de tête..."),
      _INTL("{1} semble sentir quelque chose de bon."),
      _INTL("{1} a remarqué que le sac de {2} a un peu de saleté..."),
      _INTL("...... ...... ...... ...... ...... ...... ...... ...... ...... ...... ...... {1} a hoché la tête en silence !")
    ]
    value = rand(messages.length)
    # Special move route to go along with some of the dialogue
    case value
    when 1, 5, 7, 20, 21
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 35])
      FollowingPkmn.move_route([
        PBMoveRoute::TURN_RIGHT,
        PBMoveRoute::WAIT, 10,
        PBMoveRoute::TURN_UP,
        PBMoveRoute::WAIT, 10,
        PBMoveRoute::TURN_LEFT,
        PBMoveRoute::WAIT, 10,
        PBMoveRoute::TURN_DOWN
      ])
    end
    pbMessage(_INTL(messages[value], pkmn.name, $player.name))
    next true
  end
})
#-------------------------------------------------------------------------------
# All dialogues with the Happy animation
#-------------------------------------------------------------------------------
EventHandlers.add(:following_pkmn_talk, :happy_generic, proc { |pkmn, random_val|
  if random_val == 3
    FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_HAPPY)
    pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
    messages = [
      _INTL("{1} a commencé à pousser {2}."),
      _INTL("{1} a l'air très heureux."),
      _INTL("{1} s'est blotti joyeusement contre {2}."),
      _INTL("{1} est tellement heureux qu'il ne peut pas rester immobile."),
      _INTL("{1} a l'air de vouloir mener la marche !"),
      _INTL("{1} suit avec joie."),
      _INTL("{1} semble ravi de marcher avec {2} !"),
      _INTL("{1} déborde de vitalité."),
      _INTL("{1} a l'air très heureux."),
      _INTL("{1} a fait un effort supplémentaire pour {2} !"),
      _INTL("{1} renifle les odeurs de l'air environnant."),
      _INTL("{1} saute de joie !"),
      _INTL("{1} se sent toujours aussi bien !"),
      _INTL("{1} étire son corps et se détend."),
      _INTL("{1} fait de son mieux pour suivre {2}."),
      _INTL("{1} se blottit joyeusement contre {2} !"),
      _INTL("{1} déborde d'énergie !"),
      _INTL("{1} est tellement heureux qu'il ne peut pas rester immobile !"),
      _INTL("{1} se promène en écoutant les différents sons."),
      _INTL("{1} adresse un regard et un sourire joyeux à {2}."),
      _INTL("{1} commence à respirer fort par le nez sous l'excitation !"),
      _INTL("{1} tremble d'impatience !"),
      _INTL("{1} est si heureux qu'il s'est mis à rouler sur lui-même."),
      _INTL("{1} semble ravi de l'attention de {2}."),
      _INTL("{1} semble très heureux que {2} s'intéresse à lui !"),
      _INTL("{1} a commencé à se tortiller de tout son corps sous l'excitation !"),
      _INTL("On dirait que {1} a du mal à s'empêcher de faire un câlin à {2} !"),
      _INTL("{1} reste près des pieds de {2}.")
    ]
    value = rand(messages.length)
    # Special move route to go along with some of the dialogue
    case value
    when 3
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 45])
      FollowingPkmn.move_route([
        PBMoveRoute::TURN_RIGHT,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_UP,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_LEFT,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_DOWN,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::JUMP, 0, 0,
        PBMoveRoute::WAIT, 10,
        PBMoveRoute::JUMP, 0, 0
      ])
    when 11, 16, 17, 24
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 40])
      FollowingPkmn.move_route([
        PBMoveRoute::JUMP, 0, 0,
        PBMoveRoute::WAIT, 10,
        PBMoveRoute::JUMP, 0, 0,
        PBMoveRoute::WAIT, 10,
        PBMoveRoute::JUMP, 0, 0
      ])
    end
    pbMessage(_INTL(messages[value], pkmn.name, $player.name))
    next true
  end
})
#-------------------------------------------------------------------------------
# All dialogues with the Heart animation
#-------------------------------------------------------------------------------
EventHandlers.add(:following_pkmn_talk, :heart_generic, proc { |pkmn, random_val|
  if random_val == 4
    FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_HEART)
    pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
    messages = [
      _INTL("{1} s'est soudain mis à marcher plus près de {2}."),
      _INTL("Waouh ! {1} a soudain fait un câlin à {2}."),
      _INTL("{1} se frotte contre {2}."),
      _INTL("{1} reste près de {2}."),
      _INTL("{1} a rougi."),
      _INTL("{1} adore passer du temps avec {2} !"),
      _INTL("{1} est soudain devenu joueur !"),
      _INTL("{1} se frotte contre les jambes de {2} !"),
      _INTL("{1} regarde {2} avec adoration !"),
      _INTL("{1} semble vouloir de l'affection de la part de {2}."),
      _INTL("{1} semble vouloir de l'attention de la part de {2}."),
      _INTL("{1} semble heureux de voyager avec {2}."),
      _INTL("{1} semble éprouver de l'affection pour {2}."),
      _INTL("{1} regarde {2} avec des yeux pleins d'amour."),
      _INTL("{1} a l'air de vouloir une friandise de la part de {2}."),
      _INTL("{1} a l'air de vouloir que {2} le caresse !"),
      _INTL("{1} se frotte affectueusement contre {2}."),
      _INTL("{1} donne un petit coup de tête contre la main de {2}."),
      _INTL("{1} se roule et regarde {2} avec attente."),
      _INTL("{1} regarde {2} avec des yeux confiants."),
      _INTL("{1} semble supplier {2} pour un peu d'affection !"),
      _INTL("{1} a imité {2} !")
    ]
    value = rand(messages.length)
    case value
    when 1, 6,
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 10])
      FollowingPkmn.move_route([
        PBMoveRoute::JUMP, 0, 0
      ])
    end
    pbMessage(_INTL(messages[value], pkmn.name, $player.name))
    next true
  end
})
#-------------------------------------------------------------------------------
# All dialogues with no animation
#-------------------------------------------------------------------------------
EventHandlers.add(:following_pkmn_talk, :generic,  proc { |pkmn, random_val|
  if random_val == 5
    messages = [
      _INTL("{1} a tourné sur lui-même !"),
      _INTL("{1} a poussé un cri de guerre."),
      _INTL("{1} est aux aguets !"),
      _INTL("{1} attend patiemment."),
      _INTL("{1} regarde autour de lui avec agitation."),
      _INTL("{1} se promène."),
      _INTL("{1} a bâillé bruyamment !"),
      _INTL("{1} gratte le sol autour des pieds de {2}."),
      _INTL("{1} regarde {2} en souriant."),
      _INTL("{1} fixe intensément le lointain."),
      _INTL("{1} suit le rythme de {2}."),
      _INTL("{1} a l'air satisfait de lui-même."),
      _INTL("{1} tient toujours bon !"),
      _INTL("{1} marche en synchronisation avec {2}."),
      _INTL("{1} s'est mis à tourner en rond."),
      _INTL("{1} regarde {2} avec anticipation."),
      _INTL("{1} est tombé et a l'air un peu gêné."),
      _INTL("{1} attend de voir ce que {2} va faire."),
      _INTL("{1} observe calmement {2}."),
      _INTL("{1} cherche un signe de {2}."),
      _INTL("{1} reste en place, attendant que {2} fasse un mouvement."),
      _INTL("{1} s'est assis docilement aux pieds de {2}."),
      _INTL("{1} a sursauté !"),
      _INTL("{1} a légèrement sursauté !")
    ]
    value = rand(messages.length)
    # Special move route to go along with some of the dialogue
    case value
    when 0
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 15])
      FollowingPkmn.move_route([
        PBMoveRoute::TURN_RIGHT,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_UP,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_LEFT,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_DOWN
      ])
    when 2, 4
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 35])
      FollowingPkmn.move_route([
        PBMoveRoute::TURN_RIGHT,
        PBMoveRoute::WAIT, 10,
        PBMoveRoute::TURN_UP,
        PBMoveRoute::WAIT, 10,
        PBMoveRoute::TURN_LEFT,
        PBMoveRoute::WAIT, 10,
        PBMoveRoute::TURN_DOWN
      ])
    when 14
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 50])
      FollowingPkmn.move_route([
        PBMoveRoute::TURN_RIGHT,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_UP,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_LEFT,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_DOWN,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_RIGHT,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_UP,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_LEFT,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_DOWN,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_RIGHT,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_UP,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_LEFT,
        PBMoveRoute::WAIT, 4,
        PBMoveRoute::TURN_DOWN
      ])
    when 22, 23
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 10])
      FollowingPkmn.move_route([
        PBMoveRoute::JUMP, 0, 0
      ])
    end
    pbMessage(_INTL(messages[value], pkmn.name, $player.name))
    next true
  end
})
#-------------------------------------------------------------------------------
