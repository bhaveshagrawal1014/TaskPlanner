//
//  NotificationRepeatType.swift
//  TaskPlanner
//
//  Created by Bhavesh Agrawal on 07/06/2019.
//  Copyright © 2019 Bhavesh Agrawal. All rights reserved.
//

import Foundation

enum NotificationType: Int {
    
    case none = -1
    case on_time = 0
    case time_5_min_before = 5
    case time_15_min_before = 15
    case time_30_min_before = 30
    case time_1_hour_before = 60
    case time_2_hour_before = 120
    case time_1_day_before = 86400
    case time_2_day_before = 172800
    case time_1_week_before = 604800
    
    static let allValues = [
        none,
        on_time,
        time_5_min_before,
        time_15_min_before,
        time_30_min_before,
        time_1_hour_before,
        time_2_hour_before,
        time_1_day_before,
        time_2_day_before,
        time_1_week_before
    ]
    
    func dateComponent() -> Calendar.Component {
        switch self {
        case .none, .on_time, .time_5_min_before, .time_15_min_before, .time_30_min_before:
            return .minute
        case .time_1_hour_before, .time_2_hour_before:
            return .hour
        case .time_1_day_before, .time_2_day_before:
            return .day
        case .time_1_week_before:
            return .day
        }
    }
    
    func dateValue() -> Int {
        switch self {
        case .none, .on_time:
            return 0
        case .time_5_min_before:
            return 5
        case .time_15_min_before:
            return 15
        case .time_30_min_before:
            return 30
        case .time_1_hour_before:
            return 1
        case .time_2_hour_before:
            return 2
        case .time_1_day_before:
            return 1
        case .time_2_day_before:
            return 2
        case .time_1_week_before:
            return 7
        }
    }
    
    func toString() -> String {
        switch self {
        case .none:
            return "Not"
        case .on_time:
            return "At the time of the event"
        case .time_5_min_before:
            return "Before 5 min"
        case .time_15_min_before:
            return "Before 15 min"
        case .time_30_min_before:
            return "Before 30 min"
        case .time_1_hour_before:
            return "Before 1 hour"
        case .time_2_hour_before:
            return "Before 2 hour"
        case .time_1_day_before:
            return "Before 1 day"
        case .time_2_day_before:
            return "Before 2 day"
        case .time_1_week_before:
            return "Before 1 week"
        }
    }
    
    func toTitleString() -> String {
        switch self {
        case .none:
            return "Not Selected"
        case .on_time:
            return "At the time of the event"
        case .time_5_min_before:
            return "After 5 min"
        case .time_15_min_before:
            return "After 15 min"
        case .time_30_min_before:
            return "After 30 min"
        case .time_1_hour_before:
            return "After 1 hour"
        case .time_2_hour_before:
            return "After 2 hour"
        case .time_1_day_before:
            return "After 1 day"
        case .time_2_day_before:
            return "After 2 day"
        case .time_1_week_before:
            return "After 1 week"
        }
    }
}
