//
//  GoalViewModel.swift
//  proxumer
//
//  Created by Macbook-BOIT on 4/11/2565 BE.
//

import Foundation
import UIKit

protocol GoalProtocolInput {
  func setGoalName(name: String)
  func setTotalAmount(amount: Int)
  func setDate(dateRemaining: Date)
  func setCurrentAmount(amount: Int)
  func setSelected(selected: Int)
}

protocol GoalProtocolOutput {
  func getNumberOfRows() -> Int
  func getCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
  func getSubmittedGoal() -> GoalModel
  func getValidation() -> Bool
}

protocol GoalProtocol: GoalProtocolInput, GoalProtocolOutput {
  var input: GoalProtocolInput { get }
  var output: GoalProtocolOutput { get }
}

class GoalViewModel: GoalProtocol {
  var input: GoalProtocolInput { return self }
  var output: GoalProtocolOutput { return self }
  var goalInfo: GoalModel = GoalModel()
  var selected: Int?
  var mockChoice = [ChoiceModel(icon: UIImage(named: "luggage") ?? UIImage(),
                                title: "Travel"),
                    ChoiceModel(icon: UIImage(named: "education") ?? UIImage(),
                                title: "Education"),
                    ChoiceModel(icon: UIImage(named: "graph") ?? UIImage(),
                                title: "Invest"),
                    ChoiceModel(icon: UIImage(named: "clothes") ?? UIImage(),
                                title: "Clothing"),
                    ChoiceModel(icon: UIImage(named: "vehicle") ?? UIImage(),
                                title: "Vehicle")]
  init() {}
}

extension GoalViewModel: GoalProtocolInput {
  func setSelected(selected: Int) {
    goalInfo.icon = mockChoice[selected].icon
    self.selected = selected
  }
  
  func setGoalName(name: String) {
    goalInfo.title = name
  }
  
  func setTotalAmount(amount: Int) {
    goalInfo.goalAmount = amount
  }
  
  func setDate(dateRemaining: Date) {
    let today = Date.now
    let diff = (Calendar.current.dateComponents([.day], from: today, to: dateRemaining).day ?? 0) + 1
    goalInfo.remainingDays = diff
  }
  
  func setCurrentAmount(amount: Int) {
    goalInfo.currentAmount = amount
  }
}

extension GoalViewModel: GoalProtocolOutput {
  func getNumberOfRows() -> Int {
    return mockChoice.count
  }
  
  func getCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoalTypeCollectionViewCell.identifier, for: indexPath)
            as? GoalTypeCollectionViewCell else { return UICollectionViewCell() }
    let select = self.selected == indexPath.row ? true : false
    cell.config(data: mockChoice[indexPath.row], selected: select)
    return cell
  }
  
  func getSubmittedGoal() -> GoalModel {
    return goalInfo
  }
  
  func getValidation() -> Bool {
    if goalInfo.icon != UIImage() && goalInfo.title != "" && goalInfo.goalAmount != 0 && goalInfo.currentAmount != 0 && goalInfo.remainingDays != 0 {
      return true
    } else {
      return false
    }
  }
}
