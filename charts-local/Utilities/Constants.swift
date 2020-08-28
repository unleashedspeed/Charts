//
//  Constants.swift
//  charts-local
//
//  Created by Saurabh Gupta on 28/08/20.
//  Copyright © 2020 Saurabh Gupta. All rights reserved.
//

import Foundation
import UIKit

// Single-responsibility principle (takes responsibility of all the constants use across the app. Also encapsulates global constants.)
struct Constants {
    
    static let zero: CGFloat = 0

    struct PieChart {
        static let legandEntrySpace: CGFloat = 7
        static let stepperInitialValue: Double = 25
        static let xAxisDuration: TimeInterval = 1.4
        static let sliceSpace: CGFloat = 2
    }
    
    struct BarChart {
        static let maxVisibleCount = 60
        static let sliderIniaialValue: Float = 100
        static let barCounts: Int = 10
    }
}
