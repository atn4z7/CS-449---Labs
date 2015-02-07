//
//  ViewController.swift
//  Lab 1
//
//  Created by ninja on 1/25/15.
//  Copyright (c) 2015 ninja. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    var outs: Int!
    var strike : Int!
    var ball : Int!
    @IBOutlet var Strike: UILabel!
    @IBOutlet var Ball: UILabel!
    @IBOutlet var OutLbl: UILabel!
    
    @IBOutlet var BallBtn: UIButton!
    @IBOutlet var StrikeBtn: UIButton!

    
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
        if let Outs:AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("outs") {
            println(outs)
            outs = Outs as Int
        }
        else{
            //we haven't got any out yet, so set number of out to 0
            outs = 0;
        }

        
        //initialize strike and ball count
        strike = 0
        ball = 0
        //update display
        displayCount()
        
       
        // create home and reset buttons
        var homeBtn = UIBarButtonItem(image: UIImage(named: "infoBtn.png"), style: .Plain, target: self, action: "gotoHome")
        var resetBtn = UIBarButtonItem(image: UIImage(named: "refresh.png"), style: .Plain, target: self, action: "reset")

        // create a spacer
        var spaceBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        spaceBtn.width = 10;
        
        var buttons: [UIBarButtonItem] = [homeBtn,spaceBtn,resetBtn];
    
        self.navigationItem.rightBarButtonItems = buttons;

 
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //function to display an alert
    func alert(name: String!){
        //if this is out, then increment number of out
        if (name == "Out!"){
            outs = outs + 1
            NSUserDefaults.standardUserDefaults().setInteger(outs, forKey: "outs")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
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
    func displayCount(){
        Strike.text = String(strike)
        Ball.text = String(ball)
        OutLbl.text = String(outs)
    }
    
    //function to reset counts
    func reset(){
        strike = 0
        ball = 0
        displayCount()
    }
    func gotoHome(){
        
        self.performSegueWithIdentifier("showAbout", sender: self)

    }
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

