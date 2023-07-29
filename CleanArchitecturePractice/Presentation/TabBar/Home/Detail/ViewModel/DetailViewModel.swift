//
//  DetailViewModel.swift
//  CleanArchitecturePractice
//
//  Created by 이명진 on 2023/07/10.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailViewModel: CommonViewModelType {
    
    private var sections: [MovieSectionModel] = []
    private var realmData: FavoriteListRealmDTO
    private let detailUseCase: DetailUseCase
    
    struct Input {
        let viewDidLoadEvent: Signal<Void>
    }
    
    struct Output {
        let movieList: Driver<[MovieSectionModel]>
        let moreViewButtonIsSelected: Signal<Bool>
    }
    
    init(detailUseCase: DetailUseCase, realmData: FavoriteListRealmDTO) {
        self.detailUseCase = detailUseCase
        self.realmData = realmData
    }
    var disposeBag = DisposeBag()
    
    private let movieList = BehaviorRelay<[MovieSectionModel]>(value: [])
    let selectedMovie = BehaviorRelay<[MovieResults]>(value: [])
    let moreViewButtonIsSelected = PublishRelay<Bool>()
    let isContainFavoriteList = BehaviorRelay<Bool>(value: false)
    
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
            movieList: movieList.asDriver(),
            moreViewButtonIsSelected: moreViewButtonIsSelected.asSignal())
    }
    
}

extension DetailViewModel {
    
    private func requestCast() {
        guard let id = selectedMovie.value.first?.id else { return }
        self.filterMovieId(movieId: id)
        self.detailUseCase.requestCast(id: id)
    }
    
    func saveFavoriteMovie(movie: MovieResults) {
        print("=============== 관심 목록에 저장됨.⭐️=========")
        self.detailUseCase.saveFavoriteMovie(movie: movie)
    }
    
    func deleteFavoriteMovie(movieId: Int) {
        print("=============== 관심 목록에서 삭제됨.⭐️=========")
        self.detailUseCase.deleteFavoriteMovie(movieId: movieId)
    }
    
    // 좋아요 버튼 색상을 나타내기 위해 Realm과 API정보를 비교하는 메서드
    private func filterMovieId(movieId: Int) {
        let result = self.detailUseCase.filterMovieId(movieId: movieId)
        self.isContainFavoriteList.accept(result)
    }
    
    private func makeToSectionModelType(response: CastResponse) -> [[MovieSectionItem]] {
        let headerviewSection = selectedMovie.value.map {
            MovieSectionItem.HeaderviewItem(response: $0)
        }
        let overviewSection = selectedMovie.value.map {
            MovieSectionItem.OverviewItem(response: $0)
        }
        let castSection = response.cast.map {
            MovieSectionItem.CastviewItem(response: $0)
        }
        return [headerviewSection, overviewSection, castSection]
    }
    
    private func makeSectionModel(response: CastResponse) {
        let sectionData = makeToSectionModelType(response: response)
        let headerviewData = MovieSectionModel.headerview(
            items: sectionData[0])
        let overviewData = MovieSectionModel.overview(
            header: "Overview",
            items: sectionData[1])
        let castData = MovieSectionModel.cast(
            header: "Cast",
            items: sectionData[2])
        self.sections.append(headerviewData)
        self.sections.append(overviewData)
        self.sections.append(castData)
        self.movieList.accept(sections)
    }
    
}
