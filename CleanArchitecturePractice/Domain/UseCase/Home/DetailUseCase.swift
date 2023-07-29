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
    private let realmRepository: RealmRepositoryType
    
    let successCastSignal = PublishRelay<CastResponse>()
    
    
    init(tmdbRepository: TMDBRepository, realmRepository: RealmRepositoryType) {
        self.tmdbRepository = tmdbRepository
        self.realmRepository = realmRepository
    }
    
   
}

//MARK: - 서버

extension DetailUseCase {
    
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

//MARK: - Realm DB

extension DetailUseCase {
    
    func saveFavoriteMovie(movie: MovieResults) {
        self.realmRepository.saveFavoriteMovie(movie: movie)
    }
    
    func deleteFavoriteMovie(movieId: Int) {
        self.realmRepository.deleteFavoriteMovie(movieId: movieId)
    }
    
    func filterMovieId(movieId: Int) -> Bool {
        return self.realmRepository.filterMovieId(movieId: movieId)
    }
    
}

