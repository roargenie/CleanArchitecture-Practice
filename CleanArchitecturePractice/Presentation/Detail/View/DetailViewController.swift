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
        mainView.setupHeaderView(data: viewModel.selectedMovie.value.first!)
        mainView.tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        
        let input = DetailViewModel.Input(
            viewDidLoadEvent: Observable.just(()).asSignal(onErrorJustReturn: ()))
        let output = viewModel.transform(input: input)
            
        output.movieList
            .drive(mainView.tableView.rx.items(dataSource: dataSource()))
            .disposed(by: disposeBag)
        
        output.moreViewButtonIsSelected
            .withUnretained(self)
            .emit { vc, _ in
                vc.mainView.tableView.reloadData()
            }
            .disposed(by: disposeBag)
    }
    
    private func dataSource() -> RxTableViewSectionedReloadDataSource<MovieSectionModel> {
        let dataSource = RxTableViewSectionedReloadDataSource<MovieSectionModel>(configureCell: {  dataSource, tableView, indexPath, item in
            switch item {
            case .OverviewItem(response: let data):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: OverViewTableViewCell.reuseIdentifier, for: indexPath) as? OverViewTableViewCell else { return UITableViewCell() }
                cell.overviewLabel.text = data.overview
                cell.setViewModel(self.viewModel)
                return cell
            case .CastviewItem(response: let data):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.reuseIdentifier, for: indexPath) as? CastTableViewCell else { return UITableViewCell() }
                cell.setupCell(data: data)
                return cell
            }
            
        })
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].headers
        }
        
        return dataSource
    }
}

extension DetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {

        switch indexPath.section {
        case 0:
            return UITableView.automaticDimension
        default:
            return UITableView.automaticDimension
        }
        
    }

}
