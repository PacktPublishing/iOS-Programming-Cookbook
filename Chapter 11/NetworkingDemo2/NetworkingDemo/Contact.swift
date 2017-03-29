//
//  Contact.swift
//  NetworkingDemo
//
//  Created by Hossam Ghareeb on 12/6/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

enum Gender{
    case Male
    case Female
    case Other
}

extension Gender{
    init(gender: String) {
        switch gender.lowercased() {
        case "male":
            self = .Male
        case "female":
            self = .Female
        default:
            self = .Other
        }
    }
}

struct Contact{
    let gender: Gender
    let title: String
    let firstName: String
    let lastName: String
    let email: String
    let cellPhone: String
    let pictureURLString: String
    
    init(json: Dictionary<String, Any>) {
        let genderString = json["gender"] as? String ?? "other"
        self.gender = Gender(gender: genderString)
        if let name = json["name"] as? Dictionary<String, String>{
            self.title = name["title"] ?? ""
            self.firstName = name["first"] ?? ""
            self.lastName = name["last"] ?? ""
        }
        else{
            self.title = ""
            self.firstName = ""
            self.lastName = ""
        }
        
        self.email = json["email"] as? String ?? ""
        self.cellPhone = json["cell"] as? String ?? ""
        if let picture = json["picture"] as? Dictionary<String, String>{
            self.pictureURLString = picture["large"] ?? ""
        }
        else{
            self.pictureURLString = ""
        }
    }
}
