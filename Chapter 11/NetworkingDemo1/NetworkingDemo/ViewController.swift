//
//  ViewController.swift
//  NetworkingDemo
//
//  Created by Hossam Ghareeb on 12/3/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var connectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func didClickOnConnectButton(_ sender: Any) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let contactsManager = ContactsManager()
        self.connectButton.setTitle("Connecting....", for: .normal)
        self.connectButton.isEnabled = false
        contactsManager.fetchContacts { (success) in
            
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                print(success)
                
                self.connectButton.setTitle("Finishing connection", for: .normal)
            }
        }
    }
    
}

