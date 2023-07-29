//
//  FavoriteListUseCase.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/28.
//

import Foundation
import RxSwift
import RxRelay

final class FavoriteListUseCase {
    
    private let realmRepository: RealmRepositoryType
    
    init(realmRepository: RealmRepositoryType) {
        self.realmRepository = realmRepository
    }
    
    
}
