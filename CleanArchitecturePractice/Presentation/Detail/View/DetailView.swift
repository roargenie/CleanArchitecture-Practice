//
//  DetailView.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/10.
//

import UIKit

final class DetailView: BaseView {
    
    let tableHeaderView: UIView = DetailHeaderView().then {
        $0.frame = CGRect(x: 0, y: 0, width: $0.bounds.width, height: 220)
    }
    
    lazy var tableView: UITableView = UITableView(frame: .zero, style: .plain).then {
        $0.tableHeaderView = tableHeaderView
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
    
    
}
