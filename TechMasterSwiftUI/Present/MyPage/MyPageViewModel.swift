//
//  MyPageViewModel.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/21.
//

import Foundation
import Combine

@MainActor
final class MyPageViewModel: ViewModelType {

    var cancellables = Set<AnyCancellable>()
    
    var profileRepository: DataRepository
    var reviewRepository: DataRepository
    
    var input = Input()

    @Published
    var output = Output()

    init(profileRepository: DataRepository = ProfileRepository(),
         reviewRepository: DataRepository = ReviewRepository()) {
        self.profileRepository = profileRepository
        self.reviewRepository = reviewRepository
        transform()
    }
}

extension MyPageViewModel {
 
    struct Input {
        var loadMyProfileInfo = PassthroughSubject<Void, Never>()
        var loadReviewList = PassthroughSubject<[String], Never>()
        var loadReviewInfo = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var profile: ProfileModel!
        var review: [ReviewModel] = []
    }
    
    enum Action {
        case loadMyProfileInfo
    }
    
    func action(_ action: Action) {
        switch action {
        case .loadMyProfileInfo:
            input.loadMyProfileInfo.send(())
        }
    }
    
    func transform() {
        input.loadMyProfileInfo
            .sink { [weak self] _ in
                guard let self else { return }
                profileRepository.fetchData { (profile: ProfileModel) in
                    self.output.review.removeAll()
                    self.input.loadReviewList.send(profile.review)
                    self.output.profile = profile
                }
            }
            .store(in: &cancellables)
        
        input.loadReviewList
            .sink { [weak self] reviewList in
                guard let self else { return }
                for review in reviewList {
                    reviewRepository.router = PostRouter.getThisPost(id: review)
                    reviewRepository.fetchData { review in
                        self.output.review.append(review)
                    }
                }
            }
            .store(in: &cancellables)
    }
    

}
