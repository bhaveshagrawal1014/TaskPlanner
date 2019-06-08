//
//  DatePickerViewController.swift
//  TaskPlanner
//
//  Created by Bhavesh Agrawal on 07/06/2019.
//  Copyright © 2019 Bhavesh Agrawal. All rights reserved.
//

import UIKit

class DatePickerViewController: HalfScreenViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var selectedDate: Date?
    
    @IBAction func handleGesture(_ sender: UIPanGestureRecognizer) {
        handlePanGesture(sender)
    }
    
    @IBAction func chooseTap(_ sender: Any) {
        selectedDate = datePicker.date
    }
    
    @IBAction func cancelTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if selectedDate != nil {
            datePicker.date = selectedDate!
        }
        
        datePicker.minimumDate = Date()
        
        contentView.layer.cornerRadius = 10
    }

}
