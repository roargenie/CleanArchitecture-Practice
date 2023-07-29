//
//  RealmRepository.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/28.
//

import Foundation
import RealmSwift

final class RealmRepository: RealmRepositoryType {
    
    var storage: RealmStorage
    
    init() {
        self.storage = RealmStorage.shared
    }
}

extension RealmRepository {
    
    func loadFavoriteMovieList() -> [MovieResults] {
        let realmDTO = storage.read()
        return realmDTO.map { $0.toDomain() }
    }
    
//    func loadFavoriteMovieList() -> Results<FavoriteListRealmDTO> {
//        return storage.read()
//    }
    
    func saveFavoriteMovie(movie: MovieResults) {
        let movieDTO = FavoriteListRealmDTO(movie: movie)
        storage.save(movie: movieDTO)
    }
    
    func deleteFavoriteMovie(movieId: Int) {
        storage.delete(movieId: movieId)
    }
    
    func filterMovieId(movieId: Int) -> Bool {
        return storage.filterMovieId(movieId: movieId)
    }
    
}

extension Results {
    func toArray() -> [Element] {
        return compactMap { $0 }
    }
}
