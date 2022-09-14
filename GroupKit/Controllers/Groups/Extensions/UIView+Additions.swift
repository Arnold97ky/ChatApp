//
//  UIView+Additions.swift
//  GroupKit
//
//  Created by Consultant on 8/26/22.
//

import UIKit

extension UIView {
  func smoothRoundCorners(to radius: CGFloat) {
    let maskLayer = CAShapeLayer()
    maskLayer.path = UIBezierPath(
      roundedRect: bounds,
      cornerRadius: radius
    ).cgPath

    layer.mask = maskLayer
  }
}
