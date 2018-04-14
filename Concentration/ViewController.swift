import UIKit

class ViewController: UIViewController {
    
    //to count how many flips
    var flipCount = 0 {
        //property observer
        /*****************************************************************************
         every time a chnge'll happen to this variable, this block will get executed
         used to keep the ui in sync with the class's variables
        *****************************************************************************/
        /* instead of coping what's inside the block many times */
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    //array of buttons
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices = ["👻", "🎃", "👻", "🎃"]
    
    /************************************************************************
     we'll create an array of all these cards and when touchCard is pressed
     I'm gonna look in that Array, find the button that's been pressed
     and then we'll know which card it is which index it is in the array
     I'm gonna look up in another array the emoji to put there
    ************************************************************************/
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        
        //! means assume it has a value and just grab it, but if that value is nil, i am fucked
        //let cardNumber = cardButtons.index(of: sender)!
        
        //this is how to fix if nil exesits
        if let cardNumber = cardButtons.index(of: sender) {
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        } else {
            print("chosen card was not in cardButtons!")
        }
    
    }
    
    /*************************************************************************************
    each param can have 2 names, the first one is external (used in calling the function)
    we can replace the external onew with _ and remove it from then calling line
    *************************************************************************************/
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        }
    }
    
}
