//
//  AppDelegate.swift
//  ProgrammableTimer
//
//  Created by Riccardo Cipolleschi on 13/04/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation
import UIKit
import Katana

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var store: Store<AppState, AppDependencies>!

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {


    // Configure the window
    let window = UIWindow()
    self.window = window
    self.window?.makeKeyAndVisible()

    // Create the katana store that will handle the initialization of the dependencies
    // and will receive all the dispatchables of the app
    self.store = Store<AppState, AppDependencies>(interceptors: [
      ObserverInterceptor.observe([
        .onNotification(UIResponder.keyboardWillShowNotification, [KeyboardLogic.KeyboardWillShow.self]),
        .onNotification(UIResponder.keyboardWillHideNotification, [KeyboardLogic.KeyboardWillHide.self]),
      ])
    ])

    // Navigate to the first screen of the app
    self.store?.dependencies?.navigator.start(
      using: self,
      in: self.window!,
      at: Screen.startMenu.rawValue
    )

    return true
  }


}

