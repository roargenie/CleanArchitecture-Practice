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
    private var movieData = [MovieResults]()
    
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
    
    private func bindViewModel() {
        
        let input = MainViewModel.Input(
            viewDidLoadEvent: Observable.just(()).asSignal(onErrorJustReturn: ()))
        let output = viewModel.transform(input: input)
        
        output.movieList
            .drive(mainView.collectionView.rx.items) { (cv, index, item) -> UICollectionViewCell in
                guard let cell = cv.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reuseIdentifier, for: IndexPath.init(item: index, section: 0)) as? MainCollectionViewCell else { return UICollectionViewCell() }
                cell.setupCell(data: item)
                return cell
            }
            .disposed(by: disposeBag)
            
    }
    
}

