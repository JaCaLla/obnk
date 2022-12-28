//
//  DataManager.swift
//  obnk
//
//  Created by Javier Calatrava on 28/12/22.
//

import Foundation

protocol DataManagerProtocol {
    func fetch(completion: @escaping (Result<[Character],Error>) -> Void)
    func reset()
}

final class DataManager {
   

    // MARK: - Private attributes
    var currentPage: Int = 0
    var apiCharcters: APIService<ResponseAPI>?
    var charactersFetched: [Character] = []

    
    init(apiCharcters: APIService<ResponseAPI>? = APICharacters()) {
        self.apiCharcters = apiCharcters
    }
}

extension DataManager: DataManagerProtocol {
    func fetch(completion: @escaping (Result<[Character],Error>) -> Void) {
        guard let apiCharcters = apiCharcters else {
            completion(.failure(APIManagerError.noAPICharacters))
            return
        }
//        if isFetchingCharacters {
//            completion(.failure(APIManagerError.busy))
//            return
//        }
//        isFetchingCharacters = true
        apiCharcters.fetch(page: currentPage) {[weak self] result in
//            if self == nil {
//                print("premio")
//            }
          //  self?.isFetchingCharacters = false
            switch result {
            case .success (let responseAPI):
                guard responseAPI.status == "Ok" else {
                    completion(.failure(APIManagerError.noOK))
                    return
                }
                let characters = responseAPI.data.results.map({ Character(characterAPI: $0) } )
                self?.charactersFetched.append(contentsOf: characters)
                self?.currentPage += 1
                completion(.success(self?.charactersFetched ?? []))
            case .failure( let error):
                completion(.failure(error))
            }
        }
    }
    
    func reset() {
        currentPage = 0
        charactersFetched = []
        apiCharcters = APICharacters()
    }
}
