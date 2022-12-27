//
//  APICharacter.swift
//  obnk
//
//  Created by Javier Calatrava on 27/12/22.
//

import Foundation


internal final class APICharacter: APIService<MarvelResponseAPI> {
    
    // MARK: - To override
    override func getCommnad() -> String {
        return "characters"
    }
}
