//
//  ViewController.swift
//  TipPro
//
//  Created by YK on 6/22/16.
//  Copyright © 2016 Yevgeniy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var billAmountField: UITextField!
    @IBOutlet weak var tipSelector: UISegmentedControl!
    @IBOutlet weak var tipAmountField: UITextField!
    @IBOutlet weak var totalAmountField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        billAmountField.delegate = self
    }

    @IBAction func calculateTip(sender: AnyObject) {
        
        let textFromTextField = billAmountField.text!
        print("text: \(textFromTextField)")
        
        guard let billAmount = Double(textFromTextField) else {
            print("error: could not convert the input (\(textFromTextField)) to a double")
            print("reset text in text fields and quit function")
            
            billAmountField.text = ""
            tipAmountField.text = ""
            totalAmountField.text = ""
            
            return // quits the function
        }
        
        // the following code only runs when the guard condition is met!
        
        var tipPercentage = 0.0
        
        switch tipSelector.selectedSegmentIndex {
        case 0:
            tipPercentage = 0.15
        case 1:
            tipPercentage = 0.18
        case 2:
            tipPercentage = 0.20
        default:
            break
        }
        
        let roundedBillAmount = round(100*billAmount)/100
        let tipAmount = roundedBillAmount * tipPercentage
        let roundedTipAmount = round(100*tipAmount)/100
        let totalAmount = roundedBillAmount + roundedTipAmount
        
        if (!billAmountField.editing) {
            billAmountField.text = String(format: "%.2f", roundedBillAmount)
        }
        tipAmountField.text = String(format: "%.2f", roundedTipAmount)
        totalAmountField.text = String(format: "%.2f", totalAmount)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
