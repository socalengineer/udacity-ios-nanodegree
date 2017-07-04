//
//  ViewController.swift
//  Silly Song
//
//  Created by Bhishan Hemrajani on 7/3/17.
//  Copyright © 2017 Bhishan Hemrajani. All rights reserved.
//

import UIKit


func shortNameFromName(name: String) -> String {
    
    let vowelSet = CharacterSet(charactersIn: "aeiou")
    let fullName = name.lowercased()
    
    if let firstVowelRange = fullName.rangeOfCharacter(from: vowelSet) {
        return fullName.substring(from: firstVowelRange.lowerBound)
    }
    return fullName
}

func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let shortName = shortNameFromName(name: fullName)
    
    let lyrics = lyricsTemplate
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    
    return lyrics
}


let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }
    

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!

    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }
    @IBAction func displayLyrics(_ sender: Any) {
        guard let name = nameField.text, !name.isEmpty else {
            return
        }
        
        lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: name)
    }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

