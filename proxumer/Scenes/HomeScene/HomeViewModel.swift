//
//  HomeViewModel.swift
//  proxumer
//
//  Created by Macbook-BOIT on 4/11/2565 BE.
//

import Foundation
import UIKit

enum homeCellTypes {
  case goals
  case offers
  case suggests
}

protocol HomeProtocolInput {
  func addGoal(goal: GoalModel)
}

protocol HomeProtocolOutput {
  func getNumberOfRows() -> Int
  func getCell(viewController: UIViewController, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

protocol HomeProtocol: HomeProtocolInput, HomeProtocolOutput {
  var input: HomeProtocolInput { get }
  var output: HomeProtocolOutput { get }
}

class HomeViewModel: HomeProtocol {
  var input: HomeProtocolInput { return self }
  var output: HomeProtocolOutput { return self }
  
  var mockGoals = [GoalModel(icon: UIImage(named: "luggage") ?? UIImage(),
                             title: "ไปเที่ยวญี่ปุ่น",
                             remainingDays: 45,
                             currentAmount: 14200,
                             goalAmount: 20000),
                   GoalModel(icon: UIImage(named: "graph") ?? UIImage(),
                             title: "ซื้อกองทุนรวม",
                             remainingDays: 20,
                             currentAmount: 2600,
                             goalAmount: 6000),
                   GoalModel(icon: UIImage(named: "luggage") ?? UIImage(),
                             title: "ไปทะเล",
                             remainingDays: 37,
                             currentAmount: 8000,
                             goalAmount: 9000)]
  let mockOffers = [UIImage(named: "offer1") ?? UIImage(),
                    UIImage(named: "offer2") ?? UIImage(),
                    UIImage(named: "offer3") ?? UIImage()]
  let mockSuggested = [UIImage(named: "suggest1") ?? UIImage(),
                       UIImage(named: "suggest2") ?? UIImage(),
                       UIImage(named: "suggest3") ?? UIImage()]
  
  let mockCellTypes:[homeCellTypes] = [.goals,.offers,.suggests]
  
  init() {}
  
}

extension HomeViewModel: HomeProtocolInput {
  func addGoal(goal: GoalModel) {
    //mockGoals.append(goal)
    mockGoals.insert(goal, at: 0)
  }
}

extension HomeViewModel: HomeProtocolOutput {
  public func getNumberOfRows() -> Int {
    return mockCellTypes.count
  }
  
  public func getCell(viewController: UIViewController, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
    switch mockCellTypes[indexPath.row] {
    case .goals:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath)
              as? HomeTableViewCell else { return UITableViewCell() }
      cell.delegate = viewController as? HomeTableViewCellDelegate
      cell.config(data: mockGoals)
      return cell
    case .offers:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: BannersTableViewCell.identifier, for: indexPath)
              as? BannersTableViewCell else { return UITableViewCell() }
      cell.config(title: "Best Offers", data: mockOffers)
      return cell
    case .suggests:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: BannersTableViewCell.identifier, for: indexPath)
              as? BannersTableViewCell else { return UITableViewCell() }
      cell.config(title: "Suggested for you", data: mockSuggested)
      return cell
    }
  }
}
