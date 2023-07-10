//
//  SectionModel.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/10.
//

import Foundation
import RxDataSources

protocol MovieSectionItem { }

struct OverviewSection: MovieSectionItem {
    var items: [MovieList]
}

struct MovieList {
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

struct CastSection: MovieSectionItem {
    var items: [CastResults]
}

enum MovieSectionModel {
    case overview(header: String, items: [OverviewSection])
    case cast(header: String, items: [CastSection])
}

extension MovieSectionModel: SectionModelType {
    
    typealias Item = MovieSectionItem
    
    init(original: MovieSectionModel, items: [Item]) {
        self = original
    }
    
    var headers: String? {
        if case let .overview(header, _) = self {
            return header
        }
        if case let .cast(header, _) = self {
            return header
        }
        return nil
    }
    
    var items: [Item] {
        switch self {
        case let .overview(_, items):
            return items
        case let .cast(_, items):
            return items
        }
    }
    
}
