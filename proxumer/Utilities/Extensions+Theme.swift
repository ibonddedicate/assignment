//
//  Extensions.swift
//  proxumer
//
//  Created by Macbook-BOIT on 4/11/2565 BE.
//

import Foundation
import UIKit

enum Edges {
  case top
  case bottom
  case all
  case none
}

extension UIView {
  func setRounded() {
    layer.cornerRadius = frame.size.width / 2
    clipsToBounds = true
  }
  
  func setCornerRadius(radius: CGFloat = 8.0) {
    layer.cornerRadius = radius
    clipsToBounds = true
  }
  
  func dropShadow(edge: Edges, shadowSpace: CGFloat = 8)    {
    var sizeOffset:CGSize = CGSize.zero
    switch edge {
    case .top: sizeOffset = CGSize(width: 0, height: -shadowSpace)
    case .bottom: sizeOffset = CGSize(width: 0, height: shadowSpace)
    case .all: sizeOffset = CGSize(width: 0, height: 0)
    case .none: sizeOffset = CGSize.zero
    }
    
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOpacity = 0.25
    self.layer.shadowOffset = sizeOffset
    self.layer.shadowRadius = 5.0
    self.layer.masksToBounds = false
    
    if edge != .all {
      self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }
  }
}

enum FontStyle {
  case xLargeWhite
  case largeWhite
  case largeBlack
  case mediumRed
  case mediumBlack
  case mediumWhite
  case smallRed
  case smallGreen
  case smallBlack
}

extension UILabel {
  func setStyle(_ style: FontStyle) {
    switch style {
    case .xLargeWhite:
      font = UIFont.extraLarge
      textColor = UIColor.white
    case .largeWhite:
      font = UIFont.large
      textColor = UIColor.white
    case .largeBlack:
      font = UIFont.large
      textColor = UIColor.proxumerBlack
    case .mediumRed:
      font = UIFont.medium
      textColor = UIColor.proxumerRed
    case .mediumBlack:
      font = UIFont.medium
      textColor = UIColor.proxumerBlack
    case .mediumWhite:
      font = UIFont.medium
      textColor = UIColor.white
    case .smallRed:
      font = UIFont.small
      textColor = UIColor.proxumerRed
    case .smallGreen:
      font = UIFont.small
      textColor = UIColor.proxumerGreen
    case .smallBlack:
      font = UIFont.small
      textColor = UIColor.proxumerBlack
    }
  }
  
  func setSpannedFont(fullText: String, changeText: String, font: UIFont) {
    let strNumber: NSString = fullText as NSString
    let range = (strNumber).range(of: changeText, options: .caseInsensitive)
    let attribute = NSMutableAttributedString.init(string: fullText)
    attribute.addAttribute(NSAttributedString.Key.font, value: font, range: range)
    attributedText = attribute
  }
}

extension UIFont {
  static var extraLarge: UIFont {
    return UIFont(name: "Kanit-Medium", size: 30) ?? UIFont()
  }
  static var large: UIFont {
    return UIFont(name: "Kanit-Regular", size: 24) ?? UIFont()
  }
  static var medium: UIFont {
    return UIFont(name: "Kanit-Regular", size: 16) ?? UIFont()
  }
  static var small: UIFont {
    return UIFont(name: "Kanit-Regular", size: 12) ?? UIFont()
  }
}

extension UIColor {
  static var proxumerRed: UIColor {
    return UIColor(red: 201/255, green: 93/255, blue: 72/255, alpha: 1)
  }
  
  static var proxumerGreen: UIColor {
    return UIColor(red: 0/255, green: 122/255, blue: 32/255, alpha: 1)
  }
  
  static var proxumerYellow: UIColor {
    return UIColor(red: 229/255, green: 165/255, blue: 41/255, alpha: 1)
  }
  
  static var proxumerBlack: UIColor {
    return UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
  }
}

extension UIButton {
  func makeProxumerButton() {
    setCornerRadius()
    backgroundColor = UIColor.proxumerRed
    titleLabel?.setStyle(FontStyle.largeWhite)
    tintColor = .white
  }
}

extension Int {
  func addSeperator() -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter.string(from: self as NSNumber) ?? ""
  }
}
