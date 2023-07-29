//
//  FavoriteListRealmDTO.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/28.
//

import Foundation
import RealmSwift

final class FavoriteListRealmDTO: Object {
    
    // MovieResponse
    @Persisted var adult: Bool
    @Persisted var title: String
    @Persisted var release_date: String
    @Persisted var overview: String
    @Persisted var poster_path: String
    @Persisted var backdrop_path: String
    @Persisted var vote_average: Double
    
    // CastResponse
//    @Persisted var name: String
//    @Persisted var profile_path: String?
//    @Persisted var character: String
    
    @Persisted(primaryKey: true) var id: Int
    
    convenience init(movie: MovieResults) {
        self.init()
        self.adult = movie.adult
        self.title = movie.title
        self.release_date = movie.release_date
        self.overview = movie.overview
        self.poster_path = movie.poster_path
        self.backdrop_path = movie.backdrop_path
        self.vote_average = movie.vote_average
        self.id = movie.id
        
//        self.name = cast.name
//        self.profile_path = cast.profile_path
//        self.character = cast.character
    }
    
}

extension FavoriteListRealmDTO {
    
    func toDomain() -> MovieResults {
        return .init(adult: adult,
                     id: id,
                     title: title,
                     release_date: release_date,
                     overview: overview,
                     poster_path: poster_path,
                     backdrop_path: backdrop_path,
                     genre_ids: [],
                     vote_average: vote_average)
    }
    
//    func toDomain() -> CastResults {
//        return .init(name: name,
//                     profile_path: profile_path,
//                     character: character)
//    }
    
}
