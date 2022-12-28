//
//  Character.swift
//  obnk
//
//  Created by Javier Calatrava on 28/12/22.
//

import Foundation

struct Character: Codable, Equatable, Hashable {
    let id: Int
    let name: String
    let thumbnail: Thumbnail
    let comics: [ComicItem]
    
    init(characterAPI: CharacterAPI) {
        self.id = characterAPI.id
        self.name = characterAPI.name
        self.thumbnail = Thumbnail(thumbnailAPI: characterAPI.thumbnail)
        self.comics = characterAPI.comics.items.map { ComicItem(comicItemAPI: $0) }
    }
    
    init(id: Int, name: String, thumbnail: Thumbnail, comics: [ComicItem]) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.comics = comics
    }
    
    func hash(into hasher: inout Hasher) {
        
    }
}

struct Thumbnail: Codable, Equatable  {
    let url: String
    
    init(thumbnailAPI: ThumbnailAPI) {
        self.url = thumbnailAPI.path + "." + thumbnailAPI.ext
    }
    
    init(path: String, ext: String) {
        self.url = path + "." + ext
    }
    
    func getURL() -> URL? {
        let urlSecure = url.replacingOccurrences(of: "http", with: "https")
        return URL(string: urlSecure)
    }
}

struct ComicItem: Codable, Equatable {
    let name: String
    
    init(comicItemAPI: ComicItemAPI) {
        self.name = comicItemAPI.name
    }
    
    init(name: String) {
        self.name = name
    }
}
// MARK: - Sample data
extension Character {
    static let sample = Character(id: 1011334, name: "3-D Man", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", ext: "jpg"), comics: .sample)
}

extension Array where Element == Character {
    static var sample: Self {
        [
            Character(id: 1011334, name: "3-D Man", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", ext: "jpg"), comics: .sample),
               Character(id: 1017100, name: "A-Bomb (HAS)", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", ext: "jpg"), comics: .sample),
               Character(id: 1009144, name: "A.I.M.", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec", ext: "jpg"), comics: .sample),
               Character(id: 1010699, name: "Aaron Stack", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", ext: "jpg"), comics: .sample),
               Character(id: 1009146, name: "Abomination (Emil Blonsky)", thumbnail: Thumbnail(path: "", ext: "jpg"), comics: .sample),
               Character(id: 1016823, name: "Abomination (Ultimate)", thumbnail: Thumbnail(path: "", ext: "jpg"), comics: .sample),
               Character(id: 1009148, name: "Absorbing Man", thumbnail: Thumbnail(path: "", ext: "jpg"), comics: .sample),
               Character(id: 1009149, name: "Abyss", thumbnail: Thumbnail(path: "", ext: "jpg"), comics: .sample),
               Character(id: 1010903, name: "Abyss (Age of Apocalypse)", thumbnail: Thumbnail(path: "", ext: "jpg"), comics: .sample),
               Character(id: 1011266, name: "Adam Destine", thumbnail: Thumbnail(path: "", ext: "jpg"), comics: .sample),
               Character(id: 1010354, name: "Adam Warlock", thumbnail: Thumbnail(path: "", ext: "jpg"), comics: .sample),
               Character(id: 1010846, name: "Aegis (Trey Rollins)", thumbnail: Thumbnail(path: "", ext: "jpg"), comics: .sample),
               Character(id: 1017851, name: "Aero (Aero)", thumbnail: Thumbnail(path: "", ext: "jpg"), comics: .sample),
               Character(id: 1012717, name: "Agatha Harkness", thumbnail: Thumbnail(path: "", ext: "jpg"), comics: .sample),
               Character(id: 1011297, name: "Agent Brand", thumbnail: Thumbnail(path: "", ext: "jpg"), comics: .sample),
               Character(id: 1011031, name: "Agent X (Nijo)", thumbnail: Thumbnail(path: "", ext: "jpg"), comics: .sample),
               Character(id: 1009150, name: "Agent Zero", thumbnail: Thumbnail(path: "", ext: "jpg"), comics: .sample),
               Character(id: 1011198, name: "Agents of Atlas", thumbnail: Thumbnail(path: "", ext: "jpg"), comics: .sample),
               Character(id: 1011175, name: "Aginar", thumbnail: Thumbnail(path: "", ext: "jpg"), comics: .sample),
               Character(id: 1011136, name: "Air-Walker (Gabriel Lan)", thumbnail: Thumbnail(path: "", ext: "jpg"), comics: .sample)
            
        ]
    }
}

extension Array where Element == ComicItem {
    static var sample: Self {
            [ComicItem(name: "Avengers: The Initiative (2007) #14"),
             ComicItem(name: "Avengers: The Initiative (2007) #14 (SPOTLIGHT VARIANT)"),
             ComicItem(name: "Avengers: The Initiative (2007) #15"),
             ComicItem(name: "Avengers: The Initiative (2007) #16"),
             ComicItem(name: "Avengers: The Initiative (2007) #17"),
            ]
    }
}
