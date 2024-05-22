//
//  HomeViewModel.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/23.
//

import Foundation
import Combine

@MainActor
final class HomeViewModel: ViewModelType {
    @Published var search = ""
    
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()

    @Published
    var output = Output()

    init() {
        transform()
    }
}

extension HomeViewModel {
    struct Input {
        var loadClass = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var post: ClassList = []
    }
    
    enum Action {
        case loadClass
    }
    
    func action(_ action: Action) {
        switch action {
        case .loadClass:
            input.loadClass.send(())
        }
    }
    
    func transform() {
        input.loadClass
            .sink { [weak self] _ in
                guard let self else { return }
                Task {
                    await self.fetchPost()
                }
            }
            .store(in: &cancellables)
    }

    
    func fetchPost() async {
        do {
            try await Network.shared.myAPICall(model: GetClassModel.self, router: PostRouter.getPost(productID: ""))
                .sink(receiveCompletion: { result in
                    switch result{
                    case .finished:
                        print("Fetch Success")
                    case .failure:
                        print("Fetch Failed")
                        print(result.self)
                    }
                }, receiveValue: { resultPost in
                    self.output.post = resultPost.data
                }).store(in: &cancellables)
        } catch {
            output.post = []
        }
    }

}
