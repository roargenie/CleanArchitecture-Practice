//
//  TabBarCoordinator.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/28.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    
    var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorCase = .tabBar
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: false)
        self.tabBarController = UITabBarController()
    }
    
    func start() {
        let pages: [TabBarPageCase] = TabBarPageCase.allCases
        let controllers: [UINavigationController] = pages.map { self.createTabNavigationController(of: $0) }
        self.configureTabBarController(with: controllers)
    }
    
    func currentPage() -> TabBarPageCase? {
        TabBarPageCase(index: self.tabBarController.selectedIndex)
    }
    
    private func configureTabBarController(with tabViewControllers: [UIViewController]) {
        self.tabBarController.setViewControllers(tabViewControllers, animated: true)
        self.tabBarController.selectedIndex = TabBarPageCase.home.pageNumber
        self.tabBarController.view.backgroundColor = .systemBackground
        self.tabBarController.tabBar.backgroundColor = .systemBackground
        self.tabBarController.tabBar.tintColor = .black
        self.tabBarController.tabBar.unselectedItemTintColor = .lightGray
        self.changeAnimation()
        self.navigationController.pushViewController(tabBarController, animated: true)
    }
    
    private func configureTabBarItem(of page: TabBarPageCase) -> UITabBarItem {
        return UITabBarItem(
            title: page.pageTitle,
            image: UIImage(systemName: page.tabBarIconName),
            tag: page.pageNumber)
    }
    
    private func createTabNavigationController(of page: TabBarPageCase) -> UINavigationController {
        let tabNavigationController = UINavigationController()
        tabNavigationController.setNavigationBarHidden(false, animated: false)
        tabNavigationController.tabBarItem = self.configureTabBarItem(of: page)
        connectTabCoordinator(of: page, to: tabNavigationController)
        return tabNavigationController
    }
    
    private func connectTabCoordinator(of page: TabBarPageCase, to tabNavigationController: UINavigationController) {
        switch page {
        case .home:
            let homeCoordinator = HomeCoordinator(tabNavigationController)
            homeCoordinator.delegate = self
            self.childCoordinators.append(homeCoordinator)
            homeCoordinator.start()
        case .mypage:
            let myPageCoordinator = MyPageCoordinator(tabNavigationController)
            myPageCoordinator.delegate = self
            self.childCoordinators.append(myPageCoordinator)
            myPageCoordinator.start()
        }
    }
    
}

extension TabBarCoordinator: CoordinatorDelegate {
    
    func didFinish(childCoordinator: Coordinator) {
        self.childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })
        if childCoordinator.type == .myPage {
            self.navigationController.viewControllers.removeAll()
            self.delegate?.didFinish(childCoordinator: self)
        }
    }
}
