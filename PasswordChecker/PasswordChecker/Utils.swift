//
//  Utils.swift
//  PasswordChecker
//
//  Created by Suyash Srijan on 22/02/2018.
//  Copyright © 2018 Suyash Srijan. All rights reserved.
//

import Foundation

final class Utils {
    
    static func formatCrackTime(time: Double!) -> String! {
        if time < Double(Int.max) {
            let seconds: Int = Int(time)
            let minutes: Int = seconds / 60
            let hours: Int = minutes / 60
            let days: Int = hours / 24
            let years: Int = days / 365
            let centuries = years / 100
            
            if seconds < 60 {
                return seconds == 0 ? "less than 1 second" : String(seconds) + " seconds"
            } else if minutes < 60 {
                return minutes == 0 ? "less than 1 minute" : String(minutes) + " minutes"
            } else if hours < 24 {
                return hours == 1 ? "less than 1 hour" : String(hours) + " hours"
            } else if days < 30 {
                return days == 0 ? "less than 1 day" : String(days) + " days"
            } else if years < 12 {
                return years == 0 ? "less than 1 year" : String(years) + " years"
            } else if centuries < 100000 {
                return centuries == 0 ? "less than 1 century" : String(centuries) + " centuries"
            } else {
                let formatter: NumberFormatter = NumberFormatter()
                formatter.multiplier = NSNumber(value: 0.000001)
                return formatter.string(from: NSNumber(value: years))! + " million years"
            }
        } else {
            return "100 billion years or more"
        }
    }
    
}
