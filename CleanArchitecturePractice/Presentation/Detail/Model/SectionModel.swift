//
//  SectionModel.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/10.
//

import Foundation
import RxDataSources

protocol DetailSectionModel { }

struct OverviewSection: DetailSectionModel {
    var movies: MovieResults
}

struct CastSection: DetailSectionModel {
    var cast: [CastResults]
}

typealias MovieSectionModel = SectionModel<MovieSection, MovieItem>

enum MovieSection: Int, Equatable {
    case overview
    case cast

    init(index: Int) {
        switch index {
        case 0: self = .overview
        default: self = .cast
        }
    }

    var headerTitle: String {
        switch self {
        case .overview:
            return "Overview"
        case .cast:
            return "Cast"
        }
    }
    
}

enum MovieItem {
    
    case overview(OverviewSection)
    case cast(CastSection)

    var detail: DetailSectionModel {
        switch self {
        case .overview(let item):
            return item
        case .cast(let item):
            return item
        }
    }
}
