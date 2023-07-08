//
//  MovieResponseDTO.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/08.
//

import Foundation

struct MovieResponseDTO: Codable {
    var page: Int
    var results: [MovieResultsDB]
    var total_pages: Int
    var total_results: Int
}

struct MovieResultsDB: Codable {
    var adult: Bool
    var id: Int
    var title: String
    var release_date: String
    var overview: String
    var poster_path: String
    var backdrop_path: String
    var genre_ids: [Int]
    var vote_average: Double
}

extension MovieResponseDTO {
    
    func toDomain() -> MovieResponse {
        return .init(
            page: page,
            results: results.map { $0.toDomain() },
            total_pages: total_pages,
            total_results: total_results)
    }
}

extension MovieResultsDB {
    
    func toDomain() -> MovieResults {
        return .init(
            adult: adult,
            id: id,
            title: title,
            release_date: release_date,
            overview: overview,
            poster_path: poster_path,
            backdrop_path: backdrop_path,
            genre_ids: genre_ids,
            vote_average: vote_average)
    }
    
}
