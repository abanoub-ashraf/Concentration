import Foundation

//one of the Model Module
class Concentration {
    
    //Array of Cards
    var cards = [Card]()
    
    //to keep track if one and only one card is faced up
    //to keep track the card i wanted to match against all the time
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                // if they don't match what happenes when i choose the second card
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                //either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    //turn ever card on the screen facedown
                    cards[flipDownIndex].isFaceUp = false
                }
                //now you chose a card, so i'm gonna face that card up
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
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
