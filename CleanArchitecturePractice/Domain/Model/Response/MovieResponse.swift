//
//  MovieResponse.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/07.
//

import Foundation

struct MovieResponse {
    var page: Int
    var results: [MovieResults]
    var total_pages: Int
    var total_results: Int
}

struct MovieResults {
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
