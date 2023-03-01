//
//  APIDeckCard.swift
//  PokerGame
//
//  Created by admin on 05/01/2023.
//

import Foundation

class ApiDeckCard : DeckServiceProtocol {
    
    let defaults = UserDefaults.standard
    var isDeckId : Bool = false
    
    init(){
        self.createPack(userDefaut: defaults)
    }
    
    func createPack(userDefaut : UserDefaults) {
        HttpRequestHelper().GET(
            url: "https://www.deckofcardsapi.com/api/deck/new/",
            params: ["": ""],
            httpHeader: .application_json
        ) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(Deck.self, from: data!)
                    userDefaut.set(model.deckId, forKey: DefautUser.deck_id)
                    
                    print("Succes : New Deck model id = \(model.deckId)")

                } catch {
                    print("Error: Trying to parse Deck to model")
                }
            } else {
                print("Error: Deck GET Request failed")
            }
        }
    }
    
    func drawCards(completion: @escaping (Bool, Pack?, String?) -> ()) {
        print("drawCards Deck  id = \(defaults.string(forKey: DefautUser.deck_id)!)")
        
        HttpRequestHelper().GET(
            url: "https://deckofcardsapi.com/api/deck/\(defaults.string(forKey: DefautUser.deck_id)!)/draw/",
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
