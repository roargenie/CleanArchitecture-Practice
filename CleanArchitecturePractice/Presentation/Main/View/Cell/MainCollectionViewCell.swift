//
//  MainCollectionViewCell.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/07.
//

import UIKit
import SnapKit
import Then

final class MainCollectionViewCell: BaseCollectionViewCell {
    
    let releaseDateLabel: UILabel = UILabel().then {
        $0.text = "2022-07-21"
        $0.font = .systemFont(ofSize: 12, weight: .light)
        $0.textColor = .gray
    }
    
    let movieGenreLabel: UILabel = UILabel().then {
        $0.text = "Action"
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .black
    }
    
    let movieInfoView: UIView = MovieInfoView()
    
    lazy var movieView: UIView = UIView().then {
        $0.addSubview(movieInfoView)
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = UIColor.systemGray5.cgColor
        $0.layer.borderWidth = 1
        $0.layer.masksToBounds = false
        $0.layer.shadowOffset = CGSize(width: 5, height: 5)
        $0.layer.shadowOpacity = 0.2
        $0.backgroundColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [releaseDateLabel, movieGenreLabel, movieView].forEach { contentView.addSubview($0) }
    }
    
    override func setConstraints() {
        releaseDateLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
        }
        
        movieInfoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        movieGenreLabel.snp.makeConstraints { make in
            make.top.equalTo(releaseDateLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
        }
        
        movieView.snp.makeConstraints { make in
            make.top.equalTo(movieGenreLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
    
    func setupCell() {
        
    }
}
