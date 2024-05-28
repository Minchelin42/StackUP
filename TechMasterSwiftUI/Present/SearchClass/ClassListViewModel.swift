//
//  ClassListViewModel.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/15.
//

import Foundation
import Combine

@MainActor
final class ClassListViewModel: ViewModelType {
    
    @Published var search = ""
    
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()

    @Published
    var output = Output()

    init() {
        transform()
    }
}


extension ClassListViewModel {
    struct Input {
        var searchClass = PassthroughSubject<Void, Never>()
        var searchRecommand = PassthroughSubject<String, Never>()
        var removeOutput = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var post: ClassList = []
        var isSearching: Bool = false
    }
    
    enum Action {
        case searchClass
        case searchRecommand(search: String)
        case removeOutput
    }
    
    func action(_ action: Action) {
        switch action {
        case .searchClass:
            input.searchClass.send(())
        case .searchRecommand(let search):
            input.searchRecommand.send(search)
        case .removeOutput:
            input.removeOutput.send(())
        }
    }
    
    func transform() {
        
        input.searchClass
            .sink { [weak self] _ in
                guard let self else { return }
                output.post.removeAll()
                Task {
                    await self.fetchSearchClass(search: self.search)
                }
            }
            .store(in: &cancellables)
        
        input.searchRecommand
            .sink { [weak self] search in
                guard let self else { return }
                output.isSearching = true
                self.search = search
                output.post.removeAll()
                
                Task {
                    await self.fetchSearchClass(search: search)
                }
            }
            .store(in: &cancellables)
        
        input.removeOutput
            .sink { [weak self] _ in
                guard let self else { return }
                self.output.post.removeAll()
            }
            .store(in: &cancellables)
    }
    
    func fetchSearchClass(search: String) async {
        do {
            try await Network.shared.myAPICall(model: ClassListResponseDTO.self, router: PostRouter.searchPost(search: search))
                .sink(receiveCompletion: { result in
                    switch result{
                    case .finished:
                        print("Fetch Success")
                    case .failure:
                        print("Fetch Failed")
                        print(result.self)
                    }
                }, receiveValue: { result in
                    let resultPost = result.toDomain()
                    self.output.post = resultPost
                }).store(in: &cancellables)
        } catch {
            output.post = []
        }
    }
    
    func recommandVisiable() -> Bool {
        if !output.isSearching || search.isEmpty {
            return true
        } else { return false }
    }
}
