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

    button.backgroundColor = .clear
    button.setAttributedTitle(text.styled(with: style), for: .normal)
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor.black.cgColor
  }
}
