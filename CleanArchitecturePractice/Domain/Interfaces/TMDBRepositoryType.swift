//
//  TMDBRepositoryType.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/08.
//

import Foundation
import Moya

protocol TMDBRepositoryType: AnyObject {
    
    func requestMovie(completion: @escaping (Result<MovieResponse, TMDBNetworkError>) -> Void)
    
    func requestCast(id: Int, completion: @escaping (Result<CastResponse, TMDBNetworkError>) -> Void)
    
    func requestGenre(completion: @escaping (Result<GenreResponse, TMDBNetworkError>) -> Void)
    
    func requestMovie() async throws -> Result<MovieResponse, TMDBNetworkError>
    
    func requestGenre() async throws -> Result<GenreResponse, TMDBNetworkError>
}

extension MoyaProvider {
    
    func request(_ target: Target) async throws -> Result<Response, MoyaError> {
        await withCheckedContinuation { continuation in
            self.request(target) { result in
                continuation.resume(returning: result)
            }
        }
    }
    
}
