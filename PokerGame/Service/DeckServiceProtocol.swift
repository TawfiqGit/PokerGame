//
//  DeckServiceProtocol.swift
//  PokerGame
//
//  Created by admin on 20/02/2023.
//

import Foundation

protocol DeckServiceProtocol {
    func drawCards(completion: @escaping (_ success: Bool, _ results: Pack?, _ error: String?) -> ())
}
