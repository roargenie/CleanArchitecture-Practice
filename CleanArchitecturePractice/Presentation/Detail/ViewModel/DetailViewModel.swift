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
    let selectedMovie = BehaviorRelay<[MovieResults]>(value: [])
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
                self.makeSectionModel(response: response)
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
    
    private func makeToSectionModelType(response: CastResponse) -> [[MovieSectionItem]] {
        let overviewSection = selectedMovie.value.map {
            MovieSectionItem.OverviewItem(response: $0)
        }
        let castSection = response.cast.map {
            MovieSectionItem.CastviewItem(response: $0)
        }
        return [overviewSection, castSection]
    }
    
    private func makeSectionModel(response: CastResponse) {
        let sectionData = makeToSectionModelType(response: response)
        let overviewData = MovieSectionModel.overview(header: "Overview", items: sectionData[0])
        let castData = MovieSectionModel.cast(header: "Cast", items: sectionData[1])
        self.sections.append(overviewData)
        self.sections.append(castData)
        self.movieList.accept(sections)
    }
    
    func datsSource() -> RxTableViewSectionedReloadDataSource<MovieSectionModel> {
        let dataSource = RxTableViewSectionedReloadDataSource<MovieSectionModel>(configureCell: { dataSource, tableView, indexPath, item in
            
            switch item {
            case .OverviewItem(response: let data):
                let cell = tableView.dequeueReusableCell(withIdentifier: OverViewTableViewCell.reuseIdentifier, for: indexPath) as! OverViewTableViewCell
                cell.overviewLabel.text = data.overview
                return cell
            case .CastviewItem(response: let data):
                let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.reuseIdentifier, for: indexPath) as! CastTableViewCell
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
