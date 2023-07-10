//
//  DetailViewModel.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/10.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

final class DetailViewModel: CommonViewModelType {
    
    private let detailUseCase: DetailUseCase
    
    struct Input {
        let viewDidLoadEvent: Signal<Void>
    }
    
    struct Output {
        let movieList: Driver<[MovieSectionModel]>
    }
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
    }
    var disposeBag = DisposeBag()
    
    private let movieList = BehaviorRelay<[MovieSectionModel]>(value: [])
    
    func transform(input: Input) -> Output {
        
        input.viewDidLoadEvent
            .emit { [weak self] in
                print("=====🔥DetailViewModel=====")
            }
            .disposed(by: disposeBag)
        
        return Output(movieList: movieList.asDriver())
    }
    
}

extension DetailViewModel {
    
    func datsSource() -> RxTableViewSectionedReloadDataSource<MovieSectionModel> {
        let dataSource = RxTableViewSectionedReloadDataSource<MovieSectionModel>(configureCell: { dataSource, tableView, indexPath, item in
            
            switch item {
            case .overview(let item):
                let cell = tableView.dequeueReusableCell(withIdentifier: OverViewTableViewCell.reuseIdentifier, for: indexPath) as! OverViewTableViewCell
                cell.overviewLabel.text = item.movies.overview
                return cell
            case .cast(let item):
                let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.reuseIdentifier, for: indexPath) as! CastTableViewCell
                cell.nameLabel.text = item.cast[indexPath.row].name
                cell.characterLabel.text = item.cast[indexPath.row].character
                return cell
            }
            
        })
        
        dataSource.titleForHeaderInSection = { dataSource, indexPath in
            return MovieSection(index: indexPath).headerTitle
        }
        
        return dataSource
    }
}
