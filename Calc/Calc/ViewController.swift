//
//  ViewController.swift
//  Calc
//
//  Created by David Peterson on 27/02/2015.
//  Copyright (c) 2015 David Peterson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var operandStack = Array<Double>()

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
        let op = sender.currentTitle!
        
        if userIsEnteringNumber {
            enter()
        }
        
        switch(op){
        case "*": performOperation {$1 * $0}
        case "/": performOperation {$1 / $0}
        case "+": performOperation {$1 + $0}
        case "-": performOperation {$1 - $0}
        case "√": performOperation { sqrt($0) }
        default: break
        }
    }
    
    
    @IBAction func enter() {
        userIsEnteringNumber = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
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


    private
    
    // had to move definitions to private as it seemed to collide with another
    // objective C definition of the same name elsewhere.
    
    // Closure that accepts a function with type signature (Double, Double) -> Double
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    // Closure that accepts a function with type Double -> Double
    func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
}

