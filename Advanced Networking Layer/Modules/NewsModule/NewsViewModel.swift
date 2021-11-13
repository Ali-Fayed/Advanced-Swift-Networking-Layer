//
//  ViewModel.swift
//  Advanced Networking Layer
//
//  Created by Ali Fayed on 12/11/2021.
//

class NewsViewModel: NewsViewModelProtocol {
    let useCases = NewsUseCases.shared
    var newsList = [Post]()
    var newListCount: Int {
        return newsList.count
    }
    //MARK: - Methods
    func fetchNews() async -> (Result<[Post], Error>) {
        let results = await useCases.fetchNewsToViewModel()
        switch results {
        case .success(let model):
            newsList = model.hits
            return .success(model.hits)
        case .failure(let error):
            return .failure(error)
        }
    }
}
