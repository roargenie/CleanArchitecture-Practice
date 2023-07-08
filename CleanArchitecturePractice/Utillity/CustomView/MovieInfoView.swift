//
//  movieInfoView.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/07.
//

import UIKit

final class MovieInfoView: UIView {
    
    let movieImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .yellow
    }
    
    let rateLabel: UILabel = UILabel().then {
        $0.text = " 평점 "
        $0.textAlignment = .center
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 14)
        $0.backgroundColor = .systemIndigo
    }
    
    let rateNumberLabel: UILabel = UILabel().then {
        $0.text = " 3.3 "
        $0.backgroundColor = .white
        $0.font = .systemFont(ofSize: 14)
        $0.textAlignment = .center
    }
    
    lazy var rateStackView: UIStackView = UIStackView(arrangedSubviews: [rateLabel, rateNumberLabel]).then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .center
        $0.spacing = 0
    }
    
    let movieTitleLabel: UILabel = UILabel().then {
        $0.text = "Movie Title"
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    let castingCharactersLabel: UILabel = UILabel().then {
        $0.text = "dddddd, aaaaa, bbbbb bb, cccccc"
        $0.font = .systemFont(ofSize: 16, weight: .light)
        $0.textColor = .gray
    }
    
    private let dividingLineView: UIView = UIView().then {
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.borderWidth = 1
    }
    
    let detailViewLabel: UILabel = UILabel().then {
        $0.text = "자세히 보기"
        $0.font = .systemFont(ofSize: 14, weight: .light)
        $0.textColor = .darkGray
    }
    
    let detailViewButton: UIButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.tintColor = .darkGray
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        [movieImageView, rateStackView, movieTitleLabel,
         castingCharactersLabel, dividingLineView, detailViewLabel, detailViewButton].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        movieImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.55)
        }
        
        rateLabel.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalTo(40)
        }
        
        rateNumberLabel.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalTo(40)
        }
        
        rateStackView.snp.makeConstraints { make in
            make.leading.equalTo(movieImageView.snp.leading).inset(16)
            make.bottom.equalTo(movieImageView.snp.bottom).inset(8)
            make.height.equalTo(32)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
        }
        
        castingCharactersLabel.snp.makeConstraints { make in
            make.top.equalTo(movieTitleLabel.snp.bottom).offset(4)
            make.leading.equalTo(movieTitleLabel.snp.leading)
        }
        
        dividingLineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(castingCharactersLabel.snp.bottom).offset(20)
        }
        
        detailViewLabel.snp.makeConstraints { make in
            make.top.equalTo(dividingLineView.snp.bottom).offset(20)
            make.leading.equalTo(dividingLineView.snp.leading)
        }

        detailViewButton.snp.makeConstraints { make in
            make.centerY.equalTo(detailViewLabel.snp.centerY)
            make.trailing.equalTo(dividingLineView.snp.trailing)
        }
    }
    
    func setupView() {
        
    }
    
}
