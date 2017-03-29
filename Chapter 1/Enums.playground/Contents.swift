//: Playground - noun: a place where people can play

import UIKit

enum Monster {
    case Lion
    case Tiger
    case Bear
    case Crocs
}

enum Moster2 {
    case Lion, Tiger, Bear, Crocs
}

var monster1 = Monster.Lion
let monster2 = Monster.Tiger

monster1 = .Bear


func monsterPowerFromType(monster:Monster) -> Int {
    
    var power = 0
    
    switch monster1 {
    case .Lion:
        power = 100
    case .Tiger:
        power = 80
    case .Bear:
        power  = 90
    case .Crocs:
        power = 70
    }
    return power
}

let power = monsterPowerFromType(monster: monster1) // 90


func canMonsterSwim(monster:Monster) -> Bool {
    
    switch monster {
    case .Crocs:
        return true
    default:
        return false
    }
}

let canSwim = canMonsterSwim(monster: monster1) // false

///// =========================  Raw Values ========================

enum IntEnum: Int {
    case case1 = 50
    case case2 = 60
    case case3 = 100
}

enum Emoji: Character {
    case Happy = "😀"
    case Neutral = "😐"
    case Sad = "😔"
}

enum Gender: Int {
    case Male
    case Female
    case Other
}

var maleValue = Gender.Male.rawValue  // 0
var femaleValue = Gender.Female.rawValue // 1


enum HTTPCode: Int {
    case OK = 200
    case Created  // 201
    case Accepted // 202
    
    case BadRequest = 400
    case UnAuthorized
    case PaymentRequired
    case Forbidden
    case NotFound
}

let pageNotFound = HTTPCode.NotFound
let errorCode = pageNotFound.rawValue  // 404


enum Season: String {
    case Winter
    case Spring
    case Summer
    case Autumn
}

let winter = Season.Winter

let statement = "My preferred season is " + winter.rawValue // "My preferred season is Winter"


//let httpCode = HTTPCode(rawValue: 404)  // NotFound
let httpCode2 = HTTPCode(rawValue: 1000) // nil

if let httpCode = HTTPCode(rawValue: 404) {
    print(httpCode)
}
if let httpCode2 = HTTPCode(rawValue: 1000) {
    print(httpCode2)
}

/////////////////////////////////  Associated values /////////////////


enum ProductCode {
    case UPC(Int, Int, Int, Int)
    case QR(String)
}

var productCode = ProductCode.UPC(4, 88581, 1497, 3)
productCode = ProductCode.QR("BlaBlaBla")

switch productCode {
case .UPC(let numberSystem, let manufacturerCode, let productCode, let checkDigit):
    print("Product UPC code is \(numberSystem) \(manufacturerCode) \(productCode) \(checkDigit)")
case .QR(let QRCode):
    print("Product QR code is \(QRCode)")
}

// "Product QR code is BlaBlaBla"

