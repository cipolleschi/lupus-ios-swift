//
//  CreateTimerVC.swift
//  ProgrammableTimer
//
//  Created by Riccardo Cipolleschi on 13/04/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import UIKit
import Tempura
import Katana

class StartMenuNC: UINavigationController {
  public var store: PartialStore<AppState>

  init(store: PartialStore<AppState>) {
    self.store = store
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

class StartMenuVC: ViewController<StartMenuView> {
  override func setupInteraction() {
    self.rootView.userDidTapStartGame = {
      self.dispatch(GameLogic.CreateNewGame())
    }

    self.rootView.userDidTapJoinGame = {
      self.dispatch(Show(Screen.joinGame, animated: true))
    }
  }
}

