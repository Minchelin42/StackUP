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
    
    var input = Input()

    @Published
    var output = Output()

    init() {
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
        var review: ReviewList = []
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
                Task {
                    await self.fetchProfile()
                }
            }
            .store(in: &cancellables)
        
        input.loadReviewList
            .sink { [weak self] reviewList in
                guard let self else { return }
                for review in reviewList {
                    Task {
                        await self.fetchReview(id: review)
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func fetchReview(id: String) async {
        do {
            try await Network.shared.myAPICall(model: ReviewModel.self, router: PostRouter.getThisPost(id: id))
                .sink { result in
                    switch result{
                    case .finished:
                        print("Fetch Success")
                    case .failure:
                        print("Fetch Failed")
                        print(result.self)
                    }
                } receiveValue: { [weak self] resultReview in
                    guard let self else { return }
                    self.output.review.append(resultReview)
                }
                .store(in: &cancellables)
        } catch {
            print("으아악 실패")
        }
    }
    
    func fetchProfile() async {
        do {
            try await Network.shared.myAPICall(model: ProfileModel.self, router: ProfileRouter.myProfile)
                .sink { result in
                    switch result{
                    case .finished:
                        print("Fetch Success")
                    case .failure:
                        print("Fetch Failed")
                        print(result.self)
                    }
                } receiveValue: { [weak self] resultProfile in
                    guard let self else { return }
                    self.output.review.removeAll()
                    self.input.loadReviewList.send(resultProfile.review)
                    self.output.profile = resultProfile
                }
                .store(in: &cancellables)
        } catch {
            print("으아악 실패")
        }
    }


}
