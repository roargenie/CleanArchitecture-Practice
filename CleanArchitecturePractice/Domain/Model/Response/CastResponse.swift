//
//  CastResponse.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/07.
//

import Foundation

struct CastResponse {
    var id: Int
    var cast: [CastResults]
}

struct CastResults {
    var name: String
    var profile_path: String?
    var character: String
}
