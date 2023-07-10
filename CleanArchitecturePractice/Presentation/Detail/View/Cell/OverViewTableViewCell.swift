//
//  OverViewTableViewCell.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/10.
//

import UIKit

final class OverViewTableViewCell: BaseTableViewCell {
    
    let overviewLabel: UILabel = UILabel().then {
        $0.numberOfLines = 2
        $0.font = .systemFont(ofSize: 14)
    }
    
    let moreViewButton: UIButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.down"), for: .normal)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureUI() {
        [overviewLabel, moreViewButton].forEach { addSubview($0) }
    }
    
    override func setConstraints() {
        overviewLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.horizontalEdges.equalToSuperview().inset(12)
        }
        
        moreViewButton.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(8)
            make.centerX.equalTo(overviewLabel.snp.centerX)
            make.width.equalTo(40)
            make.height.equalTo(24)
        }
    }
}
