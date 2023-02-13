//
//  Card.swift
//  PokerGame
//
//  Created by admin on 05/01/2023.
//

import Foundation

//typealias : un alias pour un type existant
typealias ArrayPack = [Pack]
typealias ArrayCard = [Card]

struct Pack : Decodable {
    let success : Bool
    let deckId: String
    let cards : [Card]
    let remaining : Int
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case deckId = "deck_id"
        case cards = "cards"
        case remaining = "remaining"
    }
}

struct Card: Decodable{
  
    let code, image, value, suit: String
    let typeImage: TypeImage

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case image = "image"
        case typeImage = "images"
        case value = "value"
        case suit = "suit"
    }
}

struct TypeImage: Decodable{
  
    let svg,png: String

    enum CodingKeys: String, CodingKey {
        case svg = "svg"
        case png = "png"
    }
}

