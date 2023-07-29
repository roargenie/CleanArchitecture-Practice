//
//  MyPageViewModel.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/28.
//

import Foundation
import RxSwift
import RxCocoa


final class MyPageViewModel: CommonViewModelType {
    
    private weak var coordinator: MyPageCoordinator?
    private let myPageUseCase: FavoriteListUseCase
    
    struct Input {
        let viewDidLoadEvent: Signal<Void>
        let viewWillAppearEvent: Signal<Void>
    }
    
    struct Output {
        let favoriteMovieList: Driver<[MovieResults]>
    }
    
    init(coordinator: MyPageCoordinator?, myPageUseCase: FavoriteListUseCase) {
        self.coordinator = coordinator
        self.myPageUseCase = myPageUseCase
    }
    var disposeBag = DisposeBag()
    
    private let favoriteMovieList = BehaviorRelay<[MovieResults]>(value: [])
    
    func transform(input: Input) -> Output {
        
        input.viewDidLoadEvent
            .emit(onNext: { [weak self] in
                print("=====🔥MyPageViewModel=====")
                guard let self = self else { return }
//                self.loadFavoriteMovieList()
            })
            .disposed(by: disposeBag)
        
        input.viewWillAppearEvent
            .emit(onNext: { [weak self] in
                guard let self = self else { return }
                self.loadFavoriteMovieList()
            })
            .disposed(by: disposeBag)
        
        myPageUseCase.realmDataSignal
            .asSignal(onErrorJustReturn: [])
            .emit { [weak self] movie in
                guard let self = self else { return }
                self.favoriteMovieList.accept(movie)
                print("========realmDataSignal",movie)
            }
            .disposed(by: disposeBag)
        
        return Output(
            favoriteMovieList: favoriteMovieList.asDriver())
    }
    
}

extension MyPageViewModel {
    
    private func loadFavoriteMovieList() {
        self.myPageUseCase.loadFavoriteMovieList()
    }
    
}
