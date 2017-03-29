//
//  ViewController.swift
//  TouchIDDemo
//
//  Created by Hossam Ghareeb on 11/22/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }


    @IBAction func didClickOnAuthenticate(_ sender: Any) {
        let context = LAContext()
        var error: NSError? = nil
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error){
            
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Please authenticate to precess using the app.", reply: { (success, error) in
                
                if let error = error{
                    print(error)
                    self.showAlertWithMessage(msg: "A problen has occured while verification.")
                }
                else{
                    if success{
                        self.showAlertWithMessage(msg: "Thanks!\nYou're the device owner and we can proceed now.")
                    }
                    else{
                        self.showAlertWithMessage(msg: "Authentication has been failed as you're not the device owner.")
                    }
                }
            })
            
        }
        else{
            self.showAlertWithMessage(msg: "Touch ID is not available in your device!")
        }
    }
    
    func showAlertWithMessage(msg: String){
        let alertController = UIAlertController(title: "Authentication", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }

}

