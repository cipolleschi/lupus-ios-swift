//
//  CreateGameVC.swift
//  Lupus
//
//  Created by Riccardo Cipolleschi on 09/05/2020.
//

import Foundation
import Tempura

class CreateGameVC: ViewController<CreateGameView> {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    if self.isMovingFromParent {
      self.dispatch(GameLogic.RemoveGame())
    }
  }

  @objc func backButtonTapped(_ control: UIControl) {

  }
}
