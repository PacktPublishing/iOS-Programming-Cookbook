//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

protocol ProtocolName {
    // List of properties and methods goes here....
}

class SampleClass: ProtocolName {
    
}

protocol VehicleProtocol {
    
    // properties
    var name: String {set get} // settable and gettable
    var canFly: Bool {get} // gettable only (readonly)
    
    // instance methods
    func numberOfWheels() -> Int
    func move()
    func stop()
    
    // class method
    static func popularBrands() -> [String]
}

class Bicycle: VehicleProtocol {
    var name: String
    var canFly: Bool {
        return false
    }
    
    init(name: String) {
        self.name = name
    }
    
    func numberOfWheels() -> Int {
        return 2
    }
    func move() {
        // move logic goes here
    }
    func stop() {
        // stop logic goes here
    }
    static func popularBrands() -> [String] {
        return ["Giant", "GT", "Marin", "Trek", "Merida", "Specialized"]
    }
}

class Car: VehicleProtocol {
    var name: String
    var canFly: Bool {
        return false
    }
    
    init(name: String) {
        self.name = name
    }
    
    func numberOfWheels() -> Int {
        return 4
    }
    func move() {
        // move logic goes here
    }
    func stop() {
        // stop logic goes here
    }
    static func popularBrands() -> [String] {
        return ["Audi", "BMW", "Honda", "Dodge", "Lamborghini", "Lexus"]
    }
}

let bicycle1 = Bicycle(name: "Merida 204")
bicycle1.numberOfWheels() // 2

let car1 = Car(name: "Honda Civic")
car1.canFly // false

Bicycle.popularBrands() // Class function
// ["Giant", "GT", "Marin", "Trek", "Merida", "Specialized"]
Car.popularBrands() // ["Audi", "BMW", "Honda", "Dodge", "Lamborghini", "Lexus"]


//============= mutating ====

protocol Togglable {
    mutating func toggle()
}

enum Switch: Togglable {
    case ON
    case OFF
    
    mutating func toggle() {
        switch self {
        case .ON:
            self = .OFF
        default:
            self = .ON
        }
    }
}

//================= delegate =========

@objc protocol DownloadManagerDelegate {
    func didDownloadFile(fileURL: String, fileData: NSData)
    @objc optional func didFailToDownloadFile(fileURL: String, error: NSError)
}

class DownloadManager {
    
    weak var delegate: DownloadManagerDelegate!
    
    func downloadFileAtURL(url: String) {
        // send request to download file
        // check response and success or failure
        if let delegate = self.delegate {
            delegate.didDownloadFile(fileURL: url, fileData: NSData())
        }
    }
}

class ViewController: UIViewController, DownloadManagerDelegate {
    
    func startDownload() {
        
        let downloadManager = DownloadManager()
        downloadManager.delegate = self
    }
    
    func didDownloadFile(fileURL: String, fileData: NSData) {
        // present file here
    }
    
    func didFailToDownloadFile(fileURL: String, error: NSError) {
        
        // Show error message
    }
}

//============================ class only =========

protocol ClassOnlyProtocol: class {
    // class only properties and methods go here
}

/// =============  Protocol conformance =============

class Rocket {
    
}

var movingObjects = [Bicycle(name: "B1"), Car(name:"C1"), Rocket()] as [Any]

for item in movingObjects {
    if let vehicle =  item as? VehicleProtocol {
        print("Found vehcile with name \(vehicle.name)")
        vehicle.move()
    }
    else {
        print("Not a vehcile")
    }
}
