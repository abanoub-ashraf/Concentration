import Foundation

//one of the Model Module
class Concentration {
    
    //Array of Cards
    var cards = [Card]()
    
    func chooseCard(at index: Int) {
    }
    
    init(numberOfPairsOfCards: Int) {
        // _ here means ignore this, I don't care what's this cause 'm not gonna use it
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            //add two copies of card to the array, cause Card is a Struct, a Value types so they're copies
            cards += [card, card]
        }
        // TODO: Shuffle the cards
    }
    
}
