//
//  DataManager.swift
//  obnk
//
//  Created by Javier Calatrava on 28/12/22.
//

import Foundation

// MARK: - Protocol
protocol DataManagerProtocol {
    func fetch(completion: @escaping (Result<[Character],Error>) -> Void)
    func reset()
}

// MARK: - DataManager
final class DataManager {
   

    // MARK: - Private attributes
    internal var currentPage: Int = 0
    internal var apiCharcters: APIService<ResponseAPI>?
    internal var charactersFetched: [Character] = []

    // MARK: - Constructor/Initializer
    init(apiCharcters: APIService<ResponseAPI>? = APICharacters()) {
        self.apiCharcters = apiCharcters
    }
}

// MARK: - DataManagerProtocol
extension DataManager: DataManagerProtocol {
    func fetch(completion: @escaping (Result<[Character],Error>) -> Void) {
        guard let apiCharcters = apiCharcters else {
            completion(.failure(APIManagerError.noAPICharacters))
            return
        }

        apiCharcters.fetch(page: currentPage) {[weak self] result in
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
