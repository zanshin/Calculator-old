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

    // append digit touched to display
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
}

