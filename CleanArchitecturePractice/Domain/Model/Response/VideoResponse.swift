//
//  VideoResponse.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/07.
//

import Foundation

struct Video: Codable {
    var id: Int
    var results: [VideoResults]
}

struct VideoResults: Codable {
    var key: String
    var site: String
    var type: String
}
