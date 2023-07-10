//
//  CastResponseDTO.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/11.
//

import Foundation

struct CastResponseDTO: Codable {
    var id: Int
    var cast: [CastResultsDB]
}

struct CastResultsDB: Codable {
    var name: String
    var profile_path: String?
    var character: String
}

extension CastResponseDTO {
    
    func toDomain() -> CastResponse {
        return .init(
            id: id,
            cast: cast.map { $0.toDomain() })
    }
}

extension CastResultsDB {
    
    func toDomain() -> CastResults {
        return .init(
            name: name,
            profile_path: profile_path,
            character: character)
    }
}
