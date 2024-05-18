//
//  ClassListViewModel.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/15.
//

import Foundation
import Combine

@MainActor
class ClassListViewModel: ViewModelType {
    
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()

    @Published
    var output = Output()

    init() {
        transform()
    }
}


extension ClassListViewModel {
    struct Input { //viewOnAppear
        var viewOnAppear = PassthroughSubject<Void, Never>()
    }
    
    struct Output { //post
        var post: ClassList = []
    }
    
    enum Action {
        case viewOnAppear
    }
    
    func action(_ action: Action) {
        switch action {
        case .viewOnAppear:
            input.viewOnAppear.send(())
        }
    }
    
    func transform() {
        input.viewOnAppear
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
