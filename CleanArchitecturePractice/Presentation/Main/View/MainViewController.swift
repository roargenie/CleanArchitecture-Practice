//
//  MainViewController.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/07.
//

import UIKit

final class MainViewController: BaseViewController {
    
    private let mainView = MainView()
    private let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        
    }
    
    override func configureUI() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    private func bindViewModel() {
        
        let input = MainViewModel.Input()
        let output = viewModel.transform(input: input)
        
        
        
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reuseIdentifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
}
