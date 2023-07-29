//
//  RealmRepositoryType.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/28.
//

import Foundation
import RealmSwift

protocol RealmRepositoryType: AnyObject {
    
//    func loadFavoriteMovieList() -> Results<FavoriteListRealmDTO> // 관심 목록 리스트 가져오기
    func loadFavoriteMovieList() -> [MovieResults]
    
    func saveFavoriteMovie(movie: MovieResults)                   // 관심 목록에 저장하기
    
    func deleteFavoriteMovie(movieId: Int)                        // 관심 목록에서 삭제하기
    
    func filterMovieId(movieId: Int) -> Bool                      // 저장된 목록인지 확인하기
    
}
