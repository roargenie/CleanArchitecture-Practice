//
//  Cell+Ex.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/07.
//

import UIKit

extension UITableViewCell: ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

