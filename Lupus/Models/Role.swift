//
//  Role.swift
//  Lupus
//
//  Created by Riccardo Cipolleschi on 07/06/2020.
//

import Foundation

extension Models {
  enum Aura {
    case good
    case evil
  }

  enum RoleKind: String, Codable {
    // wolves
    case wolf = "Wolf"
    case possessed = "Possessed"
    // vampire
    case vampire = "Vampire"
    // mystics
    case seer = "Seer"
    case medium = "Medium"
    case `guard` = "Guard"
    case healer = "Healer"
    // town
    case mayor = "Mayor"
    case bartender = "Bartender"
    case priest = "Priest"
    case sinner = "Sinner"
    case boccaDiRose = "Bocca di Rose"
    case orator = "Orator"
    case lawyer = "Lawyer"
    case hero = "Hero"
    case progeny = "Progeny"
    case hermit = "Hermit"
    case merchant = "Merchant"
    case villager = "Villager"

    var displayName: String {
      return self.rawValue
    }

    static var villageRoles: [RoleKind] {
       return [
        .mayor,
        .bartender,
        .priest,
        .sinner,
        .boccaDiRose,
        .orator,
        .lawyer,
        .hero,
        .progeny,
        .hermit,
        .merchant
      ]
    }

    static var vampirables: [RoleKind] {
      return [
        .possessed,
        .mayor,
        .bartender,
        .priest,
        .sinner,
        .boccaDiRose,
        .orator,
        .lawyer,
        .hero,
        .progeny,
        .hermit,
        .merchant,
        .villager
      ]
    }

    static var mystics: [RoleKind] {
      return [
        .seer,
        .medium,
        .guard,
        .healer
      ]
    }

    var isMystic: Bool {
      return RoleKind.mystics.contains(self)
    }

    var canBecomeVampire: Bool {
      return RoleKind.vampirables.contains(self)
    }

    var aura: Aura {
      switch self {
      case .wolf:
        return .evil
      case .possessed:
        return .good
      case .vampire:
        return .evil
      case .seer:
        return .good
      case .medium:
        return .good
      case .guard:
        return .good
      case .healer:
        return .good
      case .mayor:
        return .good
      case .bartender:
        return .good
      case .priest:
        return .good
      case .sinner:
        return .evil
      case .boccaDiRose:
        return .evil
      case .orator:
        return .good
      case .lawyer:
        return .good
      case .hero:
        return .good
      case .progeny:
        return .good
      case .hermit:
        return .good
      case .merchant:
        return .good
      case .villager:
        return .good
      }
    }

    var powerDescription: String {
      switch self {
      case .wolf:
        return """
        During the first night, they open their eyes and acknowledge each others. From now on, the wolves knows each other.
        If the possessed is in play, she is asked to raise her hand: the wolves will know her, but she won't know them.
        During all the other nights, they woke up and they decide a person to kill.
        """
      case .possessed:
        return """
        During the first night, the master asks her to raise her hand, so that the wolves acknowledge who she is.
        After that she has no special power.
        """
      case .vampire:
        return """
        During the night, she chooses another person in the village.
        If that person is common villager, she becomes a lesser vampire. From now on, she has evil aura and loses all her powers.
        If the person is a wolf, then the Master Vampire will die that night.
        If the choosen person is a Mystic, nothing will happen.
        """
      case .seer:
        return """
        During the night, she can chose a person that is still in play.
        The master will tell her whether her aura is good or evil.
        """
      case .medium:
        return """
        During the night, she can chose a person that has been killed.
        The master will tell her whether her aura was good or evil.
        """
      case .guard:
        return """
        During the night, she can chose a person and protect her from the powers of the night.
        That person cannot be killed nor can be transformed into a vampire. The guard cannot protect herself.
        """
      case .healer:
        return """
        During the night, the master will tell her about all the people that died.
        Once per game, she can decide to save her from dying. The healer cannot heal herself.
        """
      case .mayor:
        return """
        The Mayor vote counts 4 during each votation (both the ballots and the standard one).
        """
      case .bartender:
        return """
        She has no active power. However, if she is still in play at the beginning of the day and the Seer has found an evil aura, the master will tell to the village that an evil aura has been discovered during the night.
        """
      case .priest:
        return """
        The first night, she opens her eyes and acknowledge who the sinner is
        """
      case .sinner:
        return """
        The first night, she raises her hand so that the priest can acknowledge her. However, the Sinner won't know who the priest is.
        """
      case .boccaDiRose:
        return """
        She receives half of the votes from every votation from the village.
        """
      case .orator:
        return """
        During each ballot, the Orator can protect another person of the village. That person cannot die at the ballot.
        When the master asks who wants to vote for that person, the Orator can raise both her hands to protect her.
        """
      case .lawyer:
        return """
        During each daily votation, the Lawyer can protect another person of the village. That person cannot go to the ballot.
        When the master asks who wants to vote for that person, the Lawyer can raise both her hands to protect her.
        """
      case .hero:
        return """
        She does not know that she is actually the hero. At the beginning, the master will tell her that she is a normal villager.
        However, when the wolves try to kill her, one of the wolves will die as well.
        She dies in the process of killing the wolf.
        """
      case .progeny:
        return """
        She does not know that she is actually the progeny. At the beginning, the master will tell her that she is a normal villager.
        However, when the wolves try to kill her, the master actually awake her and she becames a wolf as well.
        From now on, her aura is evil her faction changes to the Wolves and her Win Condition changes to the same of the wolves.
        """
      case .hermit:
        return """
        The creature of the night cannot hurt her: she cannot be transformed into a vampire nor can be killed by the wolves.
        """
      case .merchant:
        return """
        The Merchant can vote any number of times during the votations. Her votes always count as one.
        """
      case .villager:
        return """
        A commoner of the village, with no special powers.
        """
      }
    }
  }

  struct Role: JSONDictCodable {
    let kind: RoleKind
    var isVampire: Bool = false
    var aura: Aura {
      guard kind.canBecomeVampire else {
        return kind.aura
      }
      return self.isVampire ? .evil : self.kind.aura
    }

    init(kind: RoleKind) {
      self.kind = kind
    }
  }
}


