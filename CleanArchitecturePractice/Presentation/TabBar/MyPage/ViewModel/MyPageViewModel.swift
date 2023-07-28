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
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    init(coordinator: MyPageCoordinator?) {
        self.coordinator = coordinator
    }
    var disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        
        return Output()
    }
    
}
