//
//  MainUseCase.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/07.
//

import Foundation
import RxSwift
import RxRelay

final class MainUseCase {
    
    private let tmdbRepository: TMDBRepositoryType
    
    var successMovieSignal = PublishRelay<MovieResponse>()
    
    init(tmdbRepository: TMDBRepositoryType) {
        self.tmdbRepository = tmdbRepository
    }
    
    func requestMovie() {
        self.tmdbRepository.requestMovie { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let movieData):
                self.successMovieSignal.accept(movieData)
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }
    
}
