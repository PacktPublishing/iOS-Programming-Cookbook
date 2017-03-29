//
//  ImageDownloader.swift
//  GCDDemo
//
//  Created by Hossam Ghareeb on 10/16/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit
import Foundation

class ImageDownloader: Operation {
    let imgURL: URL
    var downloadedImage: UIImage?
    init(imageURL: URL) {
        self.imgURL = imageURL
    }
    
    override func main() {
        if self.isCancelled {
            return
        }
        
        do{
            let data = try Data(contentsOf: self.imgURL)
            if self.isCancelled {
                return
            }
            self.downloadedImage = UIImage(data: data)
        }
        catch{
            print(error)
        }
    }
}
