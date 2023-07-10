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
    case unknown
    var description: String { self.errorDescription }
}

extension TMDBNetworkError {
    var errorDescription: String {
        switch self {
        case .inValidAuth:
            return "401: INVALID_AUTH"
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
    
}
