//
//  ViewController.swift
//  customView
//
//  Created by Daniel on 4/25/17.
//  Copyright © 2017 DanielFR. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var pieChartView: CustomView!
    
    @IBOutlet weak var txtValor: UITextField!
    
    @IBAction func updatePieChart(sender: AnyObject) {
        
        if let val = Double(txtValor.text!) {
            pieChartView.piePercentage = Double(val)
        }
        else {
            showAlert()
        }
        
    }
    
    @IBAction func resetPieChart(sender: AnyObject) {
        
        pieChartView.piePercentage = 0
    }
    
    private func showAlert() {
    
        let alert = UIAlertController(title: "Ooops", message: "Digite um valor", preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(OKAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }

    
}

