//
//  ViewController.swift
//  Silly Song
//
//  Created by Chun Yeung on 2017/7/13.
//  Copyright © 2017年 Chun Yeung. All rights reserved.
//

import UIKit

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!

    @IBOutlet weak var lyricsView: UITextView!
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let aSet = NSCharacterSet(charactersIn:"QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }

    
    func shortNameForName(name: String) -> String {
        
        let lowercaseName = name.lowercased()
        
        let vowelSet = CharacterSet(charactersIn: "aeiouø")
        
        if let firstVowelRange = name.rangeOfCharacter(from: vowelSet, options: .caseInsensitive) {
            return lowercaseName.substring(from: firstVowelRange.lowerBound)
        }
        
        return lowercaseName
    
    }
    
    func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
        
        let shortName = shortNameForName(name: fullName)
        
        let lyrics = lyricsTemplate
            .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
            .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
        
        return lyrics
    }
    
    @IBAction func reset(_ sender: AnyObject) {
        
       nameField.text = ""
        
        lyricsView.text = ""
        
    }
    
    @IBAction func displayLyrics(_ sender: AnyObject) {
        
        let bananaFanaTemplate = [
            "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
            "Banana Fana Fo F<SHORT_NAME>",
            "Me My Mo M<SHORT_NAME>",
            "<FULL_NAME>"].joined(separator: "\n")
        
        let nameToken = nameField.text
        
        if nameToken != ""{
            lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: nameToken!)
        }else{
            lyricsView.text = "Please Enter Letter!"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

}

