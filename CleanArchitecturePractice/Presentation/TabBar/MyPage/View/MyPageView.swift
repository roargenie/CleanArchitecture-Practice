//
//  MyPageView.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/28.
//

import UIKit

final class MyPageView: BaseView {
    
    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout()).then {
        $0.register(MyPageCollectionViewCell.self, forCellWithReuseIdentifier: MyPageCollectionViewCell.reuseIdentifier)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        addSubview(collectionView)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = (UIScreen.main.bounds.width - 32) / 3
        let height: CGFloat = width
        
        layout.itemSize = CGSize(width: width, height: height)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        return layout
    }
    
}
