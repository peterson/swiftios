//
//  ViewController.swift
//  Calc
//
//  Created by David Peterson on 27/02/2015.
//  Copyright (c) 2015 David Peterson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var userIsEnteringNumber = false
    
    @IBOutlet weak var display: UILabel!

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsEnteringNumber {
            display.text = display.text! + digit
        }
        else {
            userIsEnteringNumber = true
            display.text = digit
        }
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }


}

