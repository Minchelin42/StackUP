//
//  MyClassListViewModel.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/19.
//

import Foundation
import Combine

@MainActor
class MyClassListViewModel: ViewModelType {
    
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()

    @Published
    var output = Output()

    init() {
        transform()
    }
}


extension MyClassListViewModel {
    struct Input {
        var getScrapList = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var scrap: ClassList = []
    }
    
    enum Action {
        case getScrapList
    }
    
    func action(_ action: Action) {
        switch action {
        case .getScrapList:
            input.getScrapList.send(())
        }
    }
    
    func transform() {
        input.getScrapList
            .sink { [weak self] _ in
                guard let self else { return }
                Task {
                    await self.getScrapList()
                }
            }
            .store(in: &cancellables)
    }
    
    func getScrapList() async {
        do {
            try await Network.shared.myAPICall(model: GetScrapModel.self, router: PostRouter.getScrapPost)
                .sink(receiveCompletion: { result in
                    switch result{
                    case .finished:
                        print("Fetch Success")
                    case .failure:
                        print("Fetch Failed")
                        print(result.self)
                    }
                }, receiveValue: { resultScrap in
                    self.output.scrap = resultScrap.data
                    dump(self.output.scrap)
                }).store(in: &cancellables)
        } catch {
            output.scrap = []
        }
    }

}
