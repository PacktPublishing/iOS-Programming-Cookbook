//
//  ViewController.swift
//  ImageVideoPicker
//
//  Created by Hossam Ghareeb on 10/2/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func didClickOnPickButton(_ sender: AnyObject) {
        
        let actionSheetController = UIAlertController(title: "Pick media", message: "From where to you want to pick your photo or video", preferredStyle: .actionSheet)
        let photosAction = UIAlertAction(title: "Photos", style: .default) { (action) in
            self.openPickerWithSourceType(type: .photoLibrary)
        }
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.openPickerWithSourceType(type: .camera)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheetController.addAction(photosAction)
        actionSheetController.addAction(cameraAction)
        actionSheetController.addAction(cancelAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
        
    }
    
    func openPickerWithSourceType(type: UIImagePickerControllerSourceType) {
        
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]
        imagePickerViewController.delegate = self
        imagePickerViewController.sourceType = type
        self.present(imagePickerViewController, animated: true, completion: nil)

    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        print(info)
        let type = info[UIImagePickerControllerMediaType] as! String
        if type == kUTTypeImage as String{
            print("Done picking image")
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
        }
        else {
            print("Done picking video")
            if let videoURL = info[UIImagePickerControllerMediaURL] {
                print(videoURL)
            }
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

