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
    var successGenreSignal = PublishRelay<GenreResponse>()
    var successCast: [[CastResults]] = []
    
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
    
    func requestGenre() {
        self.tmdbRepository.requestGenre { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let genre):
                self.successGenreSignal.accept(genre)
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }
    
    func requestMovieAndGenre() {
        self.tmdbRepository.requestGenre { [weak self] genreResponse in
            guard let self = self else { return }
            switch genreResponse {
            case .success(let genre):
                self.successGenreSignal.accept(genre)
                self.tmdbRepository.requestMovie { movieResponse in
                    switch movieResponse {
                    case .success(let movie):
                        self.successMovieSignal.accept(movie)
                        movie.results.forEach {
                            self.tmdbRepository.requestCast(id: $0.id) { castResponse in
                                switch castResponse {
                                case .success(let castData):
                                    self.successCast.append(castData.cast)
                                    print("🟢=========Cast데이터", self.successCast)
                                case .failure(let error):
                                    print(error.errorDescription)
                                }
                            }
                        }
                    case .failure(let error):
                        print(error.errorDescription)
                    }
                }
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }
    
}
