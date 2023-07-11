//
//  SectionModel.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/10.
//

import Foundation
import RxDataSources

enum MovieSectionItem {
    case OverviewItem(response: MovieResults)
    case CastviewItem(response: CastResults)
}

enum MovieSectionModel {
    case overview(header: String, items: [MovieSectionItem])
    case cast(header: String, items: [MovieSectionItem])
}

extension MovieSectionModel: SectionModelType {
    
    typealias Item = MovieSectionItem
    
    init(original: MovieSectionModel, items: [Item]) {
        switch original {
        case .overview(let header, let items):
            self = .overview(header: header, items: items)
        case .cast(let header, let items):
            self = .cast(header: header, items: items)
        }
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
