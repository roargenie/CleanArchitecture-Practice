//
//  TabBarPageCase.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/28.
//

import Foundation

enum TabBarPageCase: CaseIterable {
    case home, mypage
    
    init?(index: Int) {
        switch index {
        case 0: self = .home
        case 1: self = .mypage
        default: return nil
        }
    }
    
    var pageNumber: Int {
        switch self {
        case .home: return 0
        case .mypage: return 1
        }
    }
    
    var pageTitle: String {
        switch self {
        case .home:
            return "홈"
        case .mypage:
            return "좋아요"
        }
    }
    
    var tabBarIconName: String {
        switch self {
        case .home:
            return "house"
        case .mypage:
            return "heart"
        }
    }
    
}
