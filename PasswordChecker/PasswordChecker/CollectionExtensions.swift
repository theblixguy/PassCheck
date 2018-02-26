//
//  CollectionExtensions.swift
//  PasswordChecker
//
//  Created by Suyash Srijan on 24/02/2018.
//  Copyright © 2018 Suyash Srijan. All rights reserved.
//

import Foundation

extension Collection where Index == Int {
    func randomElement() -> Iterator.Element? {
        return isEmpty ? nil : self[Int(arc4random_uniform(UInt32(endIndex)))]
    }
}
