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
    
    var successCastSignal = PublishRelay<CastResponse>()
    
    init(tmdbRepository: TMDBRepository) {
        self.tmdbRepository = tmdbRepository
    }
    
    func requestCast(id: Int) {
        self.tmdbRepository.requestCast(id: id) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let castData):
                self.successCastSignal.accept(castData)
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }
}
