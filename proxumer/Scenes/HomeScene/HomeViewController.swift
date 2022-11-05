//
//  HomeViewController.swift
//  proxumer
//
//  Created by Macbook-BOIT on 3/11/2565 BE.
//

import UIKit

class HomeViewController: UIViewController {
  
  static public let viewName = "HomeView"
  static public let identifier = "HomeViewController"
  
  @IBOutlet weak var tableView: UITableView!
  private var viewModel: HomeViewModel? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    config(viewModel: HomeViewModel())
    setupUI()
    view.backgroundColor = UIColor.proxumerYellow
  }
  
  private func setupUI() {
    tableView.delegate = self
    tableView.dataSource = self
    registerCells()
    navigationController?.isNavigationBarHidden = true
  }
  
  private func registerCells() {
    tableView.register(UINib(nibName: HomeTableViewCell.nibName, bundle: .main),
                       forCellReuseIdentifier: HomeTableViewCell.identifier)
    tableView.register(UINib(nibName: BannersTableViewCell.nibName, bundle: .main),
                       forCellReuseIdentifier: BannersTableViewCell.identifier)
  }
  
  func config(viewModel: HomeViewModel) {
    self.viewModel = viewModel
  }
  
  private func navigateToAddGoal() {
    let storyboard = UIStoryboard(name: GoalViewController.viewName, bundle: .main)
    guard let goalVC = storyboard.instantiateViewController(withIdentifier: GoalViewController.identifier) as? GoalViewController else { return }
    let goalVM = GoalViewModel()
    goalVC.config(viewModel: goalVM)
    goalVC.delegate = self
    navigationController?.pushViewController(goalVC, animated: true)
  }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel?.output.getNumberOfRows() ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return viewModel?.output.getCell(viewController: self,tableView: tableView, indexPath: indexPath) ?? UITableViewCell()
  }
}

extension HomeViewController: HomeTableViewCellDelegate {
  func tappedAddGoal() {
    navigateToAddGoal()
  }
}

extension HomeViewController: GoalViewControllerDelegate {
  func createdNewGoal(goalInfo: GoalModel) {
    viewModel?.input.addGoal(goal: goalInfo)
    tableView.reloadData()
  }
}
