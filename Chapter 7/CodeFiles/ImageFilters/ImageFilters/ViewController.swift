//
//  ViewController.swift
//  ImageFilters
//
//  Created by Hossam Ghareeb on 10/4/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var filtersPickerView: UIPickerView!
    
    var filters: [String]!
    var originalImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.originalImage = imageView.image
        self.filters = prepareFilters()
        self.filters.insert("Original", at: 0)
    }
    func prepareFilters() -> [String] {
        let names = CIFilter.filterNames(inCategory: kCICategoryBuiltIn).filter { (name) -> Bool in
            
            if ["CINinePartStretched", "CINinePartTiled", "CIDroste"].contains(name) {
                return false
            }
            guard let filter = CIFilter(name: name) else { fatalError() }
            guard let categories = filter.attributes[kCIAttributeFilterCategories] as? [String] else { fatalError() }
            
            if categories.contains(kCICategoryGradient) {
                return false
            }
            
            let versionStr = filter.attributes[kCIAttributeFilterAvailable_iOS] as? String ?? "0"
            let versionInt = Int(versionStr)
            if versionInt == 10 {
                return true
            } else {
                return false
            }
        }
        return names
    }
    
     func applyFilter(name: String, handler: ((UIImage?) -> Void)) {
        let inputImage = CIImage(image: self.originalImage)!
        guard let filter = CIFilter(name: name) else { fatalError() }
        let attributes = filter.attributes
        
        if attributes[kCIInputImageKey] == nil {
            print("\(name) has no inputImage property.")
            handler(nil)
            return
        }
        
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setDefaults()
        
        // Apply filter
        let context = CIContext(options: nil)
        guard let outputImage = filter.outputImage else {
            handler(nil)
            return
        }
        
        let size = self.imageView.frame.size
        var extent = outputImage.extent
        let scale: CGFloat!
        
        // some outputImage have infinite extents. e.g. CIDroste
        if extent.isInfinite {
            scale = UIScreen.main.scale
            extent = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        } else {
            scale = extent.size.width / self.originalImage.size.width
        }
        
        guard let cgImage = context.createCGImage(outputImage, from: extent) else {fatalError()}
        let image = UIImage(cgImage: cgImage, scale: scale, orientation: .up)
        
        handler(image)
    }
    
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return filters[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            imageView.image = self.originalImage
            return
        }
        
        DispatchQueue.global(qos: .default).async {
            self.applyFilter(name: self.filters[row], handler: { (image) in
                DispatchQueue.main.async(execute: {
                    self.imageView.image = image
                })
            })
        }
    }
    
}
extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.filters.count
    }
}


