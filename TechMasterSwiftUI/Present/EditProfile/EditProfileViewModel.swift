//
//  EditProfileViewModel.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/22.
//

import Foundation
import Combine

@MainActor
final class EditProfileViewModel: ViewModelType {

    @Published var nickname: String
    @Published var id: String
    var profileImg: String
    
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()

    @Published
    var output = Output()

    init(nickname: String, id: String, profileImg: String) {
        self.nickname = nickname
        self.id = id
        self.profileImg = profileImg
        transform()
    }
}


extension EditProfileViewModel {
    struct Input {
        var editProfileButtonTapped = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
   
    }
    
    enum Action {
        case editProfileButtonTapped
    }
    
    func action(_ action: Action) {
        switch action {
        case .editProfileButtonTapped:
            input.editProfileButtonTapped.send(())
        }
    }
    
    func transform() {
        input.editProfileButtonTapped
            .sink { [weak self] _ in
                guard let self else { return }
                Task { await self.editProfile(query: ProfileQuery(nick: self.nickname)) }
            }
            .store(in: &cancellables)
    }
    
    func editProfile(query: ProfileQuery) async {
        do {
            try await Network.shared.multipartAPICall(model: ProfileModel.self, router: ProfileRouter.editProfile, query: query)
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
                    print(resultProfile)
                }
                .store(in: &cancellables)
        } catch {
            print("edit Profile 실패")
        }
    }
    
}

