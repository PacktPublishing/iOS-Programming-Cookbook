//
//  ContactsManager.swift
//  NetworkingDemo
//
//  Created by Hossam Ghareeb on 12/4/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

typealias CompletionHandler = (_ success: Bool) -> ()

class ContactsManager: NSObject {
    
    func fetchContacts(handler: @escaping CompletionHandler){
        let session = URLSession.shared
        
        let url = URL(string: "https://randomuser.me/api/")
        let dataTask = session.dataTask(with: url!, completionHandler: { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                handler(false)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print(responseString)
                    handler(true)
                    
                }
                else{
                    handler(false)
                }
            }
        })
        dataTask.resume()
        
    }
}
