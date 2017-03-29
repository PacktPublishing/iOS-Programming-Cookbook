//
//  ViewController.swift
//  NetworkingDemo
//
//  Created by Hossam Ghareeb on 12/3/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contactsTableView: UITableView!
    
    var contacts = [Contact]()
    var currentPageIndex = 0
    let pageSize = 10
    var noMorePages = false
    var loadingPage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadNextPage()
    }
    
    func loadNextPage(){
        if noMorePages || loadingPage{
            return
        }
        loadingPage = true
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let contactsManager = ContactsManager()
        contactsManager.fetchContacts(page: currentPageIndex, pageSize: pageSize) { (success, newContacts) in
            
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                self.loadingPage = false
                if success{
                    if newContacts.isEmpty{
                        self.noMorePages = true
                    }
                    else{
                        self.contacts.append(contentsOf: newContacts)
                        self.contactsTableView.reloadData()
                        self.currentPageIndex += 1
                    }
                }
                
            }
        }
    }
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contact")
        let contact = self.contacts[indexPath.row]
        cell?.textLabel?.text = "\(contact.title) \(contact.firstName) \(contact.lastName)"
        return cell!
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.contacts.count - 1{
            loadNextPage()
        }
    }
}
