//
//  DataRepository.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/05/30.
//

import Foundation
import Combine

protocol DataResponseStorage {
    func getResponse<T: ResponseDTOType>(networkProvider: NetworkType, model: T.Type, router: TargetType, completion: @escaping (T) -> Void)
}

final class DefaultResponseStorage: DataResponseStorage {
    func getResponse<T: ResponseDTOType>(networkProvider: NetworkType, model: T.Type, router: TargetType, completion: @escaping (T) -> Void) {
        networkProvider.myAPICall(model: model, router: router) { resultModel in
            completion(resultModel)
        }
    }
}

protocol DataRepository {
    var networkProvider: NetworkProvider { get set }
    var dataResponseStorage: DataResponseStorage { get set }
    
    var router: TargetType { get set }
    
    func fetchData<T>(completion: @escaping (T) -> Void)
}

final class HomeRepository: DataRepository {

    var networkProvider: NetworkProvider = NetworkProvider()
    var dataResponseStorage: DataResponseStorage = DefaultResponseStorage()
    
    var router: TargetType = PostRouter.getPost(productID: "")
    
    func fetchData<T>(completion: @escaping (T) -> Void) {
        dataResponseStorage.getResponse(networkProvider: networkProvider, model: ClassListResponseDTO.self, router: router) { result in
            completion(result.toDomain() as! T)
        }
    }
}

final class ChatRepository: DataRepository {
    var networkProvider: NetworkProvider = NetworkProvider()
    var dataResponseStorage: DataResponseStorage = DefaultResponseStorage()
    
    var router: TargetType = ChatRouter.loadChatHistory(roomID: "")
    
    func fetchData<T>(completion: @escaping (T) -> Void) {

        dataResponseStorage.getResponse(networkProvider: networkProvider, model: ChatHistoryDTO.self, router: router) { result in
            completion(result.toDomain() as! T)
        }
    }
}

final class ProfileRepository: DataRepository {
    var networkProvider: NetworkProvider = NetworkProvider()
    var dataResponseStorage: DataResponseStorage = DefaultResponseStorage()
    
    var router: TargetType = ProfileRouter.myProfile

    func fetchData<T>(completion: @escaping (T) -> Void) {
        dataResponseStorage.getResponse(networkProvider: networkProvider, model: ProfileResponseDTO.self, router: router) { result in
            completion(result.toDomain() as! T)
        }
    }
}

final class ReviewRepository: DataRepository {
    
    var networkProvider: NetworkProvider = NetworkProvider()
    var dataResponseStorage: DataResponseStorage = DefaultResponseStorage()
    
    var router: TargetType = PostRouter.getThisPost(id: "")

    func fetchData<T>(completion: @escaping (T) -> Void) {
        dataResponseStorage.getResponse(networkProvider: networkProvider, model: ThisReviewResponseDTO.self, router: router) { result in
            completion(result.toDomain() as! T)
        }
    }
}

