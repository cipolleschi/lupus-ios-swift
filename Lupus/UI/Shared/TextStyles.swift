//
//  TextStyles.swift
//  Lupus
//
//  Created by Riccardo Cipolleschi on 08/05/2020.
//

import Foundation
import BonMot

enum Style {}

extension Style {
  static let mainColor = UIColor.black
  static let mainDisabledColor = UIColor.black.withAlphaComponent(0.7)

  static var mainStyle: StringStyle {
    let style = StringStyle([
      .font(UIFont.systemFont(ofSize: 16)),
      .color(Style.mainColor)
    ])
    return style
  }

  static var mainDisabledStyle: StringStyle {
    let style = StringStyle([
      .font(UIFont.systemFont(ofSize: 16)),
      .color(Style.mainDisabledColor)
    ])
    return style
  }

  static var bigStyle: StringStyle {
    let style = StringStyle([
      .font(UIFont.systemFont(ofSize: 24)),
      .color(Style.mainColor)
    ])
    return style
  }
}
