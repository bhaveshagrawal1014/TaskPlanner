//
//  DateHelper.swift
//  TaskPlanner
//
//  Created by Bhavesh Agrawal on 07/06/2019.
//  Copyright © 2019 Bhavesh Agrawal. All rights reserved.
//

import Foundation

class ShortDateFormat {
    
    static var formatter: DateFormatter?
    
    static func formatDate(_ date: Date) -> String {
        if formatter == nil {
            formatter = DateFormatter()
            formatter!.locale = Locale(identifier: "en_US")
            formatter!.dateStyle = .medium
            formatter!.timeStyle = .short
        }
        return formatter!.string(from: date)
    }
    
}
