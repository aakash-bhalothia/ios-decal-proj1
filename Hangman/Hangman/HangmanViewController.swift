//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController,UITextFieldDelegate  {
    
    
    @IBOutlet weak var restart: UIButton!
    @IBOutlet weak var i7: UIImageView!
    @IBOutlet weak var i6: UIImageView!
    @IBOutlet weak var i5: UIImageView!
    @IBOutlet weak var i4: UIImageView!
    @IBOutlet weak var i3: UIImageView!
    @IBOutlet weak var i2: UIImageView!
    @IBOutlet weak var i1: UIImageView!
    @IBOutlet weak var incorrectSet: UILabel!
    @IBOutlet weak var dashes: UILabel!
    @IBOutlet weak var guessLab: UITextField!
    @IBOutlet weak var guessButton: UIButton!
    var phrase: String = ""
    var hangmanPhrases = HangmanPhrases()
    var letters_guessed = Set<Character>()
    var incorrect_guesses = Array<Character>()
    var incorrect_set = Set<Character>()
    var hangman_ind = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        i1.isHidden = false
        i2.isHidden = true
        i3.isHidden = true
        i4.isHidden = true
        i5.isHidden = true
        i6.isHidden = true
        i7.isHidden = true
        guessLab.delegate = self
        incorrectSet.text = ""
        incorrect_set = Set<Character>()
        letters_guessed = Set<Character>()
        incorrect_guesses = Array<Character>()
        self.guessLab.delegate = self
        hangman_ind = 1
//        hangmanPhrases = HangmanPhrases()
        // Generate a random phrase for the user to guess
        self.phrase = hangmanPhrases.getRandomPhrase()
        var newStr:String = " "
        for char in phrase.characters {
           if char == " " {
            newStr = newStr + " "
            }
           else {
            newStr = newStr + "_ "
            }
        }
        print(phrase)
        self.dashes.text = newStr
        dashes.textAlignment = .center
//        dashes.sizeToFit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func guessPressed(_ sender: UIButton) {
        let str = guessLab.text!.uppercased()
        if str.isEmpty{
            return
        }
        let guess = String(str[str.startIndex])
        if incorrect_set.contains(Character(guess)){
            guessLab.text = ""
            return
        }
        guessLab.text = guess.uppercased()
        let index = hangmanPhrases.guesswasmade(guess: guess,phrase: self.phrase)
        var x = 0
        var newStr:String = ""
//        var charlist = self.dashes.text?.characters
        if index > -1 {
            letters_guessed.insert(Character(guess))
            for char in phrase.characters {
                if letters_guessed.contains(char) {
                    newStr = newStr + String(char) + " "
                }
                else if char == " " {
                    newStr = newStr + " "
                }
                    
                else {
                    newStr = newStr + "_ "
                }
                x += 1
            }
            self.dashes.text = newStr
            var test = true
            for char in phrase.characters {
                if char != Character(" ") {
                if (letters_guessed.contains(char) == false){
                    test = false
                    break
                }
                }
            }
            if (test == true) {
                let alert = UIAlertController(title: "You win!", message: phrase, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.default, handler: { action in
                    // do something like...
                    self.viewDidLoad()
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else {
            hangman_ind += 1
            hangman()
            incorrect_guesses.append((Character(guess)))
            incorrect_set.insert((Character(guess)))
            var newStr:String = " "
            for char in incorrect_guesses{
                newStr = newStr + String(char) + " "
            }
            
            incorrectSet.text = newStr
        }
        guessLab.text = ""
    }
    
    func hangman() {
        if hangman_ind == 2 {
            i2.isHidden = false
        }
        if hangman_ind == 3 {
            i3.isHidden = false
        }
        if hangman_ind == 4 {
            i4.isHidden = false
        }
        if hangman_ind == 5 {
            i5.isHidden = false
        }
        if hangman_ind == 6 {
            i6.isHidden = false
        }
        if hangman_ind == 7 {
            i7.isHidden = false
            let alert = UIAlertController(title: "You lost!", message: "Better luck next time", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.default, handler: { action in
                // do something like...
                self.viewDidLoad()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func restart(_ sender: UIButton) {
        self.viewDidLoad()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
