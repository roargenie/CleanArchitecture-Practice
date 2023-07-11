//
//  DetailViewController.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/10.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class DetailViewController: BaseViewController {
    
    private let mainView = DetailView()
    let viewModel: DetailViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: DetailViewModel) {
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
//        mainView.tableView.delegate = self
//        mainView.tableView.dataSource = self
//        mainView.tableView.rx.setDelegate(self).disposed(by: disposeBag)
        mainView.setupHeaderView(data: viewModel.selectedMovie.value.first!)
    }
    
    private func bindViewModel() {
        
        let input = DetailViewModel.Input(
            viewDidLoadEvent: Observable.just(()).asSignal(onErrorJustReturn: ()))
        let output = viewModel.transform(input: input)
            
        output.movieList
            .drive(mainView.tableView.rx.items(dataSource: viewModel.datsSource()))
            .disposed(by: disposeBag)
        
        
    }
}
