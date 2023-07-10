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
    
    lazy var movieView: UIView = {
        let view = UIView()
        [movieImageView, rateStackView, movieTitleLabel,
         castingCharactersLabel, dividingLineView,
         detailViewLabel, detailViewButton].forEach { view.addSubview($0) }
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.layer.borderWidth = 1
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.layer.shadowOpacity = 0.2
        view.backgroundColor = .white
        return view
    }()
    
    let movieImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
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
    }
    
    override func configureUI() {
        [releaseDateLabel, movieGenreLabel, movieView].forEach { contentView.addSubview($0) }
    }
    
    override func setConstraints() {
        releaseDateLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
        }
        
        movieGenreLabel.snp.makeConstraints { make in
            make.top.equalTo(releaseDateLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
        }
        
        movieView.snp.makeConstraints { make in
            make.top.equalTo(movieGenreLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
        
        movieImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
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
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        castingCharactersLabel.snp.makeConstraints { make in
            make.top.equalTo(movieTitleLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(16)
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
    
    func setupCell(data: MovieResults) {
        releaseDateLabel.text = data.release_date
        movieTitleLabel.text = data.title
        rateNumberLabel.text = String(format: "%.1f", data.vote_average)
        setImage(image: data)
    }
    
    private func setImage(image: MovieResults) {
        let urlString = "https://image.tmdb.org/t/p/w220_and_h330_face\(image.poster_path)"
        
        if let imageURL = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                if let error = error {
                    print("Error loading image: \(error.localizedDescription)")
                    return
                }
                if let imageData = data, let image = UIImage(data: imageData) {
                    DispatchQueue.main.async { [weak self] in
                        self?.movieImageView.image = image
                    }
                }
            }
            
            task.resume()
        }
    }
    
}
