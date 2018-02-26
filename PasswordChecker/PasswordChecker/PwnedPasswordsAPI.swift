//
//  PwnedPasswordsAPI.swift
//  PasswordChecker
//
//  Created by Suyash Srijan on 22/02/2018.
//  Copyright © 2018 Suyash Srijan. All rights reserved.
//

import Foundation
import Alamofire

final class PwnedPasswordsAPI {
    
    static var sharedInstance: PwnedPasswordsAPI = PwnedPasswordsAPI()
    private var request: Request?
    
    func checkWithPassword(password: String!, completion: @escaping (Int) -> ()) {
        request = Alamofire.request("https://api.pwnedpasswords.com/pwnedpassword/\(password!)", method: .get).responseString { response in
            switch response.result {
            case .success:
                if let body = response.result.value {
                    let count: Int = Int(body) ?? 0
                    completion(count)
                } else {
                    completion(0)
                }
            case .failure:
                completion(0)
            }
        }
    }
    
    func checkWithHash(passwordHash: String!, passwordHashPrefix: String!, completion: @escaping (Int) -> ()) {
        request = Alamofire.request("https://api.pwnedpasswords.com/range/\(passwordHashPrefix!)", method: .get).responseString { response in
            switch response.result {
            case .success:
                if let body: String = response.result.value {
                    let array: Array<String> = body.components(separatedBy: CharacterSet.newlines).filter { !($0).isEmpty }
                    var found: Bool = false
                    if array.isEmpty {
                        completion(0)
                        return
                    }
                    for line in array {
                        let suffixCountArray: Array<Substring> = line.split(separator: ":")
                        let hashSuffix: String = String(suffixCountArray[0])
                        let count: Int = Int(String(suffixCountArray[1]))!
                        let reconstructedHash: String = passwordHashPrefix.uppercased() + hashSuffix.uppercased()
                        let originalHash: String = passwordHash.uppercased()
                        if reconstructedHash == originalHash {
                            found = true
                            completion(count)
                        }
                    }
                    if !found {
                        completion(0)
                        return
                    }
                } else {
                    completion(0)
                }
            case .failure:
                completion(0)
            }
        }
    }
    
    func cancelRequest() {
        request?.cancel()
    }
    
}
