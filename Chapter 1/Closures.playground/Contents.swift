//: Playground - noun: a place where people can play

import UIKit

var names = ["David", "Jones", "Suzan", "Naomi", "Adam"]

names.sort() // ["Adam", "David", "Jones", "Naomi", "Suzan"]
names.sort { (str1: String, str2: String) -> Bool in
    return str1 > str2
}

// ["Suzan", "Naomi", "Jones", "David", "Adam"]

names.sort { str1, str2 in
    return str1 > str2
}

names.sorted(by: { $0 > $1})

