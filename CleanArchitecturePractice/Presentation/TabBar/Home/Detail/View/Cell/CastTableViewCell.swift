//
//  CastTableViewCell.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/10.
//

import UIKit

final class CastTableViewCell: BaseTableViewCell {
    
    let castImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 45
    }
    
    let nameLabel: UILabel = UILabel().then {
        $0.text = "Chris Pratt"
        $0.font = .systemFont(ofSize: 16)
    }
    
    let characterLabel: UILabel = UILabel().then {
        $0.text = "Peter Quill"
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .gray
    }
    
    lazy var labelStackView: UIStackView = UIStackView(arrangedSubviews: [nameLabel, characterLabel]).then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .fillEqually
        $0.alignment = .fill
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureUI() {
        [castImageView, labelStackView].forEach { addSubview($0) }
    }
    
    override func setConstraints() {
        castImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.verticalEdges.equalToSuperview().inset(8)
            make.height.equalTo(90)
            make.width.equalTo(self.snp.height)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.centerY.equalTo(castImageView.snp.centerY)
            make.leading.equalTo(castImageView.snp.trailing).offset(16)
            make.trailing.greaterThanOrEqualToSuperview().inset(16)
        }
    }
    
    func setupCell(data: CastResults) {
        nameLabel.text = data.name
        characterLabel.text = data.character
        
        let url = "https://image.tmdb.org/t/p/w220_and_h330_face"
        if let profilePath = data.profile_path {
            loadImage(urlString: "\(url)\(profilePath)") { [weak self] image in
                self?.castImageView.image = image
            }
        }
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

