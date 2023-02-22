//
//  APIDeckCard.swift
//  PokerGame
//
//  Created by admin on 05/01/2023.
//

import Foundation

class ApiDeckCard : DeckServiceProtocol {
   
    func getPack(completion: @escaping (Bool, Pack?, String?) -> ()) {
        HttpRequestHelper().GET(
            url: "https://deckofcardsapi.com/api/deck/new/draw/",
            params: ["count": GlobaVariable.numberCardOfCarpet],
            httpHeader: .application_json
        ) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(Pack.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse Pack to model")
                }
            } else {
                completion(false, nil, "Error: Pack GET Request failed")
            }
        }
    }
}
