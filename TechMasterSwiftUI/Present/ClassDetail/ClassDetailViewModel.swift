//
//  ClassDetailViewModel.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/15.
//

import Foundation
import Combine

protocol LoadThisPost: AnyObject {
    var postID: String{get set}
}

@MainActor
final class ClassDetailViewModel: ViewModelType, LoadThisPost {

    var cancellables = Set<AnyCancellable>()
    
    var postID: String
    
    var input = Input()

    @Published
    var output = Output()

    init(postID: String) {
        self.postID = postID
        transform()
    }
}


extension ClassDetailViewModel {
    struct Input { //viewOnAppear
        var viewOnAppear = PassthroughSubject<Void, Never>()
    }
    
    struct Output { //post
        var post: ClassModel!
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
            try await Network.shared.myAPICall(model: ThisClassResponseDTO.self, router: PostRouter.getThisPost(id: self.postID))
                .sink(receiveCompletion: { result in
                    switch result{
                    case .finished:
                        print("Fetch Success")
                    case .failure:
                        print("Fetch Failed")
                    }
                }, receiveValue: { resultPost in
                    self.output.post = resultPost.toDomain()
                }).store(in: &cancellables)
        } catch {
            print("실패~")
        }
    }

}
