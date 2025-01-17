//
//  NotificationPickerViewController.swift
//  TaskPlanner
//
//  Created by Bhavesh Agrawal on 07/06/2019.
//  Copyright © 2019 Bhavesh Agrawal. All rights reserved.
//

import Foundation
import UIKit

class NotificationPickerViewController: HalfScreenViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var selectedNotificationRepeatType: NotificationType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        if let type = selectedNotificationRepeatType {
            if let index = NotificationType.allValues.index(of: type) {
                pickerView.selectRow(index, inComponent: 0, animated: false)
            }
        }
        
        contentView.layer.cornerRadius = 10
    }
    
    @IBAction func cancelTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func chooseTap(_ sender: Any) {
        let selectedIndex = pickerView.selectedRow(inComponent: 0)
        let enumValue = NotificationType.allValues[selectedIndex]
        selectedNotificationRepeatType = enumValue
    }
    
    @IBAction func handleGesture(_ sender: UIPanGestureRecognizer) {
        handlePanGesture(sender)
    }
}

extension NotificationPickerViewController: UIPickerViewDelegate  {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return NotificationType.allValues[row].toString()
    }
    
}

extension NotificationPickerViewController: UIPickerViewDataSource  {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return NotificationType.allValues.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

