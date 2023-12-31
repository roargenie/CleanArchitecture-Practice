//
//  DetailView.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/10.
//

import UIKit

final class DetailView: BaseView {
    
//    let tableHeaderView: UIView = DetailHeaderView().then {
//        $0.frame = CGRect(x: 0, y: 0, width: $0.bounds.width, height: 230)
//    }
    
    lazy var tableView: UITableView = UITableView(frame: .zero, style: .plain).then {
//        $0.tableHeaderView = tableHeaderView
        $0.register(HeaderViewTableViewCell.self, forCellReuseIdentifier: HeaderViewTableViewCell.reuseIdentifier)
        $0.register(OverViewTableViewCell.self, forCellReuseIdentifier: OverViewTableViewCell.reuseIdentifier)
        $0.register(CastTableViewCell.self, forCellReuseIdentifier: CastTableViewCell.reuseIdentifier)
        $0.estimatedRowHeight = UITableView.automaticDimension
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        addSubview(tableView)
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
//    func setupHeaderView(data: MovieResults) {
//        if let headerView = tableHeaderView as? DetailHeaderView {
//            headerView.setupHeaderView(data: data)
//        }
//    }
    
}
