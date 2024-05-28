//
//  JoinViewModel.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/16.
//

import Foundation
import Combine

@MainActor
final class JoinViewModel: ViewModelType {
    
    @Published var id = "" {
        didSet(inputID) {
            if self.id != inputID {
                print(self.id)
                input.inputUserID.send(self.id)
            }
        }
    }
    @Published var password = "" {
        didSet(inputPW) {
            input.inputUserPW.send(inputPW)
        }
    }
    @Published var nickname = "" {
        didSet(inputNick) {
            input.inputUserNick.send(inputNick)
        }
    }
    
    @Published private var idAvailiable = false
    @Published private var pwAvailiable = false
    @Published private var nickAvailiable = false
    
    @Published var alertPresent = false
    
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    var output = Output()
    
    init() {
        transform()
    }
    
}

extension JoinViewModel {
    struct Input {
        var inputUserID = PassthroughSubject<String, Never>()
        var inputUserPW = PassthroughSubject<String, Never>()
        var inputUserNick = PassthroughSubject<String, Never>()
        var duplicateCheck = PassthroughSubject<String, Never>()
        var joinConditionCheck = PassthroughSubject<Void, Never>()
        var joinButtonTapped = PassthroughSubject<JoinQuery, Never>()
    }
    
    struct Output {
        var idValid: String = ""
        var pwValid: String = ""
        var nickValid: String = ""
        var duplicateCheck: Bool = false
        var joinAvailable: Bool = false
        var joinSuccess: String = ""
        var alertMessage: String = ""
        var post: ClassList = []
    }
    
    enum Action {
        case duplicateCheck
        case joinButtonTapped
    }
    
    func action(_ action: Action) {
        switch action {
        case .duplicateCheck:
            input.duplicateCheck.send(id)
        case .joinButtonTapped:
            input.joinButtonTapped.send(JoinQuery(id: id, password: password, nick: nickname))
        }
    }
    
    func transform() {
        input.joinButtonTapped
            .sink { [weak self] query in
                guard let self else { return }
                print("회원가입 버튼 클릭")
                Task {
                    await self.join(query: query)
                 }
            }
            .store(in: &cancellables)
        
        input.duplicateCheck
            .sink { [weak self] id in
                guard let self else { return }
                print("중복확인 버튼 클릭")
                Task {
                    await self.idDuplicateCheck(id: id)
                }
            }
            .store(in: &cancellables)
        
        input.inputUserID
            .sink { [weak self] id in
                guard let self else { return }
                if !id.isEmpty {
                    if id.count < 5 || id.count > 10 {
                        output.idValid = "아이디는 5글자 이상 10글자 이하로 설정해주세요"
                        output.duplicateCheck = false
                    } else {
                        output.idValid = "아이디 중복확인을 진행해주세요"
                        output.duplicateCheck = true
                    }
                } else {
                    output.idValid = ""
                    output.duplicateCheck = false
               
                }
                idAvailiable = false
                input.joinConditionCheck.send(())
            }
            .store(in: &cancellables)
        
        input.inputUserPW
            .sink { [weak self] pw in
                guard let self else { return }
                
                if !pw.isEmpty {
                    if pw.count < 6 || pw.count > 12 {
                        output.pwValid = "비밀번호는 6글자 이상 12글자 이하로 설정해주세요"
                        pwAvailiable = false
                    } else {
                        output.pwValid = "사용 가능한 비밀번호입니다"
                        pwAvailiable = true
                    }
                }else {
                    output.pwValid = ""
                    pwAvailiable = false
                }
                input.joinConditionCheck.send(())
            }
            .store(in: &cancellables)
        
        input.inputUserNick
            .sink { [weak self] nick in
                guard let self else { return }
                if !nick.isEmpty {
                    if nick.count < 2 || nick.count > 10{
                        output.nickValid = "닉네임은 2글자 이상 10글자 이하로 설정해주세요"
                        nickAvailiable = false
                    } else {
                        output.nickValid = "사용 가능한 닉네임입니다"
                        nickAvailiable = true
                    }
                } else {
                    output.nickValid = ""
                    nickAvailiable = false
                }
                input.joinConditionCheck.send(())
            }
            .store(in: &cancellables)
        
        input.joinConditionCheck
            .sink { [weak self] in
                guard let self else { return }
                output.joinAvailable = joinConditionCheck()
            }
            .store(in: &cancellables)
    }
    
    func joinConditionCheck() -> Bool {
        
        print(self.idAvailiable, self.pwAvailiable, self.nickAvailiable)
        var result: Bool!
        if self.idAvailiable && self.pwAvailiable && self.nickAvailiable {
            result = true
        } else { result = false }
        print(result)
        return result
    }
    
    func idDuplicateCheck(id: String) async {
        do {
            try await Network.shared.myAPICall(model: MessageModel.self, router: UserRouter.emailValidation(query: IdValidationQuery(id: id)))
                .sink(receiveCompletion: { result in
                    switch result{
                    case .finished:
                        print("Fetch Success")
                    case .failure:
                        print("Fetch Failed")
                    }
                }, receiveValue: { [weak self] resultPost in
                    guard let self else { return }
                    if resultPost.message.contains("가능") {
                        self.output.idValid = "사용 가능한 아이디입니다"
                        idAvailiable = true
                    } else {
                        self.output.idValid = "이미 사용중인 아이디입니다"
                        idAvailiable = false
                    }
                    input.joinConditionCheck.send(())
                }).store(in: &cancellables)
        } catch {
            print("으아ㅏㅇ 망했엉...")
        }
    }
    
    func join(query: JoinQuery) async {
        do {
            try await Network.shared.myAPICall(model: JoinModel.self, router: UserRouter.join(query: query))
                .sink(receiveCompletion: { result in
                    switch result{
                    case .finished:
                        print("Fetch Success")
                    case .failure:
                        self.output.joinSuccess = "회원가입 실패"
                        self.output.alertMessage = "죄송합니다\n현재 회원가입이 불가능합니다"
                        print("Fetch Failed")
                        self.alertPresent = true
                    }
                }, receiveValue: { [weak self] resultPost in
                    guard let self else { return }
                    self.output.joinSuccess = "회원가입 완료"
                    self.output.alertMessage = "\(resultPost.nick)님\n가입을 축하드립니다!"
                    self.alertPresent = true
                }).store(in: &cancellables)
        } catch {
            output.post = []
        }
    }
    
}
