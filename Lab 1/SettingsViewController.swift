//
//  SettingsViewController.swift
//  Lab 1
//
//  Created by ninja on 2/6/15.
//  Copyright (c) 2015 ninja. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore
import AVFoundation

class SettingsViewController: UIViewController, UIAlertViewDelegate {
    //boolean variable to control text to speech
    var TTS:Bool!
    
    @IBOutlet var ttsSwitch: UISwitch!
   
    @IBOutlet var settings: UILabel!
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settings.numberOfLines = 0
        
        //get text to speech condition
        if let texttospeech:AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("TTS") {
            println(texttospeech)
            TTS = texttospeech as Bool
        }
     
        //assign value to the switch
        ttsSwitch.setOn(TTS, animated: true)
    
    }
    
    //function to handle switch value changes
    @IBAction func valueChanged() {
        if ttsSwitch.on {
            NSUserDefaults.standardUserDefaults().setBool(true,forKey: "TTS")
        } else {
            NSUserDefaults.standardUserDefaults().setBool(false,forKey: "TTS")
        }
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}
    

    