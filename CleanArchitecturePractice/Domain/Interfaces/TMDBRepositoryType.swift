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
    
}
