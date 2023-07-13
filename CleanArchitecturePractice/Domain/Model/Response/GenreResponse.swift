//
//  GenreResponse.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/11.
//

import Foundation

struct GenreResponse {
    let genres: [GenreResults]
}

struct GenreResults {
    let id: Int
    let name: String
}
