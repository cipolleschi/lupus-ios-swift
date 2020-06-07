//
//  TownRoles.swift
//  Lupus
//
//  Created by Riccardo Cipolleschi on 07/06/2020.
//

import Foundation
extension Models {

  struct Mayor: Role, Vampirable {
    var kind: Models.RoleKind { return .mayor }
    var aura: Models.Aura { return self.isMinorVampire ? .evil : .good }
    var isMinorVampire: Bool = false
    var powerDescription: String {
      return """
      The Mayor vote counts 4 during each votation (both the ballots and the standard one).
      """
    }
  }

  struct Bartender: Role, Vampirable {
    var kind: Models.RoleKind { return .bartender }
    var aura: Models.Aura { return self.isMinorVampire ? .evil : .good }
    var isMinorVampire: Bool = false
    var powerDescription: String {
      return """
      She has no active power. However, if she is still in play at the beginning of the day and the Seer has found an evil aura, the master will tell to the village that an evil aura has been discovered during the night.
      """
    }
  }

  struct Priest: Role, Vampirable {
    var kind: Models.RoleKind { return .priest }
    var aura: Models.Aura { return self.isMinorVampire ? .evil : .good }
    var isMinorVampire: Bool = false
    var powerDescription: String {
      return """
      The first night, she opens her eyes and acknowledge who the sinner is
      """
    }
  }

  struct Sinner: Role, Vampirable {
    var kind: Models.RoleKind { return .sinner }
    var aura: Models.Aura { return .evil }
    var isMinorVampire: Bool = false
    var powerDescription: String {
      return """
      The first night, she raises her hand so that the priest can acknowledge her. However, the Sinner won't know who the priest is.
      """
    }
  }

  struct BoccaDiRose: Role, Vampirable {
    var kind: Models.RoleKind { return .boccaDiRose}
    var aura: Models.Aura { return .evil }
    var isMinorVampire: Bool = false
    var powerDescription: String {
      return """
      She receives half of the votes from every votation from the village.
      """
    }
  }

  struct Orator: Role, Vampirable {
    var kind: Models.RoleKind { return .orator }
    var aura: Models.Aura { return self.isMinorVampire ? .evil : .good }
    var isMinorVampire: Bool = false
    var powerDescription: String {
      return """
      During each ballot, the Orator can protect another person of the village. That person cannot die at the ballot.
      When the master asks who wants to vote for that person, the Orator can raise both her hands to protect her.
      """
    }
  }

  struct Lawyer: Role, Vampirable {
    var kind: Models.RoleKind { return .lawyer }
    var aura: Models.Aura { return self.isMinorVampire ? .evil : .good }
    var isMinorVampire: Bool = false
    var powerDescription: String {
      return """
      During each daily votation, the Lawyer can protect another person of the village. That person cannot go to the ballot.
      When the master asks who wants to vote for that person, the Lawyer can raise both her hands to protect her.
      """
    }
  }

  struct Hero: Role, Vampirable {
    var kind: Models.RoleKind { return .hero }
    var aura: Models.Aura { return self.isMinorVampire ? .evil : .good }
    var isMinorVampire: Bool = false
    var powerDescription: String {
      return """
      She does not know that she is actually the hero. At the beginning, the master will tell her that she is a normal villager.
      However, when the wolves try to kill her, one of the wolves will die as well.
      She dies in the process of killing the wolf.
      """
    }
  }

  struct Progeny: Role, Vampirable {
    var kind: Models.RoleKind { return .progeny }
    var aura: Models.Aura { return self.isMinorVampire ? .evil : .good }
    var isMinorVampire: Bool = false
    var powerDescription: String {
      return """
      She does not know that she is actually the progeny. At the beginning, the master will tell her that she is a normal villager.
      However, when the wolves try to kill her, the master actually awake her and she becames a wolf as well.
      From now on, her aura is evil her faction changes to the Wolves and her Win Condition changes to the same of the wolves.
      """
    }
  }

  struct Hermit: Role, Vampirable {
    var kind: Models.RoleKind { return .hermit }
    var aura: Models.Aura { return .good }
    var isMinorVampire: Bool = false
    var powerDescription: String {
      return """
      The creature of the night cannot hurt her: she cannot be transformed into a vampire nor can be killed by the wolves.
      """
    }
  }

  struct Merchant: Role, Vampirable {
    var kind: Models.RoleKind { return .merchant }
    var aura: Models.Aura { return self.isMinorVampire ? .evil : .good }
    var isMinorVampire: Bool = false
    var powerDescription: String {
      return """
      The Merchant can vote any number of times during the votations. Her votes always count as one.
      """
    }
  }
}
