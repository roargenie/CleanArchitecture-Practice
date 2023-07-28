//
//  CoordinatorDelegate.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/28.
//

import Foundation

protocol CoordinatorDelegate: AnyObject {
    
    func didFinish(childCoordinator: Coordinator)
}
