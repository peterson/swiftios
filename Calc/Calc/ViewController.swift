//
//  ViewController.swift
//  Calc
//
//  Created by David Peterson on 27/02/2015.
//  Copyright (c) 2015 David Peterson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var engine = CalcEngine()

    var userIsEnteringNumber = false
    
    @IBOutlet weak var display: UILabel!

    // computed property for value of display
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
        }
    }

    
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
    
    
    @IBAction func op(sender: UIButton) {
        if userIsEnteringNumber {
            enter()
        }
        if let op = sender.currentTitle {
            if let result = engine.performOperation(op) {
                displayValue = result
            }
            else {
                displayValue = 0 // hacky .. see below
            }
        }
    }
    
    
    @IBAction func enter() {
        userIsEnteringNumber = false
        if let result = engine.pushOperand(displayValue) {
            displayValue = result
        }
        else {
            displayValue = 0 // a bit hacky .. display value should accept an optional. Allow display of an err message.
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

