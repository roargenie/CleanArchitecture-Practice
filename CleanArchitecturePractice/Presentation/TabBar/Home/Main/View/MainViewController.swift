//
//  MainViewController.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/07.
//

import UIKit
import RxSwift
import RxCocoa

final class MainViewController: BaseViewController {
    
    private let mainView = MainView()
    private let viewModel: MainViewModel
    private let disposeBag = DisposeBag()
    private var genreList: [Int: String] = [:]
    
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
        navigationItem.backButtonTitle = ""
        navigationItem.title = "영화 목록"
    }
    
    private func bindViewModel() {
        
        let input = MainViewModel.Input(
            viewDidLoadEvent: Observable.just(()).asSignal(onErrorJustReturn: ()),
            itemSelected: mainView.collectionView.rx.modelSelected(MovieResults.self).asSignal())
        let output = viewModel.transform(input: input)
        
        output.genreList
            .drive { [weak self] result in
                result.forEach { self?.genreList.updateValue($0.name, forKey: $0.id) }
            }
            .disposed(by: disposeBag)
            
        output.movieList
            .drive(mainView.collectionView.rx.items) { (cv, index, item) -> UICollectionViewCell in
                guard let cell = cv.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reuseIdentifier, for: IndexPath.init(item: index, section: 0)) as? MainCollectionViewCell else { return UICollectionViewCell() }
                cell.setupCell(data: item, genre: self.genreList)
                return cell
            }
            .disposed(by: disposeBag)
            
    }
    
}

