//
//  OverViewTableViewCell.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/10.
//

import UIKit
import RxSwift
import RxRelay

final class OverViewTableViewCell: BaseTableViewCell {
    
    let moreViewButtonIsSelected = BehaviorRelay<Bool>(value: false)
    private var viewModel: DetailViewModel?
    private let disposeBag = DisposeBag()
    
    let overviewLabel: UILabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
    }
    
    let moreViewButton: UIButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        $0.tintColor = .black
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bindCell()
    }
    
    override func configureUI() {
        [overviewLabel, moreViewButton].forEach { contentView.addSubview($0) }
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
    
//    func updateConstraints(isSelected: Bool) {
//        if isSelected {
//            overviewLabel.snp.removeConstraints()
//            overviewLabel.snp.makeConstraints { make in
//                make.top.equalToSuperview().offset(4)
//                make.horizontalEdges.equalToSuperview().inset(12)
//                make.height.equalTo(100)
//            }
//        } else {
//            overviewLabel.snp.removeConstraints()
//            overviewLabel.snp.makeConstraints { make in
//                make.top.equalToSuperview().offset(4)
//                make.horizontalEdges.equalToSuperview().inset(12)
//                make.height.equalTo(30)
//            }
//        }
//    }
    
    private func bindCell() {
        moreViewButton.rx.tap
            .withUnretained(self)
            .bind { cell, _ in
                cell.moreViewButtonIsSelected.accept(!cell.moreViewButtonIsSelected.value)
            }
            .disposed(by: disposeBag)
        
        moreViewButtonIsSelected
            .withUnretained(self)
            .bind { cell, value in
                cell.viewModel?.moreViewButtonIsSelected.accept(value)
                cell.updateUI(isSelected: value)
            }
            .disposed(by: disposeBag)
        
    }
    
    func updateUI(isSelected: Bool) {
        let buttonImage = isSelected ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
        moreViewButton.setImage(buttonImage, for: .normal)
        overviewLabel.numberOfLines = isSelected ? 0 : 2
//        updateConstraints(isSelected: isSelected)
//        layoutIfNeeded()
    }
    
    func setViewModel(_ viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
    
}
