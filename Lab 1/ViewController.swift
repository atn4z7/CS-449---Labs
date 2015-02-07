//
//  ViewController.swift
//  Lab 1
//
//  Created by ninja on 1/25/15.
//  Copyright (c) 2015 ninja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var strike : Int!
    var ball : Int!
    @IBOutlet var Strike: UILabel!
    @IBOutlet var Ball: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //initialize strike and ball count
        strike = 0
        ball = 0
        Strike.text = String (strike)
        Ball.text = String(ball)
        
        
        // create home and reset buttons
        var homeBtn = UIBarButtonItem(title: "Home", style: .Plain, target: self, action: "gotoHome")
        var resetBtn = UIBarButtonItem(title: "Reset", style: .Plain, target: self, action: "reset")
    
        // create a spacer
        var spaceBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        spaceBtn.width = 20;
        
        var buttons: [UIBarButtonItem] = [homeBtn,spaceBtn,resetBtn];
    
        self.navigationItem.rightBarButtonItems = buttons;
 
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //function to display an alert
    func alert(name: String!){
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
    }
    /*
    //function to reset counts
    func reset(){
        strike = 0
        ball = 0
        displayCount()
    }*/
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

