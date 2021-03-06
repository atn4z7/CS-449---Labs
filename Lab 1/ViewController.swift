//
//  ViewController.swift
//  Lab 1
//
//  Created by ninja on 1/25/15.
//  Copyright (c) 2015 ninja. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation

class ViewController: UIViewController, UIAlertViewDelegate {
    //boolean variable to control text to speech
    var TTS:Bool!
    
    var outs: Int!
    var strike : Int!
    var ball : Int!
    @IBOutlet var Strike: UILabel!
    @IBOutlet var Ball: UILabel!
    @IBOutlet var OutLbl: UILabel!
    @IBOutlet var BallBtn: UIButton!
    @IBOutlet var StrikeBtn: UIButton!
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //adding border to buttons
        StrikeBtn.layer.cornerRadius = 2
        StrikeBtn.layer.borderWidth = 1
        StrikeBtn.layer.borderColor = StrikeBtn.tintColor!.CGColor
        BallBtn.layer.cornerRadius = 2
        BallBtn.layer.borderWidth = 1
        BallBtn.layer.borderColor = StrikeBtn.tintColor!.CGColor
        
        //get total outs
        getOuts()
        //get text to speech condition
        getTTS()
        
        //initialize strike and ball count
        strike = 0
        ball = 0
        //update display
        displayCount()
        
       
        // create home, reset, and settings buttons
        var aboutBtn = UIBarButtonItem(image: UIImage(named: "infoBtn.png"), style: .Plain, target: self, action: "gotoAbout")
        var resetBtn = UIBarButtonItem(image: UIImage(named: "refresh.png"), style: .Plain, target: self, action: "reset")
        var settingsBtn = UIBarButtonItem(image: UIImage(named: "settings.png"), style: .Plain, target: self, action: "gotoSettings")

        // create a spacer
        var spaceBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        spaceBtn.width = 2;
        
        var buttons: [UIBarButtonItem] = [aboutBtn,spaceBtn, settingsBtn, spaceBtn,resetBtn];
        //add bar buttons to navigation bar
        self.navigationItem.rightBarButtonItems = buttons;
        
    }
    
    //function to handle long press
    //Steps:
    //Call becomeFirstResponder() before getting sharedMenuController
    //Call menu.setMenuVisible(true, animated: true) at the end
    //Override the canBecomeFirstResponder function
    //Override the canPerformAction function
    //Write the function for the selector
    @IBAction func handleGesture(sender: AnyObject) {
        if sender.state == UIGestureRecognizerState.Began
        {
            becomeFirstResponder()
            var menu = UIMenuController.sharedMenuController()
            var strikeItem = UIMenuItem(title: "Strike", action: Selector("IncreaseStrike"))
            var ballItem = UIMenuItem(title: "Ball", action: Selector("IncreaseBall"))
            
            menu.menuItems = [strikeItem,ballItem]
            menu.setTargetRect(CGRectMake(100, 80, 50, 50), inView: self.view)
            menu.setMenuVisible(true, animated: true)
        }
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        if action == Selector("IncreaseStrike") {
            return true
        }
        else if action == Selector("IncreaseBall") {
            return true
        }
        return false
    }
    
    //function to get number of out from NSUserDefaults
    func getOuts(){
        if let Outs:AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("outs") {
            println(outs)
            outs = Outs as Int
        }
        else{
            //we haven't got any out yet, so set number of out to 0
            outs = 0;
        }
    }
    //function to get text to speech condition from NSUserDefaults
    func getTTS(){
        if let texttospeech:AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("TTS") {
            println(texttospeech)
            TTS = texttospeech as Bool
        }
        else{
            //text to speech is set to true by default
            TTS = true;
            NSUserDefaults.standardUserDefaults().setBool(true,forKey: "TTS")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    //function to speak a string
    func speak(text : NSString){
        var mySpeechSynthesizer:AVSpeechSynthesizer = AVSpeechSynthesizer()
        var mySpeechUtterance:AVSpeechUtterance = AVSpeechUtterance(string:text)
        mySpeechSynthesizer .speakUtterance(mySpeechUtterance)
    }
   
    //function to display an alert
    func alert(name: String!){
        //get text to speech condition
        getTTS()
        //speak out the alert if text to speech is true
        if (TTS!){
            speak(name)
        }
        //if this is out, then increment number of out and save it
        if (name == "Out!"){
            outs = outs + 1
            NSUserDefaults.standardUserDefaults().setInteger(outs, forKey: "outs")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        //check ios version to create correct alert
        if objc_getClass("UIAlertController") != nil {
            
            println("UIAlertController can be instantiated")
            
            //make and use a UIAlertController
            var myalert = UIAlertController(title: name,
                message: title,
                preferredStyle: UIAlertControllerStyle.Alert)
            myalert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: {
                (ACTION :UIAlertAction!)in
                //update display
                self.displayCount()
            }))
            self.presentViewController(myalert, animated: true, completion: nil)

            
            
        }
        else {
            
            println("UIAlertController can NOT be instantiated")
            
            //make and use a UIAlertView
            let alertView = UIAlertView(title: name, message: "", delegate: self, cancelButtonTitle: nil, otherButtonTitles: "OK")
            alertView.alertViewStyle = .Default
            alertView.show()
            
        }
    }
    //function to handle alert Okay button pressed for ios 7
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
        case 0:
            println("button okay pressed")
            //update display
            self.displayCount()
        default:
            println("default")
        }
    }
    
    //function to update display
    func displayCount(){
        Strike.text = String(strike)
        Ball.text = String(ball)
        OutLbl.text = String(outs)
    }
    
    //function to reset all counts
    func reset(){
        strike = 0
        ball = 0
        outs = 0
        NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "outs")
        NSUserDefaults.standardUserDefaults().synchronize()
        //update display
        displayCount()
    }
    
    //function to go to About screen
    func gotoAbout(){
        
        self.performSegueWithIdentifier("showAbout", sender: self)
        
        //alternative method to go to about screen
        //showing an action sheet (kind of a overflow menu) and choose go to about action
        /*
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let aboutAction = UIAlertAction(title: "About", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            println("going to about screen")
            self.performSegueWithIdentifier("showAbout", sender: self)
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            println("Cancelled")
        })
  
        optionMenu.addAction(aboutAction)
        optionMenu.addAction(cancelAction)

        self.presentViewController(optionMenu, animated: true, completion: nil)
        */
        
    }
 
    //function to go to Settings screen
    func gotoSettings(){
        
        self.performSegueWithIdentifier("showSettings", sender: self)
        
    }
    
    //function to increment strike
    @IBAction func IncreaseStrike() {
        strike = strike + 1
        //if strike reaches 3 then alert "out"
        if (strike == 3){
            //reset all counts
            strike = 0;
            ball = 0;
            alert("Out!")
        }
        else{
        //update display
            displayCount()
        }
    }
    
    //function to increment ball
    @IBAction func IncreaseBall() {
        ball = ball + 1
         //if ball reaches 4 then alert "walk"
        if (ball == 4){
            //reset all counts
            strike = 0;
            ball = 0;
            alert("Walk!")
        }
        else{
            //update display
            displayCount()
        }
    }
    
    
    
}

