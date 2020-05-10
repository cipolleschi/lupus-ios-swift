//
//  SharedLogic.swift
//  Lupus
//
//  Created by Riccardo Cipolleschi on 10/05/2020.
//

import Foundation
import UIKit
import Hydra
import Tempura

enum SharedLogic {
  struct PresentAlert: AppSideEffect {
    let alertContext: AlertContext
    func sideEffect(_ context: AppSideEffectContext) throws {
      _ = try await(context.dispatch(Show(Screen.alert, animated: true, context: self.alertContext)))
    }
  }

  struct AlertContext {
    let title: String
    let message: String
    let actions: [UIAlertAction]
  }
}
