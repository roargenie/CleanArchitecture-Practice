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
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    init(mainUseCase: MainUseCase) {
        self.mainUseCase = mainUseCase
    }
    var disposeBag = DisposeBag()
    
    private let movieList = PublishRelay<[MovieResults]>()
    
    func transform(input: Input) -> Output {
        
        
        
        return Output()
    }
}

extension MainViewModel {
    
    private func requestMovie() {
        self.mainUseCase.requestMovie()
    }
}
