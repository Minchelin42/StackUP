//
//  LoginViewModel.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/17.
//

import Foundation
import Combine

@MainActor
final class LoginViewModel: ViewModelType {
    
    @Published var id = ""
    @Published var password = ""
    
    @Published var alertPresent: Bool = false

    var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    var output = Output()
    
    init() {
        transform()
    }

}

extension LoginViewModel {
    
    struct Input {
        var loginButtonTapped = PassthroughSubject<LoginQuery, Never>()
    }
    
    struct Output {
        var loginSuccess: Bool = false
        var alertMessage: String = ""
    }
    
    enum Action {
        case loginButtonTapped
    }
    
    func action(_ action: Action) {
        switch action {
        case .loginButtonTapped:
            print(self.id, self.password)
            input.loginButtonTapped.send(LoginQuery(id: self.id, password: self.password))
        }
    }
    
    func transform() {
        input.loginButtonTapped
            .sink { [weak self] query in
                guard let self else { return }
                print("로그인 버튼 클릭")
                print("query: ", query)
                Task {
                    await self.login(query: query)
                }
            }
            .store(in: &cancellables)
    }
      
    func login(query: LoginQuery) async {
        do {
            try await Network.shared.myAPICall(model: LoginResponseDTO.self, router: UserRouter.login(query: query))
                .sink(receiveCompletion: { result in
                    switch result{
                    case .finished:
                        print("Fetch Success")
                        self.output.loginSuccess = true
                    case .failure:
                        print("Fetch Failed")
                        print(result.self)
                        self.output.loginSuccess = false
                        self.output.alertMessage = "로그인 정보를 다시 확인해주세요"
                        self.alertPresent = true
                    }
                }, receiveValue: { [weak self] response in
                    guard let self else { return }
                    let result = response.toDomain()
                    self.output.alertMessage = "환영합니다 \(result.nick)님"
                    NowUser.userID = result.user_id
                    NowUser.accessToken = result.accessToken
                    NowUser.refreshToken = result.refreshToken
                    self.alertPresent = true
                }).store(in: &cancellables)
        } catch {
            self.output.loginSuccess = false
        }
   
    }
        
}
