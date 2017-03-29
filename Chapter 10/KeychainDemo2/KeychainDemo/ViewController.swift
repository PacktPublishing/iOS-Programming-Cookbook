//
//  ViewController.swift
//  KeychainDemo
//
//  Created by Hossam Ghareeb on 11/23/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit
import KeychainAccess
import Crypto

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let session = "13u989843-3232023-323234-fdij8nk-jlk48a-hknut"
        let digest = HMAC.sign(message: session, algorithm: .sha512, key: "secretKey")
        let keyChain = Keychain(service: "hossamghareeb.keychainDemo")
        keyChain["session"] = digest
        
        if let session = keyChain["session"]{
            print(session)
        }
        
    }
}

