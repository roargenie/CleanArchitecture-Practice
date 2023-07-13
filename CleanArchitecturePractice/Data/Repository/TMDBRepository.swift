//
//  TMDBRepository.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/07.
//

import Foundation
import Moya
import RxSwift

enum TMDBNetworkError: Int, Error {
    case inValidAuth = 401
    case notFound = 404
    case unknown
    var description: String { self.errorDescription }
}

extension TMDBNetworkError {
    var errorDescription: String {
        switch self {
        case .inValidAuth:
            return "401: INVALID_AUTH"
        case .notFound:
            return "404: NOT_FOUND"
        default:
            return "UN_KNOWN_ERROR"
        }
    }
}

final class TMDBRepository {
    let provider: MoyaProvider<TMDBTarget>
    init() { provider = MoyaProvider<TMDBTarget>() }
}

extension TMDBRepository: TMDBRepositoryType {
    
    func requestMovie() async throws -> Result<MovieResponse, TMDBNetworkError> {
        let response = try await provider.request(.trendingMovie)
        switch response {
        case .success(let response):
            let data = try JSONDecoder().decode(MovieResponseDTO.self, from: response.data)
            return .success(data.toDomain())
        case .failure(let error):
            return .failure(TMDBNetworkError(rawValue: error.response!.statusCode) ?? .unknown)
        }
    }
    
    func requestGenre() async throws -> Result<GenreResponse, TMDBNetworkError> {
        let response = try await provider.request(.genre)
        switch response {
        case .success(let response):
            let data = try JSONDecoder().decode(GenreResponseDTO.self, from: response.data)
            return .success(data.toDomain())
        case .failure(let error):
            return .failure(TMDBNetworkError(rawValue: error.response!.statusCode) ?? .unknown)
        }
    }
    
    func requestMovie(completion: @escaping (Result<MovieResponse, TMDBNetworkError>) -> Void) {
        provider.request(.trendingMovie) { result in
            switch result {
            case .success(let response):
                let data = try? JSONDecoder().decode(MovieResponseDTO.self, from: response.data)
                dump(data?.results)
                completion(.success(data!.toDomain()))
            case .failure(let error):
                completion(.failure(TMDBNetworkError(rawValue: error.response!.statusCode) ?? .unknown))
            }
        }
    }
    
    func requestCast(id: Int, completion: @escaping (Result<CastResponse, TMDBNetworkError>) -> Void) {
        provider.request(.cast(id: id)) { result in
            switch result {
            case .success(let response):
                let data = try? JSONDecoder().decode(CastResponseDTO.self, from: response.data)
                completion(.success(data!.toDomain()))
            case .failure(let error):
                completion(.failure(TMDBNetworkError(rawValue: error.response!.statusCode) ?? .unknown))
            }
        }
    }
    
    func requestGenre(completion: @escaping (Result<GenreResponse, TMDBNetworkError>) -> Void) {
        provider.request(.genre) { result in
            switch result {
            case .success(let response):
                let data = try? JSONDecoder().decode(GenreResponseDTO.self, from: response.data)
                completion(.success(data!.toDomain()))
            case .failure(let error):
                completion(.failure(TMDBNetworkError(rawValue: error.response!.statusCode) ?? .unknown))
            }
        }
    }
    
}
