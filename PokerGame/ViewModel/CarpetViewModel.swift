//
//  CarpetViewModel.swift
//  PokerGame
//
//  Created by admin on 08/02/2023.
//

import Foundation

class CarpetViewModel : NSObject{
    
    private var deckService: DeckServiceProtocol

    var reloadTableView: (() -> Void)?
         
    var carpetCellViewModels = [Carpet]() {
        didSet {
            reloadTableView?()
        }
    }

    init(deckService: DeckServiceProtocol = ApiDeckCard()) {
        self.deckService = deckService
    }
    
    func getCards() {
        deckService.getPack { success, model, error in
            if success, let pack = model {
                self.fetchData(pack: pack)
            } else {
                print(error!)
            }
        }
    }
     
    func fetchData(pack : Pack) {
        var arrayCarpet = [Carpet]()
        
        for card in pack.cards{
            arrayCarpet.append(
                Carpet(
                    code: card.code,
                    card: card.image
                )
            )
            print("fetchData card \(card.image)")
        }
        carpetCellViewModels = arrayCarpet
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> Carpet {
        return carpetCellViewModels[indexPath.row]
    }
}
