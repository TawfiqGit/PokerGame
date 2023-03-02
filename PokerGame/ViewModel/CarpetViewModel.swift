//
//  CarpetViewModel.swift
//  PokerGame
//
//  Created by admin on 08/02/2023.
//

import Foundation
import FirebaseDatabase

class CarpetViewModel : NSObject{
    
    private var deckService: DeckServiceProtocol
    private var database : DatabaseReference
    
    var reloadTableView: (() -> Void)?
    var carpetCellViewModels = [Carpet]() {
        didSet {
            reloadTableView?()
        }
    }

    init(deckService: DeckServiceProtocol = ApiDeckCard()) {
        self.deckService = deckService
        self.database = Database.database().reference()
    }
    
    func showPileCardsOfCarpet(){
        var arrayCarpet = [Carpet]()
        
        database.observeSingleEvent(of: .value, with: { snapshot in
            for case let child as DataSnapshot in snapshot.children {
                guard let dict = child.value as? [String:Any] else {
                    return
                }
                
                if let arrayCards = dict["cards"] as? NSArray {
                    for card in arrayCards{                        
                        arrayCarpet.append(
                            Carpet(code: "card.code", card: card as! String)
                        )
                    }
                }
            }
            self.carpetCellViewModels = arrayCarpet
        }) { error in
          print(error.localizedDescription)
        }
    }
    
    func savePileCardsOfCarpet() {
        deckService.drawCards(completion: { success, model, error in
            if success, let pack = model {
                self.saveCards(pack: pack)
            } else {
                print(error!)
            }
        })
    }
     
    func getCellViewModel(at indexPath: IndexPath) -> Carpet {
        return carpetCellViewModels[indexPath.row]
    }
    
    private func saveCards(pack : Pack) {
        var arrayCarpet: Array = [String]()
        
        for card in pack.cards{
            arrayCarpet.append(card.image)
            print("saveCards \(card.image)")
        }
        database.child("carpet").child("cards").setValue(arrayCarpet)
    }
}
