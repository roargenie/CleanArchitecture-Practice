//
//  TMDBTarget.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/07.
//

import Foundation
import Moya

typealias DictionaryType = [String: Any]

enum TMDBTarget {
    case trendingMovie
    case genre
    case cast
    case video
}

extension TMDBTarget: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: EndPoint.BaseURL) else {
            fatalError("fatal error - invalid api url")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .trendingMovie:
            return "trending/all/week?api_key=\(APIKey.TMDB)&language-en-US"
        case .genre:
            return ""
        case .cast:
            return ""
        case .video:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .trendingMovie, .genre, .cast, .video:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .trendingMovie, .genre, .cast, .video:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [
            "": ""
//            "accept": "application/json",
//            "Authorization": "Bearer" + APIKey.TMDB
        ]
    }
    
    
}
