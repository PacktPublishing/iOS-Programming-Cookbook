//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Dog {
    
    var name: String
    weak var owner: Person!
    
    init(name: String) {
        self.name = name
    }
}

class Person {
    var name: String
    var id: Int
    var dogs = [Dog]()
    
    init(name: String, id: Int) {
        self.name = name
        self.id = id
    }
}

let john = Person(name: "John", id: 1)

let rex = Dog(name: "Rex")
let rocky = Dog(name: "Rocky")

john.dogs += [rex, rocky] // append dogs
rex.owner = john
rocky.owner = john

//------------ closures

class HTMLElement {
    
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        
        [unowned self] in
        
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
}

let heading = HTMLElement(name: "h1", text: "h1 title")

print(heading.asHTML()) // <h1>h1 title</h1>
