//
//  ContactsManager.swift
//  NetworkingDemo
//
//  Created by Hossam Ghareeb on 12/4/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

typealias CompletionHandler = (_ success: Bool, _ contacts: [Contact]) -> ()

class ContactsManager: NSObject {
    
    func fetchContacts(page: Int, pageSize: Int, handler: @escaping CompletionHandler){
        let session = URLSession.shared
        
        let url = URL(string: "https://randomuser.me/api/?page=\(page)&results=\(pageSize)")
        let dataTask = session.dataTask(with: url!, completionHandler: { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                handler(false, [])
            } else if let httpResponse = response as? HTTPURLResponse {
                var success = false
                var allContacts = [Contact]()
                if httpResponse.statusCode == 200 {
                    if let responseData = data{
                        do{
                            let json = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as! Dictionary<String, Any>
                            let contacts = self.parseContactsJSON(json: json)
                            allContacts.append(contentsOf: contacts)
                            success = true
                            
                        }
                        catch{
                            print(error)
                        }
                    }
                }
                handler(success, allContacts)
            }
        })
        dataTask.resume()
        
    }
    
    func parseContactsJSON(json: Dictionary<String, Any>) -> [Contact]{
        var contacts = [Contact]()
        if let contactsJson = json["results"] as? [Dictionary<String, Any>]{
            for contactObj in contactsJson {
                let contact = Contact(json: contactObj)
                contacts.append(contact)
            }
        }
        return contacts
    }
}


