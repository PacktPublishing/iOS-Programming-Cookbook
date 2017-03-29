//
//  ViewController.swift
//  ScrollViewDemo
//
//  Created by Hossam Ghareeb on 9/6/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate{

    @IBOutlet weak var currentScrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listenToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unlistenToKeyboardNotifications()
    }
    
    // MARK: - Keyboard Notifications & Animations -
    
    private func listenToKeyboardNotifications(){
        //receive notification for keyboard
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    private func unlistenToKeyboardNotifications(){
        //unregister receive notification for keyboard
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    @objc private func keyboardWasShown(notification:NSNotification){
        
        var info : Dictionary = notification.userInfo!
        let kbSize = (info[UIKeyboardFrameBeginUserInfoKey] as AnyObject).cgRectValue.size
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, (kbSize.height), 0.0)
        self.currentScrollView.contentInset = contentInsets
        self.currentScrollView.scrollIndicatorInsets = contentInsets
        self.perform(#selector(ViewController.scrollToBottom), with: nil, afterDelay: 0)
    }
    
    @objc private func scrollToBottom(){
        let offset = CGPoint(x: 0, y: self.currentScrollView.contentSize.height - self.currentScrollView.bounds.height + self.currentScrollView.contentInset.bottom)
        
        self.currentScrollView.setContentOffset(offset, animated: true)
    }

}

