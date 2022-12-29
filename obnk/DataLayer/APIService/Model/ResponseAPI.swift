//
//  MarvelResponseAPI.swift
//  obnk
//
//  Created by Javier Calatrava on 27/12/22.
//

import Foundation

// MARK: - ResponseAPI
struct ResponseAPI: Codable {
    let status: String
    let data: DataAPI
}
// MARK: - DataAPI
struct DataAPI: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [CharacterAPI]
}
// MARK: - CharacterAPI
struct CharacterAPI: Codable {
    let id: Int
    let name: String
    let thumbnail: ThumbnailAPI
    let comics: ComicsAPI
}
// MARK: - ThumbnailAPI
struct ThumbnailAPI: Codable  {
    let path: String
    let ext: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}
// MARK: - ComicsAPI
struct ComicsAPI: Codable {
    let items: [ComicItemAPI]
}
// MARK: - ComicItemAPI
struct ComicItemAPI: Codable {
    let name: String
}
// MARK: - Sample data
extension ResponseAPI {
    static let sample = ResponseAPI(status: "Ok", data: .sample)
    static let sampleNotOK = ResponseAPI(status: "notOK", data: .sample)
}

extension DataAPI {
    static let sample = DataAPI(offset: 0, limit: 20, total: 1562, count: 20, results: .sample)
}

extension Array where Element == CharacterAPI {
    static var sample: Self {
        [  CharacterAPI(id: 1011334, name: "3-D Man", thumbnail: ThumbnailAPI(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", ext: "jpg"), comics: .sample),
           CharacterAPI(id: 1017100, name: "A-Bomb (HAS)", thumbnail: ThumbnailAPI(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", ext: "jpg"), comics: .sample),
           CharacterAPI(id: 1009144, name: "A.I.M.", thumbnail: ThumbnailAPI(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec", ext: "jpg"), comics: .sample),
           CharacterAPI(id: 1010699, name: "Aaron Stack", thumbnail: ThumbnailAPI(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", ext: "jpg"), comics: .sample),
           CharacterAPI(id: 1009146, name: "Abomination (Emil Blonsky)", thumbnail: ThumbnailAPI(path: "", ext: "jpg"), comics: .sample),
           CharacterAPI(id: 1016823, name: "Abomination (Ultimate)", thumbnail: ThumbnailAPI(path: "", ext: "jpg"), comics: .sample),
           CharacterAPI(id: 1009148, name: "Absorbing Man", thumbnail: ThumbnailAPI(path: "", ext: "jpg"), comics: .sample),
           CharacterAPI(id: 1009149, name: "Abyss", thumbnail: ThumbnailAPI(path: "", ext: "jpg"), comics: .sample),
           CharacterAPI(id: 1010903, name: "Abyss (Age of Apocalypse)", thumbnail: ThumbnailAPI(path: "", ext: "jpg"), comics: .sample),
           CharacterAPI(id: 1011266, name: "Adam Destine", thumbnail: ThumbnailAPI(path: "", ext: "jpg"), comics: .sample),
           CharacterAPI(id: 1010354, name: "Adam Warlock", thumbnail: ThumbnailAPI(path: "", ext: "jpg"), comics: .sample),
           CharacterAPI(id: 1010846, name: "Aegis (Trey Rollins)", thumbnail: ThumbnailAPI(path: "", ext: "jpg"), comics: .sample),
           CharacterAPI(id: 1017851, name: "Aero (Aero)", thumbnail: ThumbnailAPI(path: "", ext: "jpg"), comics: .sample),
           CharacterAPI(id: 1012717, name: "Agatha Harkness", thumbnail: ThumbnailAPI(path: "", ext: "jpg"), comics: .sample),
           CharacterAPI(id: 1011297, name: "Agent Brand", thumbnail: ThumbnailAPI(path: "", ext: "jpg"), comics: .sample),
           CharacterAPI(id: 1011031, name: "Agent X (Nijo)", thumbnail: ThumbnailAPI(path: "", ext: "jpg"), comics: .sample),
           CharacterAPI(id: 1009150, name: "Agent Zero", thumbnail: ThumbnailAPI(path: "", ext: "jpg"), comics: .sample),
           CharacterAPI(id: 1011198, name: "Agents of Atlas", thumbnail: ThumbnailAPI(path: "", ext: "jpg"), comics: .sample),
           CharacterAPI(id: 1011175, name: "Aginar", thumbnail: ThumbnailAPI(path: "", ext: "jpg"), comics: .sample),
           CharacterAPI(id: 1011136, name: "Air-Walker (Gabriel Lan)", thumbnail: ThumbnailAPI(path: "", ext: "jpg"), comics: .sample)
        ]
    }
}

extension ComicsAPI {
    static let sample = ComicsAPI(items: .sample)
}

extension Array where Element == ComicItemAPI {
    static var sample: Self {
        [ComicItemAPI(name: "Avengers: The Initiative (2007) #14"),
         ComicItemAPI(name: "Avengers: The Initiative (2007) #14 (SPOTLIGHT VARIANT)"),
         ComicItemAPI(name: "Avengers: The Initiative (2007) #15"),
         ComicItemAPI(name: "Avengers: The Initiative (2007) #16"),
         ComicItemAPI(name: "Avengers: The Initiative (2007) #17"),
        ]
    }
}

