//
//  HomeCoordinator.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/28.
//

import UIKit

final class HomeCoordinator: Coordinator {
    
    var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorCase = .home
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MainViewController(
            viewModel: MainViewModel(
                coordinator: self,
                mainUseCase: MainUseCase(
                    tmdbRepository: TMDBRepository())))
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushToDetailViewController(data: MovieResults) {
        let vc = DetailViewController(
            viewModel: DetailViewModel(
                detailUseCase: DetailUseCase(
                    tmdbRepository: TMDBRepository(),
                    realmRepository: RealmRepository()),
                realmData: FavoriteListRealmDTO()))
        vc.viewModel.selectedMovie.accept([data])
        vc.hidesBottomBarWhenPushed = true
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.pushViewController(vc, animated: true)
    }
    
}

