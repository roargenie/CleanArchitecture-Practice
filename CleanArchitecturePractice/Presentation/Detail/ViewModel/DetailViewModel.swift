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
    
    var sections: [MovieSectionModel] = []
    
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
    
    let movieList = BehaviorRelay<[MovieSectionModel]>(value: [])
    let selectedMovie = BehaviorRelay<[MovieList]>(value: [])
    let castList = BehaviorRelay<[CastResults]>(value: [])
    
    func transform(input: Input) -> Output {
        
        input.viewDidLoadEvent
            .emit(onNext: { [weak self] in
                print("=====🔥DetailViewModel=====")
                guard let self = self else { return }
                self.requestCast()
            })
            .disposed(by: disposeBag)
        
        detailUseCase.successCastSignal
            .asSignal()
            .emit { [weak self] response in
                guard let self = self else { return }
                self.sections.append(.overview(
                    header: "Overview",
                    items: [OverviewSection(items: self.selectedMovie.value)]))
                self.sections.append(.cast(
                    header: "Cast",
                    items: [CastSection(items: response.cast)]))
                print("Sections=================✅")
                dump(self.sections[1].items)
                self.movieList.accept(sections)
            }
            .disposed(by: disposeBag)
        
        return Output(
            movieList: movieList.asDriver())
    }
    
}

extension DetailViewModel {
    
    private func requestCast() {
        guard let id = selectedMovie.value.first?.id else { return }
        self.detailUseCase.requestCast(id: id)
    }
    
    func datsSource() -> RxTableViewSectionedReloadDataSource<MovieSectionModel> {
        let dataSource = RxTableViewSectionedReloadDataSource<MovieSectionModel>(configureCell: { dataSource, tableView, indexPath, item in
            
            switch dataSource[indexPath.section] {
            case .overview(header: _, items: let items):
                let cell = tableView.dequeueReusableCell(withIdentifier: OverViewTableViewCell.reuseIdentifier, for: indexPath) as! OverViewTableViewCell
                cell.overviewLabel.text = items.first?.items.first?.overview
                return cell
            case .cast(header: _, items: let items):
                let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.reuseIdentifier, for: indexPath) as! CastTableViewCell
                cell.setupCell(data: (items.first?.items[indexPath.item])!)
                
                return cell
            }
            
        })
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].headers
        }
        
        return dataSource
    }
}
