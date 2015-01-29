//
//  ViewController.swift
//  Calculator
//
//  Created by Mark Nichols on 1/26/15.
//  Copyright (c) 2015 Mark Nichols. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    // properties
    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTypingANumber = false
    var numberHasADecimal = false
    var operandStack = Array<Double>()

    // append digit touched to display
    // Handle pressing of any of the digit buttons (0-9) and the decimal button (.).
    // Allows only a single decimal per number, allows for leading decimal.
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber {
            if digit == "." {
                if numberHasADecimal {
                    return
                } else {
                    numberHasADecimal = true
                }
            }
            display.text = display.text! + digit
        } else {
            if digit == "." {
                display.text = "0."
                numberHasADecimal = true
            } else {
                display.text = digit
            }
            
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    // add number entered to the operandStack
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        numberHasADecimal = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }
    
    // computed value - property that gets and sets itself
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
            numberHasADecimal = false
        }
    }
    
    // determine math operation selected and perform it against
    // the operandStack
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        
        switch operation {
            case "×": performOperation { $0 * $1 }
            case "÷": performOperation { $1 / $0 }
            case "+": performOperation { $0 + $1 }
            case "−": performOperation { $1 - $0 }
            case "√": performOperation { sqrt($0) }
            case "sin": performOperation { sin($0) }
            case "cos": performOperation { cos($0) }
            case "π": performOperation()
            default: break
            
        }
        
    }
    
    // perform 2 operand operations
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    //override for 1 operand operations
    func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    //override for 0 operand operations. i.e., π
    func performOperation() -> Double {
        displayValue = M_PI
        enter()
        return displayValue
    }
    
    
}

