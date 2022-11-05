//
//  ViewController.swift
//  proxumer
//
//  Created by Macbook-BOIT on 3/11/2565 BE.
//

import UIKit
import RxSwift

enum TabBar: Int {
  case home = 0
  case wallet = 1
  case achievement = 2
  case profile = 3
  
  var icon : UIImage {
    switch self {
    case .home:
      return UIImage(named: "homeTab") ?? UIImage()
    case .wallet:
      return UIImage(named: "walletTab") ?? UIImage()
    case .achievement:
      return UIImage(named: "achievementTab") ?? UIImage()
    case .profile:
      return UIImage(named: "profileTab") ?? UIImage()
    }
  }
  
  var viewController : UIViewController {
    switch self {
    case .home:
      let storyboard = UIStoryboard(name: HomeViewController.viewName, bundle: .main)
      let homeVC = storyboard.instantiateViewController(withIdentifier: HomeViewController.identifier)
      let navigation = UINavigationController(rootViewController: homeVC)
      return navigation
    case .wallet:
      return WalletViewController()
    case .achievement:
      let storyboard = UIStoryboard(name: AchievementViewController.viewName, bundle: .main)
      let achievementVC = storyboard.instantiateViewController(withIdentifier: AchievementViewController.identifier)
      return achievementVC
    case .profile:
      return ProfileViewController()
    }
  }
}

class ViewController: UITabBarController, UITabBarControllerDelegate {
  private var counter = 0
  fileprivate var disposeBag = DisposeBag()
  private var viewModel: ViewModel? = nil {
    didSet {
      bindViewModel()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    config(viewModel: ViewModel())
    setupTabBars()
    viewModel?.input.fetchData()
  }
  
  private func setupTabBars() {
    let viewControllers = [TabBar.home.viewController,
                           TabBar.wallet.viewController,
                           TabBar.achievement.viewController,
                           TabBar.profile.viewController]
    setViewControllers(viewControllers, animated: false)
    
    let images = [TabBar.home.icon,
                  TabBar.wallet.icon,
                  TabBar.achievement.icon,
                  TabBar.profile.icon]
    guard let tabItems = tabBar.items else { return }
    let totalTabs = tabItems.count - 1
    for item in 0...totalTabs {
      tabItems[item].image = images[item]
      tabItems[item].imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    }
    delegate = self
    tabBar.backgroundColor = .white
    tabBar.tintColor = UIColor.proxumerRed
    tabBar.items?[TabBar.achievement.rawValue].badgeColor = .red
  }
  
  func config(viewModel: ViewModel) {
    self.viewModel = viewModel
  }
  
  fileprivate func bindViewModel() {
    didSuccess()
  }
  
  private func didSuccess() {
    viewModel?
      .output
      .didSuccess
      .subscribe(onNext: {
        self.counter += 1
        self.updateBadge(count: self.counter)
      }, onDisposed: nil).disposed(by: disposeBag)
  }
  
  private func updateBadge(count: Int) {
    tabBar.items?[TabBar.profile.rawValue].badgeValue = String(count)
  }
  
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    if tabBarController.selectedIndex == TabBar.profile.rawValue {
      self.counter = 0
      tabBar.items?[TabBar.profile.rawValue].badgeValue = nil
    }
  }
}

