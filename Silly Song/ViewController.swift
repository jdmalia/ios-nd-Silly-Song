//
//  ViewController.swift
//  Silly Song
//
//  Created by Jason Malia on 7/9/17.
//  Copyright © 2017 Jason Malia. All rights reserved.
//

import UIKit

let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")

func shortNameForName(name: String) -> String
{
    let lowercaseName = name.lowercased()
    let vowelSet = CharacterSet(charactersIn: "aeiou")
   
    var shortName = lowercaseName
    while( shortName.characters.count > 0 && !vowelSet.contains( shortName.unicodeScalars.first! ) )
    {
        let index = shortName.index(shortName.startIndex, offsetBy: 1)
        shortName = shortName.substring(from: index)
    }
    return shortName.characters.count > 0 ? shortName : lowercaseName
}

func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    
    let shortName = shortNameForName(name: fullName)
    
    let lyrics = lyricsTemplate
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    
    return lyrics
}

class ViewController: UIViewController
{
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        nameField.delegate = self
    }

    @IBAction func reset(_ sender: AnyObject)
    {
        nameField.text = ""
        lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: AnyObject)
    {
        lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: nameField.text!)
    }

}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

