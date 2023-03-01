//
//  Deck.swift
//  PokerGame
//
//  Created by admin on 22/02/2023.
//

import Foundation

struct Deck: Decodable {
    let success : Bool
    let deckId: String
    let remaining : Int
    let shuffled : Bool
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case deckId = "deck_id"
        case remaining = "remaining"
        case shuffled = "shuffled"
    }
}
