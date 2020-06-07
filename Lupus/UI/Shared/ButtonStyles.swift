//
//  ButtonStyles.swift
//  Lupus
//
//  Created by Riccardo Cipolleschi on 08/05/2020.
//

import Foundation
import BonMot

extension Style {

  static let buttonHeight: CGFloat = 50

  static func styleMainButton(_ button: UIButton, text: String) {
    let style = Style.mainStyle
    let disabledStyle = Style.mainDisabledStyle

    button.backgroundColor = .clear
    button.setAttributedTitle(text.styled(with: style), for: .normal)
    button.setAttributedTitle(text.styled(with: disabledStyle), for: .disabled)
    button.setAttributedTitle(text.styled(with: disabledStyle), for: .highlighted)

    button.layer.borderWidth = 1
    button.layer.borderColor = !button.isEnabled || button.isHighlighted
      ? Style.mainDisabledColor.cgColor
      : Style.mainColor.cgColor
  }
}
