//
//  MainViewModel.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/07.
//

import Foundation
import RxSwift
import RxCocoa


final class MainViewModel: CommonViewModelType {
    
    private weak var coordinator: HomeCoordinator?
    private let mainUseCase: MainUseCase
    var castList = [[CastResults]]()
//    var moveToDetailVC: ((MovieResults) -> Void)?
    
    struct Input {
        let viewDidLoadEvent: Signal<Void>
        let itemSelected: Signal<MovieResults>
    }
    
    struct Output {
        let movieList: Driver<[MovieResults]>
        let genreList: Driver<[GenreResults]>
    }
    
    init(coordinator: HomeCoordinator?, mainUseCase: MainUseCase) {
        self.coordinator = coordinator
        self.mainUseCase = mainUseCase
    }
    var disposeBag = DisposeBag()
    
    private let movieList = BehaviorRelay<[MovieResults]>(value: [])
    private let genreList = BehaviorRelay<[GenreResults]>(value: [])
    
    func transform(input: Input) -> Output {
        
        input.viewDidLoadEvent
            .emit(onNext: { [weak self] in
                print("=======🔥ViewModel ViewDidLoad Event======")
//                self?.requestGenre()
//                self?.requestMovie()
                self?.requestMovieAndGenre()
                self?.makeCastData()
//                self?.castList = self?.mainUseCase.successCast ?? []
            })
            .disposed(by: disposeBag)
        
        input.itemSelected
            .withUnretained(self)
            .emit { vm, item in
//                vm.moveToVC(data: item)
                vm.coordinator?.pushToDetailViewController(data: item)
            }
            .disposed(by: disposeBag)
        
        mainUseCase.successGenreSignal
            .asSignal()
            .emit { [weak self] response in
                self?.genreList.accept(response.genres)
            }
            .disposed(by: disposeBag)
        
        mainUseCase.successMovieSignal
            .asSignal()
            .emit { [weak self] response in
                print("ViewModel ==🟢", response.results)
                self?.movieList.accept(response.results)
            }
            .disposed(by: disposeBag)
        
        return Output(
            movieList: movieList.asDriver(),
            genreList: genreList.asDriver())
    }
}

extension MainViewModel {
    
    private func makeCastData() {
        self.castList = self.mainUseCase.successCast
    }
    
    private func requestMovieAndGenre() {
        self.mainUseCase.requestMovieAndGenre()
    }
    
    private func requestMovie() {
        self.mainUseCase.requestMovie()
    }
    
    private func requestGenre() {
        self.mainUseCase.requestGenre()
    }
    
//    private func moveToVC(data: MovieResults) {
//        moveToDetailVC?(data)
//    }
}
