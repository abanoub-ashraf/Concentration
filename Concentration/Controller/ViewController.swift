import UIKit

//one of the Controller Module
class ViewController: UIViewController {
    
    // by this variable, now our controller is talking to our model
    /******************************************************************************
     * + 1 cause in case i have odd numbers of cards i won't be able to get pairs
     * / 2 to get pairs of cards
     * lazy: it doesn't actually intialize until someone grabs it,
       until someone tries touse this variable then just gonna intialize it
     * "lazy" counts as this variable is intialized
     * it can't have a didSet { } Block, you can't use property Observer with it
     *****************************************************************************/
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    //to count how many flips happenes when we click on any button
    var flipCount = 0 {
        //property observer
        /*****************************************************************************
         every time a chnge'll happen to this variable, this block will get executed,
         used to keep the UI in sync with the class's variables
        *****************************************************************************/
        /* instead of coping what's inside the block many times */
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    //array of buttons
    @IBOutlet var cardButtons: [UIButton]!
    
    /************************************************************************
     we'll create an array of all these cards and when touchCard is pressed
     I'm gonna look in that Array, find the button that's been pressed
     and then we'll know which card it is which index it is in the array
     I'm gonna look up in another array the emoji to put there
    ************************************************************************/
    
    // the _ means don't give this function an external name when you call it
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        
        //! means assume it has a value and just grab it, but if that value is nil, i am fucked
        //let cardNumber = cardButtons.index(of: sender)!
        
        //this is how to fix if nil exesits
        //assign the index of each button in the array buttons to a constant
        if let cardNumber = cardButtons.index(of: sender) {
            //then use this constant as index of the emojies array
            game.chooseCard(at: cardNumber)
            //then we wanna update the UI
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons!")
        }
    
    }
    
    func updateViewFromModel() {
        //indices: array method returns a countable range of all the indexes of the array
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["🦅", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"]
    
    //this is a dictionary, key and value pairs inside it, currently an empty one
    // "Int" for the identifier, "String" for the emoji
    var emoji = [Int : String]()
    
    func emoji(for card: Card) -> String {
        //we gonna look at this dictionary right here and get a card
        
        /***********************************************************
         chosenEmoji is an optional,
         * looking something up in the dictionary returns optional,
         casue we might not found it (get a nil value)
        ***********************************************************/
        //let chosenEmoji emoji[card.identifier]
        
        //but we will use "if statement" to handel that optional
        /*************************************************************
         this if block is common, to get something that's an optional
         and if it's not if it's set then use it
         but if it's not set then do something else
        *************************************************************/
        /*if emoji[card.identifier] != nil {
            return emoji[card.identifier]!
        } else {
            return "?"
        }*/
        
        //now we'll fill the dictionary
        if emoji[card.identifier] == nil {
            if emojiChoices.count > 0 {
                //we will take one of the emojies from the emojies array and put it here randomly
                //this is a random number generator method, from 0 to the range you will put
                /************************************************************************
                 (UInt32), cause the random method needs an input of type Uint32
                 (Int), cause the entire side on the right should be Int value not UInt32
                 ************************************************************************/
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                //get the emoji that its index is "randomIndex" in the EmojiChoices Array,                       remove it from the emojies array and put it in the Dictionary
                /** "card.identifier" is the Int key, and the Emoji is the String value in the Dictionary **/
                //remove method, cause the emoji that's gonna be grabed from the emojies array                   should be removed to not use it again
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }
        }
        
        //there's another way to do that if statement that handles the optional
        //it says: return "emoji[card.identifier]" but if it's nil then return this "?"
        return emoji[card.identifier] ?? "?"
    }
}
