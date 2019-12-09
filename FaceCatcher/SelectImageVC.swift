//
//  ViewController.swift
//  FaceCatcher
//
//  Created by ah on 12/8/19.
//  Copyright © 2019 boshra. All rights reserved.
//

import UIKit
import Toaster
import CoreImage


class SelectImageVC: UIViewController {

        @IBOutlet weak var imageView: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func btnSelectImage(_ sender: UIButton) {
        NSLog("Btn Select Image")
        Toast(text: "Btn Select Image").show()
        
        
        
        
        
    }
    
    
    @IBAction func btnStartFaceDetection(_ sender: UIButton) {
        NSLog("Btn Start Detection")
        Toast(text: "Btn Start Detection").show()
        
        detect()
        
        
    }
    
    @IBAction func btnEditImage(_ sender: UIBarButtonItem) {
        NSLog("Bar Button Item")
        
        let viewControllerImageEffects = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageEffectsCv") as? ImageEffectsVC
        
        self.navigationController?.pushViewController(viewControllerImageEffects!, animated: true)
    
        
        
        
        
    }

    func detect() {
        
        //we create a variable personciImage that extracts the UIImage out of the UIImageView in the storyboard and converts it to a CIImage. CIImage is required when using Core Image
        guard let personciImage = CIImage(image: self.imageView.image!) else {
            return
        }
        
        
        // we create an accuracy variable and set to CIDetectorAccuracyHigh. You can pick from CIDetectorAccuracyHigh (which provides high processing power) and CIDetectorAccuracyLow (which uses low processing power). For the purposes of this tutorial and we choose CIDetectorAccuracyHigh because we want high accuracy.
        let accuracyHeigh = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        //let accuracyLow = [CIDetectorAccuracy: CIDetectorAccuracyLow]
        
        //here we define a faceDetector variable and set it to the CIDetector class and pass in the accuracy variable we created above.
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracyHeigh)
        
        //here we define a faceDetector variable and set it to the CIDetector class and pass in the accuracy variable we created above
        let faces = faceDetector!.features(in: personciImage)
        
        
        
        //by calling the featuresInImage method of faceDetector, the detector finds faces in the given image. At the end, it returns us an array of faces.
        //ere we loop through the array of faces and cast each of the detected face to CIFaceFeature.
        for face in faces as! [CIFaceFeature] {
            
            print("Found bounds are \(face.bounds)")
            
            let faceBox = UIView(frame: face.bounds)
            
            //we set the faceBox’s border width to 3.
            faceBox.layer.borderWidth = 3
            //we set the border color to red.
            faceBox.layer.borderColor = UIColor.red.cgColor
            //The background color is set to clear, indicating that this view will not have a visible background.
            faceBox.backgroundColor = UIColor.clear
            //Finally, we add the view to the personPic imageView.
            self.imageView.addSubview(faceBox)
            
            
            
            if face.hasLeftEyePosition {
                print("Left eye bounds are \(face.leftEyePosition)")
            }
            
            if face.hasRightEyePosition {
                print("Right eye bounds are \(face.rightEyePosition)")
            }
        }
    }
    
    
}

