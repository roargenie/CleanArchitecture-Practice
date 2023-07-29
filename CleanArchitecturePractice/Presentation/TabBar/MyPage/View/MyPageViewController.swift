//
//  MyPageViewController.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/28.
//

import UIKit
import RxSwift
import RxCocoa

final class MyPageViewController: BaseViewController {
    
    private let mainView = MyPageView()
    private let viewModel: MyPageViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: MyPageViewModel) {
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
        navigationItem.title = "관심 목록"
    }
    
    private func bindViewModel() {
        
        let input = MyPageViewModel.Input(
            viewDidLoadEvent: Observable.just(()).asSignal(onErrorJustReturn: ()),
            viewWillAppearEvent: Observable.just(()).asSignal(onErrorJustReturn: ()))
        let output = viewModel.transform(input: input)
        
        output.favoriteMovieList
            .drive(mainView.collectionView.rx.items) { (cv, index, item) -> UICollectionViewCell in
                guard let cell = cv.dequeueReusableCell(withReuseIdentifier: MyPageCollectionViewCell.reuseIdentifier, for: IndexPath(item: index, section: 0)) as? MyPageCollectionViewCell else { return UICollectionViewCell() }
                print("=========item정보=========", item)
                cell.setupCell(data: item)
                return cell
            }
            .disposed(by: disposeBag)
        
        
    }
    
    
    
}
