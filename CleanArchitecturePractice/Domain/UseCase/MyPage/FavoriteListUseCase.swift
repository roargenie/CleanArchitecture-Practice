//
//  FavoriteListUseCase.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/28.
//

import Foundation
import RxSwift
import RxRelay
import RealmSwift

final class FavoriteListUseCase {
    
    private let realmRepository: RealmRepositoryType
    
//    let realmDataSignal = PublishRelay<Results<FavoriteListRealmDTO>>()
    let realmDataSignal = BehaviorRelay<[MovieResults]>(value: [])
    
    init(realmRepository: RealmRepositoryType) {
        self.realmRepository = realmRepository
    }
    
}

extension FavoriteListUseCase {
    
    func loadFavoriteMovieList() {
        let data = self.realmRepository.loadFavoriteMovieList()
        self.realmDataSignal.accept(data)
        print("realmDatsSignal===========", realmDataSignal.values)
    }
    
}
