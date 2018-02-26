//
//  MainViewController.swift
//  PasswordChecker
//
//  Created by Suyash Srijan on 21/02/2018.
//  Copyright © 2018 Suyash Srijan. All rights reserved.
//

import UIKit
import ZXCVBN
import IDZSwiftCommonCrypto

class MainViewController: UIViewController {
    
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var timeField: UILabel!
    @IBOutlet var breachLabel: UILabel!
    
    @IBOutlet var enterYourPasswordLabel: UILabel!
    @IBOutlet var breachVConstraint: NSLayoutConstraint!
    @IBOutlet var passwordVConstraint: NSLayoutConstraint!
    
    private var noBreachColor: UIColor = UIColor(red:0.31, green:0.71, blue:0.54, alpha:1.0)
    private var breachColor: UIColor = .red
    
    private var textColors: [UIColor] = [.red, UIColor.blue.lighter(by: 30)!, .orange, UIColor.yellow.darker(by: 12)!, UIColor(red:0.31, green:0.71, blue:0.54, alpha:1.0)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Update constraints so it looks good on iPhone 5/5S/SE
         This is dirty, I should fix this in Interface Builder directly */
        if UIScreen.main.nativeBounds.height <= 1136 {
            passwordVConstraint = passwordVConstraint.setMultiplier(multiplier: 0.9)
            breachVConstraint = breachVConstraint.setMultiplier(multiplier: 0.94)
        }
        
        /* Update constraints so it looks good on iPhone 4/4S and older iPads
         This is dirty, I should fix this in Interface Builder directly */
        if UIScreen.main.nativeBounds.height <= 960 {
            enterYourPasswordLabel.font = enterYourPasswordLabel.font.withSize(20)
        }
        
        passwordField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        let passwordStrength: BBPasswordStrength = ZXCVBN.BBPasswordStrength.init(password: textField.text!)
        
        let passwordSHA1: [UInt8] = Digest(algorithm: .sha1).update(string: passwordField.text!)!.final()
        
        let passwordSHA1String: String = hexString(fromArray: passwordSHA1)
        
        let passwordSHA1StringTrimmed: String = String(passwordSHA1String.prefix(5))
        
        if self.passwordField.text != "" {
            self.timeField.text = Utils.formatCrackTime(time: passwordStrength.crackTime())
            UIView.transition(with: timeField, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.timeField.textColor = self.textColors[Int(passwordStrength.score())]
            }, completion: nil)
            PwnedPasswordsAPI.sharedInstance.cancelRequest()
            PwnedPasswordsAPI.sharedInstance.checkWithHash(passwordHash: passwordSHA1String, passwordHashPrefix: passwordSHA1StringTrimmed, completion: { (count) in
                if count == 0 {
                    self.breachLabel.text = "Your password wasn't found in any data breaches!"
                    UIView.transition(with: self.breachLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        self.breachLabel.textColor = self.noBreachColor
                    }, completion: nil)
                } else {
                    self.breachLabel.text = "Your password was found in one or more data breaches \(count) times"
                    UIView.transition(with: self.breachLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        self.breachLabel.textColor = self.breachColor
                    }, completion: nil)
                }
            })
            
        } else {
            self.timeField.text = "..."
            self.timeField.textColor = .black
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

