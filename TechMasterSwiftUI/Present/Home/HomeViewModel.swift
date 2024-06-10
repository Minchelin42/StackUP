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

    var homeRepository: DataRepository
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()

    @Published
    var output = Output()

    init(homeRepository: DataRepository = HomeRepository()) {
        self.homeRepository = homeRepository
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
                homeRepository.fetchData { result in
                    print("homeRepository를 이용해서 클래스 목록을 불러오고있음")
                    self.output.post = result
                }
            }
            .store(in: &cancellables)
    }
    
}
