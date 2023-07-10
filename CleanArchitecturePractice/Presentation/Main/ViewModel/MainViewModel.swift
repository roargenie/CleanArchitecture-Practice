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
    
    private let mainUseCase: MainUseCase
    var moveToDetailVC: ((MovieResults) -> Void)?
    
    struct Input {
        let viewDidLoadEvent: Signal<Void>
        let itemSelected: Signal<MovieResults>
    }
    
    struct Output {
        let movieList: Driver<[MovieResults]>
    }
    
    init(mainUseCase: MainUseCase) {
        self.mainUseCase = mainUseCase
    }
    var disposeBag = DisposeBag()
    
    private let movieList = BehaviorRelay<[MovieResults]>(value: [])
    
    func transform(input: Input) -> Output {
        
        input.viewDidLoadEvent
            .emit(onNext: { [weak self] in
                print("=======🔥ViewModel ViewDidLoad Event======")
                self?.requestMovie()
            })
            .disposed(by: disposeBag)
        
        input.itemSelected
            .withUnretained(self)
            .emit { vm, item in
                vm.moveToVC(data: item)
            }
            .disposed(by: disposeBag)
        
        mainUseCase.successMovieSignal
            .asSignal()
            .emit { [weak self] response in
                print("ViewModel ==🟢", response.results)
                self?.movieList.accept(response.results)
            }
            .disposed(by: disposeBag)
        
        return Output(movieList: movieList.asDriver())
    }
}

extension MainViewModel {
    
    private func requestMovie() {
        self.mainUseCase.requestMovie()
    }
    
    private func moveToVC(data: MovieResults) {
        moveToDetailVC?(data)
    }
}
