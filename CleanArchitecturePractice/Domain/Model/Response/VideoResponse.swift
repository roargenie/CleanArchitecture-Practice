//
//  VideoResponse.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/07.
//

import Foundation

struct VideoResponse {
    var id: Int
    var results: [VideoResults]
}

struct VideoResults {
    var key: String
    var site: String
    var type: String
}
