import Foundation

//one of the Model Module
struct Card {
    
    var isFaceUp = false
    var isMatched = false
    
    //to diffrenciate between cards
    var identifier: Int
    
    //this static variable is called by the Type Card itself not a card from it, same as static function
    static var identifierFactory = 0
    
    //this static func is called by the Type Card itself not a card from it
    static func getUniqueIdentifier() -> Int {
        //but you don't have to call it by the Type Card cause it's a static var and you're inside a static func so no need
        identifierFactory += 1
        return identifierFactory
    }
    
    //its external and internal names are the same
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
