//
//  ClassReviewInfoViewModel.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/18.
//

import Foundation
import Combine

typealias PostID = String

@MainActor
final class ClassReviewInfoViewModel: ViewModelType, LoadThisPost{

    var postID: PostID
    var cancellables = Set<AnyCancellable>()

    var input = Input()
    
    @Published
    var output = Output()
    
    init(postID: PostID) {
        self.postID = postID
        transform()
    }
}



extension ClassReviewInfoViewModel {
    
    struct Input {
        var loadClassReview = PassthroughSubject<String, Never>()
    }
    
    struct Output {
        var review: ReviewList = []
    }
    
    enum Action {
        case loadClassReview
    }
    
    func action(_ action: Action) {
        switch action {
        case .loadClassReview:
            input.loadClassReview.send(postID)
        }
    }
    
    func transform() {
        input.loadClassReview
            .sink { [weak self] postID in
                guard let self else { return }
                Task {
                    await self.fetchReview()
                }
            }
            .store(in: &cancellables)
    }
    
    func fetchReview() async {
        do {
            try await Network.shared.myAPICall(model: ReviewListResponseDTO.self, router: PostRouter.getPost(productID: "\(postID)_review"))
                .sink(receiveCompletion: { result in
                    switch result{
                    case .finished:
                        print("Fetch Success")
                    case .failure:
                        print("Fetch Failed")
                    }
                }, receiveValue: { resultPost in
                    self.output.review = resultPost.toDomain()
                }).store(in: &cancellables)
        } catch {
            output.review = []
        }
    }

}
