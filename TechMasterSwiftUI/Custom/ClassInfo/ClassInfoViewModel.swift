//
//  ClassInfoViewModel.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/18.
//

import Foundation
import Combine

typealias ClassInfo = ClassModel

protocol LoadPostResult: AnyObject {
    var classInfo: ClassInfo {get set}
}

@MainActor
final class ClassInfoViewModel: ViewModelType, LoadPostResult{
    
    var cancellables = Set<AnyCancellable>()
    var classInfo: ClassInfo
    var buttonAction: ButtonAction
    
    @Published var nowStatus: Bool!
    @Published var isPresent: Bool = false
    
    var input = Input()
    var output = Output()

    init(classInfo: ClassInfo, buttonAction: ButtonAction) {
        self.classInfo = classInfo
        self.buttonAction = buttonAction
        nowStatus = getNowScrapStatus(scrapList: classInfo.scrap)
        transform()
    }
}

extension ClassInfoViewModel {
    
    typealias PostID = String
    
    struct Input {
        var scrapButtonTapped = PassthroughSubject<PostID, Never>()
        var togglePresent = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
    }
    
    enum Action {
        case scrapButtonTapped(postID: PostID)
        case togglePresent
    }
    
    func action(_ action: Action) {
        switch action {
        case .scrapButtonTapped(let postID):
            input.scrapButtonTapped.send(postID)
        case .togglePresent:
            input.togglePresent.send(())
        }
    }
    
    func transform() { 
        input.scrapButtonTapped
            .sink { [weak self] postID in
                guard let self else { return }
                Task {
                    await self.sendScrapStatus(status: !self.nowStatus)
                }
            }
            .store(in: &cancellables)

        input.togglePresent
            .sink { [weak self] _ in
                guard let self else { return }
                self.isPresent.toggle()
            }
            .store(in: &cancellables)

    }
    
    func getNowScrapStatus(scrapList: [String]) -> Bool{
        for scrapper in scrapList {
            if scrapper == NowUser.userID {
                return true
            }
        }
        return false
    }
    
    func sendScrapStatus(status: Bool) async {
        do {
            try await Network.shared.myAPICall(model: ScrapModel.self, router: PostRouter.scrap(postID: classInfo.post_id, query: ScrapQuery(scrapStatus: status)))
                .sink(receiveCompletion: { result in
                    switch result{
                    case .finished:
                        print("Fetch Success")
                    case .failure:
                        print("Fetch Failed")
                    }
                }, receiveValue: { [weak self] result in
                    guard let self else { return }
                    self.nowStatus.toggle()
                }).store(in: &cancellables)
        } catch {
            print("통신 자체를 실패했습니다")
        }
    }

}
