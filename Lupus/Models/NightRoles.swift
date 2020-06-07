//
//  WolfRoles.swift
//  Lupus
//
//  Created by Riccardo Cipolleschi on 07/06/2020.
//

import Foundation

extension Models {
  struct Wolf: Role {
    var kind: Models.RoleKind { return .wolf }

    var aura: Models.Aura { return .evil }

    var powerDescription: String {
      return """
      During the first night, they open their eyes and acknowledge each others. From now on, the wolves knows each other.
      If the possessed is in play, she is asked to raise her hand: the wolves will know her, but she won't know them.
      During all the other nights, they woke up and they decide a person to kill.
      """
    }
  }

  struct Possessed: Role, Vampirable {
    var kind: Models.RoleKind { return .possessed }

    var aura: Models.Aura {
      return isMinorVampire ? .evil : .good
    }

    var powerDescription: String {
      return """
      During the first night, the master asks her to raise her hand, so that the wolves acknowledge who she is.
      After that she has no special power.
      """
    }

    var isMinorVampire: Bool = false
  }

  struct Vampire: Role {
    var kind: Models.RoleKind { return .vampire }

    var aura: Models.Aura {
      return .evil
    }

    var powerDescription: String {
      return """
      During the night, she chooses another person in the village.
      If that person is common villager, she becomes a lesser vampire. From now on, she has evil aura and loses all her powers.
      If the person is a wolf, then the Master Vampire will die that night.
      If the choosen person is a Mystic, nothing will happen.
      """
    }
  }
}
