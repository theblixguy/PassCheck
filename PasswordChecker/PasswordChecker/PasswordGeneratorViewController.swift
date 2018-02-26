//
//  PasswordGeneratorViewController.swift
//  PasswordChecker
//
//  Created by Suyash Srijan on 22/02/2018.
//  Copyright © 2018 Suyash Srijan. All rights reserved.
//

import Foundation
import UIKit

class PasswordGeneratorViewController: UIViewController {
    
    @IBOutlet var includeNumbersSwitch: UISwitch!
    @IBOutlet var includePunctuationSwitch: UISwitch!
    @IBOutlet var includeSymbolsSwitch: UISwitch!
    @IBOutlet var numberOfCharsSlider: UISlider!
    @IBOutlet var numberOfCharsLabel: UILabel!
    @IBOutlet var genStrongPasswordLabel: UILabel!
    @IBOutlet var stackView1VConstraint: NSLayoutConstraint!
    @IBOutlet var stackView2VConstraint: NSLayoutConstraint!
    @IBOutlet var stackView3VConstraint: NSLayoutConstraint!
    @IBOutlet var stackView4VConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfCharsSlider.addTarget(self, action: #selector(sliderValueDidChange(slider:)), for: UIControlEvents.valueChanged)
        
        /* Update constraints so it looks good on iPhone 4/4S and older iPads
         This is dirty, I should fix this in Interface Builder directly */
        if UIScreen.main.nativeBounds.height <= 960 {
            genStrongPasswordLabel.font = genStrongPasswordLabel.font.withSize(20)
            stackView1VConstraint.constant = stackView1VConstraint.constant - 100
            stackView2VConstraint.constant = stackView2VConstraint.constant - 100
            stackView3VConstraint.constant = stackView3VConstraint.constant - 100
            stackView4VConstraint.constant = stackView4VConstraint.constant - 100
        }
    }
    
    @objc func sliderValueDidChange(slider: UISlider) {
        slider.value = round(slider.value / 1) * 1
        numberOfCharsLabel.text = "\(Int(slider.value)) characters"
    }
    
    @IBAction func generatePassword(_ sender: Any) {
        showGeneratedPasswordAlert()
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func showGeneratedPasswordAlert() {
        let password: String = PasswordGenerator.sharedInstance.generatePassword(includeNumbers: includeNumbersSwitch.isOn, includePunctuation: includePunctuationSwitch.isOn, includeSymbols: includeSymbolsSwitch.isOn, length: Int(numberOfCharsSlider.value))
        let alert = UIAlertController(title: "Strong password", message: "Here is a strong and secure password for your use: \(password)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Copy to clipboard", style: UIAlertActionStyle.default, handler: { action in
            UIPasteboard.general.string = password
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
}
