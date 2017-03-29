//: Playground - noun: a place where people can play

import UIKit

class StackInt {
    var elements = [Int]()
    
    func push(element:Int)
    {
        self.elements.append(element)
    }
    func pop() -> Int
    {
        return self.elements.removeLast()
    }
    func isEmpty()->Bool
    {
        return self.elements.isEmpty
    }
}

var stack1 = StackInt()
stack1.push(element: 5)    // [5]
stack1.push(element: 10)  //[5,10]
stack1.push(element: 20) // [5,10,20]
stack1.pop()   // 20


class Stack <T> {
    var elements = [T]()
    func push(element:T)
    {
        self.elements.append(element)
    }
    func pop()->T{
        return self.elements.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push(element: "str1")
stackOfStrings.push(element: "str2")
stackOfStrings.pop()

var stackOfInt = Stack<Int>()
stackOfInt.push(element: 4)
stackOfInt.push(element: 7)
stackOfInt.pop()
