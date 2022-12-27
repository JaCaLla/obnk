//
//  APIService.swift
//  obnk
//
//  Created by Javier Calatrava on 27/12/22.
//

import Foundation

open class APIService<T: Decodable> {
    
    let ts = "1"
    let apiKey = "c6293688547662bf5d1cbdb01b7ef97a"
    let privateKey = "e1a8b5b725360e9e7b3ec1ca7a282e084b83d156"
    let scheme = "https"
    let host = "gateway.marvel.com"
    let itemsPerPage = 20
    
    private let urlSession: URLSession
    
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetch(page: Int, completion: @escaping (Result<T,Error>) -> Void) {
        guard let url = getURL(page: 0) else {
            completion(.failure(APIManagerError.noURLBuilt))
            return
        }
        urlSession.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(APIManagerError.fetching))
                return
            }
            guard let data = data else {
                completion(.failure(APIManagerError.noData))
                return
            }
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                print("\(error)")
                completion(.failure(APIManagerError.jsonDecoding))
            }
        }.resume()
    }
    
    // MARK: - To override
    func getCommnad() -> String {
        return ""
    }
    
    
    // MARK: - Private/Internal
    internal func getURL(page: Int) -> URL? {
        let command = getCommnad()
        guard !command.isEmpty else { return nil }
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = "/v1/public/\(command)"
        components.queryItems = [
            URLQueryItem(name: "ts", value: ts),
            URLQueryItem(name: "apikey", value: apiKey),
            URLQueryItem(name: "hash", value:  "\(ts)\(privateKey)\(apiKey)".md5),
            URLQueryItem(name: "offset", value: "\(itemsPerPage * page)"),
            URLQueryItem(name: "limit", value: "\(itemsPerPage)"),
        ]
        return components.url
    }
}
