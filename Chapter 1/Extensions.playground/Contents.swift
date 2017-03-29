//: Playground - noun: a place where people can play

import UIKit


extension Double {
    
    var absoluteValue: Double {
        return abs(self)
    }
    
    var intValue: Int {
        return Int(self)
    }
}

extension String {
    
    var length: Int {
        return self.characters.count
    }
}

let doubleValue: Double = -19.5
doubleValue.absoluteValue // 19.5
doubleValue.intValue // 19

//============== methods =====

extension Int {
    
    func isEven() -> Bool {
        return self % 2 == 0
    }
    
    func isOdd() -> Bool {
        return !isEven()
    }
    
    func digits() -> [Int] {
        var digits = [Int]()
        var num = self
        repeat {
            
            let digit = num % 10
            digits.append(digit)
            num /= 10
            
        } while num != 0
        
        return digits
    }
}

let num = 12345
num.digits()  // [5, 4, 3, 2, 1]


//============= Mutating ======

extension Int {
    mutating func  square() {
        self = self * self
    }
    
    mutating func double() {
        self = self * 2
    }
}

var value = 8
value.double() // 16
value.square() // 256


//===================== init 

extension CGRect {
    init(center:CGPoint, size:CGSize) {
        let x = center.x - size.width / 2
        let y = center.y - size.height / 2
        self.init(x: x, y: y, width: size.width, height: size.height)
    }
}

let rect = CGRect(center: CGPoint(x: 50, y: 50), size: CGSize(width: 100, height: 80)) // {x 0 y 10 w 100 h 80}

// ================ subscipt ======

extension String {
    subscript(charIndex: Int) -> Character {
        let i = index(startIndex, offsetBy: charIndex)
        return self[i]
    }
}

let str = "Hello"

str[0] // "H"


