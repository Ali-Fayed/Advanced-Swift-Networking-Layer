//
//  ViewModel.swift
//  Advanced Networking Layer
//
//  Created by Ali Fayed on 12/11/2021.
//

class NewsViewModel: NewsViewModelProtocol {
    private let useCases = NewsUseCases.shared
    var newsList = [Post]()
    var page = 0
    var newListCount: Int {
        return newsList.count
    }
    //MARK: - Methods
    func fetchNews() async -> (Result<[Post], Error>) {
        let results = await useCases.fetchNewsToViewModel(page: page, perPage: 30, query: "")
        switch results {
        case .success(let model):
            newsList.append(contentsOf: model.hits)
            return .success(model.hits)
        case .failure(let error):
            return .failure(error)
        }
    }
    func loadMoreNews(indexPathRow: Int, completion: @escaping ()->()) {
        if indexPathRow == newListCount - 1 {
            page+=1
            completion()
        }
    }
}
