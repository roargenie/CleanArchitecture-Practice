//
//  GenreResponseDTO.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/11.
//

import Foundation

struct GenreResponseDTO: Codable {
    let genres: [GenreDB]
}

struct GenreDB: Codable {
    let id: Int
    let name: String
}

extension GenreResponseDTO {
    
    func toDomain() -> GenreResponse {
        return .init(
            genres: genres.map { $0.toDomain() })
    }
}

extension GenreDB {
    
    func toDomain() -> GenreResults {
        return .init(
            id: id,
            name: name)
    }
}
