//
//  MyPageCollectionViewCell.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/28.
//

import UIKit

final class MyPageCollectionViewCell: BaseCollectionViewCell {
    
    let imageView: UIImageView = UIImageView().then {
        $0.backgroundColor = .blue
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
    }
    
    override func configureUI() {
        addSubview(imageView)
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
}
