#-------------------------------------------------------------------------------
# These are used to define what the Follower will say when spoken to under
# specific conditions like Status or Weather or Map names
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Amie Compatibility
#-------------------------------------------------------------------------------
if defined?(PkmnAR)
  EventHandlers.add(:following_pkmn_talk, :amie, proc { |_pkmn, _random_val|
    cmd = pbMessage(_INTL("What would you like to do?"), [
      _INTL("Play"),
      _INTL("Talk"),
      _INTL("Cancel")
    ])
    PkmnAR.show if cmd == 0
    next true if [0, 2].include?(cmd)
  })
end
#-------------------------------------------------------------------------------
# Special Dialogue when statused
#-------------------------------------------------------------------------------
EventHandlers.add(:following_pkmn_talk, :status, proc { |pkmn, _random_val|
  case pkmn.status
  when :POISON
    FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_POISON)
    pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
    pbMessage(_INTL("{1} tremblotte sous l'effet du poison...", pkmn.name))
  when :BURN
    FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_ANGRY)
    pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
    pbMessage(_INTL("{1} semble souffrir de sa brûlure.", pkmn.name))
  when :FROZEN
    FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_ELIPSES)
    pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
    pbMessage(_INTL("{1} se déplace maladroitement, comme si tous ses membres étaient gelés.", pkmn.name))
  when :SLEEP
    FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_ELIPSES)
    pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
    pbMessage(_INTL("{1} pourrait s'endormir d'une seconde à l'autre.", pkmn.name))
  when :PARALYSIS
    FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_ELIPSES)
    pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
    pbMessage(_INTL("{1} a l'air démangé par ses membres paralysés.", pkmn.name))
  end
  next true if pkmn.status != :NONE
})
#-------------------------------------------------------------------------------
# Specific message if the map has the Pokemon Lab metadata flag
#-------------------------------------------------------------------------------
EventHandlers.add(:following_pkmn_talk, :pokemon_lab, proc { |pkmn, _random_val|
  if $game_map.metadata&.has_flag?("PokemonLab")
    FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_ELIPSES)
    pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
    messages = [
	_INTL("{1} touche une sorte d'interrupteur."),
	_INTL("{1} a un câble dans la bouche !"),
	_INTL("{1} semble vouloir toucher la machinerie."),
    ]
    pbMessage(_INTL(messages.sample, pkmn.name, $player.name))
    next true
  end
})
#-------------------------------------------------------------------------------
# Specific message if the map name has the players name in it like the
# Player's House
#-------------------------------------------------------------------------------
EventHandlers.add(:following_pkmn_talk, :player_house, proc { |pkmn, _random_val|
  if $game_map.name.include?($player.name)
    FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_HAPPY)
    pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
    messages = [
	_INTL("{1} renifle partout dans la pièce."),
	_INTL("{1} a remarqué que l'oncler de {2} est à proximité."),
	_INTL("{1} semble vouloir se poser à la maison."),
    ]
    pbMessage(_INTL(messages.sample, pkmn.name, $player.name))
    next true
  end
})
#-------------------------------------------------------------------------------
# Specific message if the map has Pokecenter metadata flag
#-------------------------------------------------------------------------------
EventHandlers.add(:following_pkmn_talk, :pokemon_center, proc { |pkmn, _random_val|
  if $game_map.metadata&.has_flag?("PokeCenter")
    FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_HAPPY)
    pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
    messages = [
      _INTL("{1} semble heureux de voir l'infirmière."),
      _INTL("{1} a l'air d'aller un peu mieux rien qu'en étant au Centre Pokémon."),
      _INTL("{1} semble fasciné par les machines de soin."),
      _INTL("{1} a l'air de vouloir faire une sieste."),
      _INTL("{1} a lancé un petit cri de salut à l'infirmière."),
      _INTL("{1} observe {2} d'un regard espiègle."),
      _INTL("{1} semble parfaitement à l'aise."),
      _INTL("{1} s'est installé confortablement."),
      _INTL("{1} affiche une expression satisfaite."),
    ]
    pbMessage(_INTL(messages.sample, pkmn.name, $player.name))
    next true
  end
})
#-------------------------------------------------------------------------------
# Specific message if the map has the Gym metadata flag
#-------------------------------------------------------------------------------
EventHandlers.add(:following_pkmn_talk, :gym, proc { |pkmn, _random_val|
  if $game_map.metadata&.has_flag?("GymMap")
    FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_ANGRY)
    pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
    messages = [
      _INTL("{1} a hâte de combattre !"),
      _INTL("{1} regarde {2} avec une lueur de détermination dans les yeux."),
      _INTL("{1} essaie d'intimider les autres Dresseurs."),
      _INTL("{1} fait confiance à {2} pour élaborer une stratégie gagnante."),
      _INTL("{1} garde un œil sur le Champion d'Arène."),
      _INTL("{1} semble prêt à chercher la bagarre."),
      _INTL("{1} semble se préparer pour un grand affrontement !"),
      _INTL("{1} veut montrer à quel point il est fort !"),
      _INTL("{1} est en train de... s'échauffer ?"),
      _INTL("{1} grogne doucement, perdu dans ses pensées..."),
    ]
    pbMessage(_INTL(messages.sample, pkmn.name, $player.name))
    next true
  end
})
#-------------------------------------------------------------------------------
# Specific message when the weather is Storm. Pokemon of different types
# have different reactions to the weather.
#-------------------------------------------------------------------------------
EventHandlers.add(:following_pkmn_talk, :storm_weather, proc { |pkmn, _random_val|
  if :Storm == $game_screen.weather_type
    if pkmn.hasType?(:ELECTRIC)
      FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_HAPPY)
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
      messages = [
        _INTL("{1} fixe le ciel."),
        _INTL("L'orage semble rendre {1} enthousiaste."),
        _INTL("{1} a levé les yeux vers le ciel et a poussé un grand cri !"),
        _INTL("L'orage semble seulement donner encore plus d'énergie à {1} !"),
        _INTL("{1} lance joyeusement des décharges électriques en sautillant en rond !"),
        _INTL("La foudre ne dérange absolument pas {1}.")
      ]
    else
      FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_ELIPSES)
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
      messages = [
        _INTL("{1} fixe le ciel."),
        _INTL("L'orage semble rendre {1} un peu nerveux."),
        _INTL("La foudre a effrayé {1} !"),
        _INTL("La pluie ne semble pas vraiment déranger {1}."),
        _INTL("Le mauvais temps semble mettre {1} mal à l'aise."),
        _INTL("{1} a été effrayé par la foudre et s'est blotti contre {2} !"),
      ]
    end
    pbMessage(_INTL(messages.sample, pkmn.name, $player.name))
    next true
  end
})
#-------------------------------------------------------------------------------
# Specific message when the weather is Snowy. Pokemon of different types
# have different reactions to the weather.
#-------------------------------------------------------------------------------
EventHandlers.add(:following_pkmn_talk, :snow_weather, proc { |pkmn, _random_val|
  if :Snow == $game_screen.weather_type
    if pkmn.hasType?(:ICE)
      FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_HAPPY)
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
      messages = [
        _INTL("{1} regarde la neige tomber."),
        _INTL("{1} est ravi par la neige !"),
        _INTL("{1} contemple le ciel avec le sourire."),
        _INTL("La neige semble mettre {1} de bonne humeur."),
        _INTL("{1} est joyeux grâce au froid !")
      ]
    else
      FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_ELIPSES)
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
      messages = [
        _INTL("{1} essaie d'attraper les flocons de neige qui tombent."),
        _INTL("{1} veut attraper un flocon dans sa bouche."),
        _INTL("{1} semble fasciné par la neige."),
        _INTL("{1} claque des dents !"),
        _INTL("{1} se recroqueville légèrement à cause du froid...")
      ]
    end
    pbMessage(_INTL(messages.sample, pkmn.name, $player.name))
    next true
  end
})
#-------------------------------------------------------------------------------
# Specific message when the weather is Blizzard. Pokemon of different types
# have different reactions to the weather.
#-------------------------------------------------------------------------------
EventHandlers.add(:following_pkmn_talk, :blizzard_weather, proc { |pkmn, _random_val|
  if :Blizzard == $game_screen.weather_type
    if pkmn.hasType?(:ICE)
      FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_HAPPY)
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
      messages = [
        _INTL("{1} regarde la grêle tomber."),
        _INTL("{1} n'est pas du tout dérangé par la grêle."),
        _INTL("{1} contemple le ciel avec le sourire."),
        _INTL("La grêle semble mettre {1} de bonne humeur."),
        _INTL("{1} grignote un morceau de grêlon.")
      ]
    else
      FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_ANGRY)
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
      messages = [
        _INTL("{1} se fait bombarder par la grêle !"),
        _INTL("{1} veut éviter la grêle."),
        _INTL("La grêle frappe douloureusement {1}."),
        _INTL("{1} n'a pas l'air content."),
        _INTL("{1} tremble comme une feuille !")
      ]
    end
    pbMessage(_INTL(messages.sample, pkmn.name, $player.name))
    next true
  end
})
#-------------------------------------------------------------------------------
# Specific message when the weather is Sandstorm. Pokemon of different types
# have different reactions to the weather.
#-------------------------------------------------------------------------------
EventHandlers.add(:following_pkmn_talk, :sandstorm_weather, proc { |pkmn, _random_val|
  if :Sandstorm == $game_screen.weather_type
    if [:ROCK, :GROUND].any? { |type| pkmn.hasType?(type) }
      FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_HAPPY)
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
      messages = [
        _INTL("{1} est recouvert de sable."),
        _INTL("Le temps ne semble pas du tout déranger {1} !"),
        _INTL("Le sable ne peut pas ralentir {1} !"),
        _INTL("{1} apprécie ce temps.")
      ]
    elsif pkmn.hasType?(:STEEL)
      FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_ELIPSES)
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
      messages = [
        _INTL("{1} est recouvert de sable, mais cela ne semble pas le déranger."),
        _INTL("{1} ne semble pas gêné par la tempête de sable."),
        _INTL("Le sable ne ralentit pas {1}."),
        _INTL("{1} ne semble pas gêné par ce temps.")
      ]
    else
      FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_ANGRY)
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
      messages = [
        _INTL("{1} est couvert de sable..."),
        _INTL("{1} recrache une bouchée de sable !"),
        _INTL("{1} plisse les yeux à travers la tempête de sable."),
        _INTL("Le sable semble déranger {1}.")
      ]
    end
    pbMessage(_INTL(messages.sample, pkmn.name, $player.name))
    next true
  end
})
#-------------------------------------------------------------------------------
# Specific message if the map has the Forest metadata flag
#-------------------------------------------------------------------------------
EventHandlers.add(:following_pkmn_talk, :forest_map, proc { |pkmn, _random_val|
  if $game_map.metadata&.has_flag?("Forest")
    FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_MUSIC)
    pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
    if [:BUG, :GRASS].any? { |type| pkmn.hasType?(type) }
      messages = [
        _INTL("{1} semble très intéressé par les arbres."),
        _INTL("{1} semble apprécier le bourdonnement des Pokémon Insecte."),
        _INTL("{1} sautille avec agitation dans la forêt.")
      ]
    else
      messages = [
        _INTL("{1} semble très intéressé par les arbres."),
        _INTL("{1} semble apprécier le bourdonnement des Pokémon Insecte."),
        _INTL("{1} sautille avec agitation dans la forêt."),
        _INTL("{1} se promène en écoutant les différents sons."),
        _INTL("{1} grignote l'herbe."),
        _INTL("{1} se promène en profitant du paysage forestier."),
        _INTL("{1} s'amuse à arracher des brins d'herbe."),
        _INTL("{1} contemple la lumière qui filtre à travers les arbres."),
        _INTL("{1} joue avec une feuille !"),
        _INTL("{1} semble écouter le bruissement des feuilles."),
        _INTL("{1} reste parfaitement immobile, comme s'il imitait un arbre..."),
        _INTL("{1} s'est emmêlé dans les branches et a failli tomber !"),
        _INTL("{1} a été surpris lorsqu'une branche l'a frappé !")
      ]
    end
    pbMessage(_INTL(messages.sample, pkmn.name, $player.name))
    next true
  end
})
#-------------------------------------------------------------------------------
# Specific message when the weather is Rainy. Pokemon of different types
# have different reactions to the weather.
#-------------------------------------------------------------------------------
EventHandlers.add(:following_pkmn_talk, :rainy_weather, proc { |pkmn, _random_val|
  if [:Rain, :HeavyRain].include?($game_screen.weather_type)
    if pkmn.hasType?(:FIRE) || pkmn.hasType?(:GROUND) || pkmn.hasType?(:ROCK)
      FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_ANGRY)
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
      messages = [
        _INTL("{1} semble très contrarié par le temps."),
        _INTL("{1} frissonne..."),
        _INTL("{1} ne semble pas apprécier d'être complètement trempé..."),
        _INTL("{1} essaie sans cesse de se sécher en se secouant."),
        _INTL("{1} s'est rapproché de {2} pour se réconforter."),
        _INTL("{1} lève les yeux vers le ciel en faisant la grimace."),
        _INTL("{1} semble avoir du mal à bouger.")
      ]
    elsif pkmn.hasType?(:WATER) || pkmn.hasType?(:GRASS)
      FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_HAPPY)
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
      messages = [
        _INTL("{1} semble apprécier ce temps."),
        _INTL("{1} semble heureux qu'il pleuve !"),
        _INTL("{1} semble très surpris qu'il pleuve !"),
        _INTL("{1} a adressé un grand sourire à {2} !"),
        _INTL("{1} contemple les nuages de pluie."),
        _INTL("Les gouttes de pluie tombent sur {1}."),
        _INTL("{1} regarde le ciel, la bouche grande ouverte.")
      ]
    else
      FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_ELIPSES)
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
      messages = [
        _INTL("{1} fixe le ciel."),
        _INTL("{1} semble un peu surpris de voir la pluie."),
        _INTL("{1} essaie sans cesse de se secouer pour se sécher."),
        _INTL("La pluie ne semble pas vraiment déranger {1}."),
        _INTL("{1} joue dans une flaque d'eau !"),
        _INTL("{1} a glissé dans l'eau et a failli tomber !")
      ]
    end
    pbMessage(_INTL(messages.sample, pkmn.name, $player.name))
    next true
  end
})
#-------------------------------------------------------------------------------
# Specific message if the map has Beach metadata flag
#-------------------------------------------------------------------------------
EventHandlers.add(:following_pkmn_talk, :beach_map, proc { |pkmn, _random_val|
  if $game_map.metadata&.has_flag?("Beach")
    FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_HAPPY)
    pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
    messages = [
      _INTL("{1} semble apprécier le paysage."),
      _INTL("{1} semble aimer le son des vagues qui déplacent le sable."),
      _INTL("{1} a envie de nager !"),
      _INTL("{1} n'arrive presque pas à détourner le regard de l'océan."),
      _INTL("{1} contemple l'eau avec nostalgie."),
      _INTL("{1} essaie sans cesse de pousser {2} vers l'eau."),
      _INTL("{1} est excité à l'idée de voir la mer !"),
      _INTL("{1} regarde les vagues avec joie !"),
      _INTL("{1} joue dans le sable !"),
      _INTL("{1} observe les empreintes de pas de {2} dans le sable."),
      _INTL("{1} se roule dans le sable.")
    ]
    pbMessage(_INTL(messages.sample, pkmn.name, $player.name))
    next true
  end
})
#-------------------------------------------------------------------------------
# Specific message when the weather is Sunny. Pokemon of different types
# have different reactions to the weather.
#-------------------------------------------------------------------------------
EventHandlers.add(:following_pkmn_talk, :sunny_weather, proc { |pkmn, _random_val|
  if :Sun == $game_screen.weather_type
    if pkmn.hasType?(:GRASS)
      FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_HAPPY)
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
      messages = [
        _INTL("{1} semble heureux d'être dehors sous le soleil."),
        _INTL("{1} profite des rayons du soleil."),
        _INTL("La lumière du soleil ne semble pas du tout déranger {1}."),
        _INTL("{1} a envoyé un nuage de spores en forme d'anneau dans les airs !"),
        _INTL("{1} étire son corps et se détend au soleil."),
        _INTL("{1} dégage un parfum floral.")
      ]
    elsif pkmn.hasType?(:FIRE)
      FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_HAPPY)
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
      messages = [
        _INTL("{1} semble heureux de ce beau temps !"),
        _INTL("La lumière du soleil ne semble pas du tout déranger {1}."),
        _INTL("{1} semble ravi par le soleil !"),
        _INTL("{1} a soufflé une boule de feu."),
        _INTL("{1} crache du feu !"),
        _INTL("{1} est brûlant et joyeux !")
      ]
    elsif pkmn.hasType?(:DARK)
      FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_ANGRY)
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
      messages = [
        _INTL("{1} lance un regard noir vers le ciel."),
        _INTL("{1} semble personnellement offensé par le soleil."),
        _INTL("La lumière du soleil semble déranger {1}."),
        _INTL("{1} a l'air contrarié pour une raison inconnue."),
        _INTL("{1} essaie de rester dans l'ombre de {2}."),
        _INTL("{1} cherche constamment un abri contre le soleil.")
      ]
    else
      FollowingPkmn.animation(FollowingPkmn::ANIMATION_EMOTE_ELIPSES)
      pbMoveRoute($game_player, [PBMoveRoute::WAIT, 20])
      messages = [
        _INTL("{1} plisse les yeux sous le soleil éclatant."),
        _INTL("{1} commence à transpirer."),
        _INTL("{1} semble un peu mal à l'aise par ce temps."),
        _INTL("{1} a l'air un peu surchauffé."),
        _INTL("{1} semble avoir très chaud..."),
        _INTL("{1} a protégé sa vue de la lumière étincelante !")
      ]
    end    
    pbMessage(_INTL(messages.sample, pkmn.name, $player.name))
    next true
  end
})
#-------------------------------------------------------------------------------
