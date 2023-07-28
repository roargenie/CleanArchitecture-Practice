//
//  DetailHeaderView.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/10.
//

import UIKit


final class DetailHeaderView: UIView {
    
    let backgroundImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    let backgroundPosterImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
    let movieTitleLabel: UILabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 30, weight: .bold)
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
    
    func setupHeaderView(data: MovieResults) {
        let url = "https://image.tmdb.org/t/p/w220_and_h330_face"
        loadImage(urlString: "\(url)\(data.backdrop_path)") { [weak self] image in
            self?.backgroundImageView.image = image
        }
        
        loadImage(urlString: "\(url)\(data.poster_path)") { [weak self] image in
            self?.backgroundPosterImageView.image = image
        }
        
        movieTitleLabel.text = data.title
    }
    
    private func loadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: url),
               let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
