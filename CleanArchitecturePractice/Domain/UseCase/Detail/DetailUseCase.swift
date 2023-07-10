//
//  DetailUseCase.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/10.
//

import Foundation
import RxSwift
import RxRelay

final class DetailUseCase {
    
    private let tmdbRepository: TMDBRepository
    
    init(tmdbRepository: TMDBRepository) {
        self.tmdbRepository = tmdbRepository
    }
    
    
}
