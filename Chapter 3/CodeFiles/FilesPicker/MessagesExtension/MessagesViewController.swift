//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Hossam Ghareeb on 7/20/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit
import Messages
import GoogleAPIClient
import GTMOAuth2

class MessagesViewController: MSMessagesAppViewController {
    
    
    private let kKeychainItemName = "Drive API"
    private let kClientID = "718517467805-eee201q0idi08q8l9tkbmkh2nr63m9pn.apps.googleusercontent.com"
    
    // If modifying these scopes, delete your previously saved credentials by
    // resetting the iOS simulator or uninstall the app.
    private let scopes = [kGTLAuthScopeDriveMetadataReadonly]
    
    private let service = GTLServiceDrive()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        if let auth = GTMOAuth2ViewControllerTouch.authForGoogleFromKeychain(forName:
            kKeychainItemName,
            clientID: kClientID,
            clientSecret: nil) {
            service.authorizer = auth
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let authorizer = service.authorizer,
            let canAuth = authorizer.canAuthorize, canAuth {
            fetchFiles()
        } else {
            present(createAuthController(), animated: true, completion: nil)
            
        }
    }
    
    
    // Construct a query to get names and IDs of 10 files using the Google Drive API
    func fetchFiles() {
        if let query = GTLQueryDrive.queryForFilesList(){
            
            query.pageSize = 20
            query.fields = "nextPageToken, files(id, name, webViewLink, webContentLink)"
            service.executeQuery(query, delegate: self, didFinish: #selector(MessagesViewController.displayResultWithTicket(ticket:finishedWithObject:error:)))
            
        }
        
    }
    
    // Parse results and display
    func displayResultWithTicket(ticket : GTLServiceTicket,
                                 finishedWithObject response : GTLDriveFileList,
                                 error : NSError?) {
        
        if let error = error {
            showAlert(title: "Error", message: error.localizedDescription)
            return
        }
        
        var filesString = ""
        
        let files = response.files as! [GTLDriveFile]
        if !files.isEmpty{
            filesString += "Files:\n"
            
            for file in files {
                filesString += "\(file.name) (\(file.webContentLink) (\(file.webViewLink))\n"
            }

        }
       else {
            filesString = "No files found."
        }
        
        print(filesString)
    }
    
    
    // Creates the auth controller for authorizing access to Drive API
    private func createAuthController() -> GTMOAuth2ViewControllerTouch {
        let scopeString = scopes.joined(separator:" ")
        return GTMOAuth2ViewControllerTouch(
            scope: scopeString,
            clientID: kClientID,
            clientSecret: nil,
            keychainItemName: kKeychainItemName,
            delegate: self,
            finishedSelector: #selector(MessagesViewController.viewController(vc:finishedWithAuth:error:))
        )
    }
    
    // Handle completion of the authorization process, and update the Drive API
    // with the new credentials.
    func viewController(vc : UIViewController,
                        finishedWithAuth authResult : GTMOAuth2Authentication, error : NSError?) {
        
        if let error = error {
            service.authorizer = nil
            showAlert(title: "Authentication Error", message: error.localizedDescription)
            return
        }
        
        service.authorizer = authResult
        dismiss(animated: true, completion: nil)
        fetchFiles()
    }
    
    // Helper for showing an alert
    func showAlert(title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.default,
            handler: nil
        )
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the inactive to active state.
        // This will happen when the extension is about to present UI.
        
        // Use this method to configure the extension and restore previously stored state.
    }
    
    override func didResignActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dissmises the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
    }
   
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
    
        // Use this to clean up state related to the deleted message.
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called before the extension transitions to a new presentation style.
    
        // Use this method to prepare for the change in presentation style.
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
    
        // Use this method to finalize any behaviors associated with the change in presentation style.
    }

}
