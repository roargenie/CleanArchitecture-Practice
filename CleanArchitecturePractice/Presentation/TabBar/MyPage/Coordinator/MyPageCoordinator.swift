//
//  MyPageCoordinator.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/28.
//

import UIKit

final class MyPageCoordinator: Coordinator {
    
    var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorCase = .myPage
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MyPageViewController(
            viewModel: MyPageViewModel(
                coordinator: self,
                myPageUseCase: FavoriteListUseCase(
                    realmRepository: RealmRepository())))
        navigationController.pushViewController(vc, animated: true)
    }
    
}
