//
//  TaskCellCheckDelegate.swift
//  TaskPlanner
//
//  Created by Bhavesh Agrawal on 07/06/2019.
//  Copyright © 2019 Bhavesh Agrawal. All rights reserved.
//

import Foundation
import UIKit

protocol TaskCellCheckDelegate: class {
    func checkToggle(cell: UITableViewCell)
}
