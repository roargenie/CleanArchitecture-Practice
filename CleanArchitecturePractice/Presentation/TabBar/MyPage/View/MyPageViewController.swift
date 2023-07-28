//
//  MyPageViewController.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/28.
//

import UIKit

final class MyPageViewController: BaseViewController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
    
    override func configureUI() {
        navigationItem.backButtonTitle = ""
        navigationItem.title = "관심 목록"
    }
}
