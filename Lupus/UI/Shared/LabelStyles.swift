//
//  LabelStyles.swift
//  Lupus
//
//  Created by Riccardo Cipolleschi on 09/05/2020.
//

import Foundation
import UIKit
import BonMot

extension Style {
  static func styleSmallText(_ label: UILabel, text: String?, centered: Bool = true) {
    label.numberOfLines = 0
    label.attributedText = text?.styled(with: Style.mainStyle)
    label.textAlignment = centered ? .center : .left
  }

  static func styleBigText(_ label: UILabel, text: String?) {
    label.numberOfLines = 1
    label.attributedText = text?.styled(with: Style.bigStyle)
    label.textAlignment = .center
  }
}
