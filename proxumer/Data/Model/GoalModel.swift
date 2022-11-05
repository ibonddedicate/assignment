//
//  GoalModel.swift
//  proxumer
//
//  Created by Macbook-BOIT on 4/11/2565 BE.
//

import Foundation
import UIKit

struct GoalModel {
  var icon: UIImage
  var title: String
  var remainingDays: Int
  var currentAmount: Int
  var goalAmount: Int
  
  init?(icon: UIImage, title: String, remainingDays: Int, currentAmount: Int, goalAmount: Int) {
    self.icon = icon
    self.title = title
    self.remainingDays = remainingDays
    self.currentAmount = currentAmount
    self.goalAmount = goalAmount
    }
  
  init(){
    self.icon = UIImage()
    self.title = ""
    self.remainingDays = 0
    self.currentAmount = 0
    self.goalAmount = 0
  }
}
