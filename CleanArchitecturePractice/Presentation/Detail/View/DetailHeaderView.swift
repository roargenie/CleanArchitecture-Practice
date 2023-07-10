//
//  DetailHeaderView.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/10.
//

import UIKit


final class DetailHeaderView: UIView {
    
    static let identifier = "DetailHeaderView"
    
    let backgroundImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .red
    }
    
    let backgroundPosterImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .yellow
    }
    
    let movieTitleLabel: UILabel = UILabel().then {
        $0.text = "Guardians of the Galaxy"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 30, weight: .bold)
        $0.backgroundColor = .green
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        [backgroundImageView, backgroundPosterImageView, movieTitleLabel].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundPosterImageView.snp.makeConstraints { make in
            make.leading.equalTo(backgroundImageView.snp.leading).inset(12)
            make.bottom.equalTo(backgroundImageView.snp.bottom).inset(12)
            make.top.equalTo(movieTitleLabel.snp.bottom).offset(12)
            make.width.equalTo(backgroundImageView.snp.width).multipliedBy(0.3)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(backgroundImageView.snp.horizontalEdges).inset(12)
            make.top.equalTo(backgroundImageView.snp.top).inset(12)
            make.height.equalTo(36)
        }
    }
}
