//: Playground - noun: a place where people can play

import UIKit

enum DBConnectionError: Error {
    case ConnectionClosed
    case DBNotExist
    case DBNotWritable
}

enum SignUpUserError: Error {
    
    case InvalidFirstOrLastName
    case InvalidEmail
    case WeakPassword
    case PasswordsDontMatch
}

func signUpNewUserWithFirstName(firstName: String, lastName: String, email: String, password: String, confirmPassword: String) throws {
    
    guard firstName.characters.count > 0 && lastName.characters.count > 0 else {
        
        throw SignUpUserError.InvalidFirstOrLastName
    }
    
    guard isValidEmail(email: email) else {
        throw SignUpUserError.InvalidEmail
    }
    
    guard password.characters.count > 8 else {
        throw SignUpUserError.WeakPassword
    }
    
    guard password == confirmPassword else {
        throw SignUpUserError.PasswordsDontMatch
    }
    
    // Saving logic goes here
    
    print("Successfully signup user")
    
}

func isValidEmail(email:String) -> Bool {
    
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
    return predicate.evaluate(with: email)
}


do{
    try signUpNewUserWithFirstName(firstName: "John", lastName: "Smith", email: "john@gmail.com", password: "123456789", confirmPassword: "123456788")
}
//catch{
//    switch error{
//    case SignUpUserError.InvalidFirstOrLastName:
//        print("Invalid First name or last name")
//    case SignUpUserError.InvalidEmail:
//        print("Email is not correct")
//    case SignUpUserError.WeakPassword:
//        print("Password should be more than 8 characters long")
//    case SignUpUserError.PasswordsDontMatch:
//        print("Passwords don't match")
//    default:
//        print(error)
//    }
//}
catch SignUpUserError.InvalidFirstOrLastName {
    
}
catch SignUpUserError.InvalidEmail {
    
}
catch SignUpUserError.WeakPassword {
    
}
catch SignUpUserError.PasswordsDontMatch {
    
}

