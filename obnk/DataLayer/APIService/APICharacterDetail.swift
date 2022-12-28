//
//  APICharacterDetail.swift
//  obnk
//
//  Created by Javier Calatrava on 27/12/22.
//

import Foundation

final class APICharacterDetail: APIService<CharacterDetailResponseAPI> {
     
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    override func getCommnad() -> String {
        return "characters/\(id)"
    }
}
