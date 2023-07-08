//
//  Protocol.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/07.
//

import Foundation

protocol CommonViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

protocol ReusableViewProtocol: AnyObject {
    static var reuseIdentifier: String { get }
}
