//
//  RealmStorage.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/28.
//

import Foundation
import RealmSwift

final class RealmStorage {
    
    static let shared = RealmStorage()
    private init() { }
    private let realm = try! Realm()
    
    func read() -> Results<FavoriteListRealmDTO> {
        print("Realm is located at:", realm.configuration.fileURL!)
        return realm.objects(FavoriteListRealmDTO.self)
    }
    
    func save(movie: FavoriteListRealmDTO) {
        try! realm.write {
            print("Realm is located at:", realm.configuration.fileURL!)
            realm.add(movie)
        }
    }
    
    func delete(movieId: Int) {
        if let taskToDelete = realm.objects(FavoriteListRealmDTO.self).where({ $0.id == movieId }).first {
            try! realm.write {
                realm.delete(taskToDelete)
            }
        }
    }
    
    func filterMovieId(movieId: Int) -> Bool {
        let task = realm.objects(FavoriteListRealmDTO.self).where { $0.id == movieId }
        return task.isEmpty ? false : true
    }
    
}
