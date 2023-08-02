//
//  HeaderViewTableViewCell.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/28.
//

import UIKit
import RxSwift
import RxRelay

final class HeaderViewTableViewCell: BaseTableViewCell {
    
    private var viewModel: DetailViewModel?
    private let disposeBag = DisposeBag()
    
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
    
    let favoriteButton: UIButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        bindCell()
    }
    
    override func configureUI() {
        [backgroundImageView, backgroundPosterImageView,
         movieTitleLabel, favoriteButton].forEach { contentView.addSubview($0) }
    }
    
    override func setConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(230)
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
        
        favoriteButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.bottom.equalTo(backgroundImageView.snp.bottom).inset(12)
            make.trailing.equalTo(backgroundImageView.snp.trailing).inset(12)
        }
    }
    
    private func bindCell() {
        
        viewModel?.isContainFavoriteList
            .withUnretained(self)
            .bind(onNext: { cell, value in
                cell.updateUI(isSelected: value)
            })
            .disposed(by: disposeBag)
        
        favoriteButton.rx.tap
            .withUnretained(self)
            .bind { cell, _ in
                let newValue = !(cell.viewModel?.isContainFavoriteList.value ?? false)
                newValue ? cell.viewModel?.saveFavoriteMovie(movie: (cell.viewModel?.selectedMovie.value.first!)!) : cell.viewModel?.deleteFavoriteMovie(movieId: (cell.viewModel?.selectedMovie.value.first!.id)!)
                cell.viewModel?.isContainFavoriteList.accept(newValue)
                cell.viewModel?.loadFavoriteMovieList()
            }
            .disposed(by: disposeBag)
        
    }
    
    func updateUI(isSelected: Bool) {
        let buttonImage = isSelected ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        let tintColor = isSelected ? UIColor.red : UIColor.black
        favoriteButton.setImage(buttonImage, for: .normal)
        favoriteButton.tintColor = tintColor
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
    
    func setViewModel(_ viewModel: DetailViewModel) {
        self.viewModel = viewModel
        self.bindCell()
    }
}
