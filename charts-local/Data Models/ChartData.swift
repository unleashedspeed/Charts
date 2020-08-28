//
//  PieChartData.swift
//  charts-local
//
//  Created by Saurabh Gupta on 28/08/20.
//  Copyright © 2020 Saurabh Gupta. All rights reserved.
//

import Foundation
import Charts

// Single-responsibility principle (takes responsibility of charts data)
struct ChartData {
    
    let parties = ["Product A", "Product B", "Product C", "Product D"]

    func getPieChartData(range: UInt32) -> PieChartData {
        let entries = (0..<parties.count).map { (i) -> PieChartDataEntry in
            // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
            return PieChartDataEntry(value: Double(arc4random_uniform(range) + range / 5),
                                     label: parties[i % parties.count],
                                     icon: #imageLiteral(resourceName: "icon"))
        }
        
        let set = PieChartDataSet(entries: entries, label: "Product Distribution")
        set.drawIconsEnabled = false
        set.sliceSpace = Constants.PieChart.sliceSpace
        
        set.colors = ChartColorTemplates.vordiplom()
            + ChartColorTemplates.joyful()
            + ChartColorTemplates.colorful()
            + ChartColorTemplates.liberty()
            + ChartColorTemplates.pastel()
            + [ChartsColor.pieChartSetColor()]
        
        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        
        data.setValueFont(.systemFont(ofSize: 11, weight: .light))
        data.setValueTextColor(.gray)
        
        return data
    }
    
    func getBarChartData(range: Double) -> BarChartData {
        let yVals = (0..<Constants.BarChart.barCounts + 1).map { (i) -> BarChartDataEntry in
            let mult = range + 1
            let val = Double(arc4random_uniform(UInt32(mult))) + mult/3
            return BarChartDataEntry(x: Double(i), y: val)
        }
        
        let barChartDataSet = BarChartDataSet(entries: yVals, label: "Data Set")
        barChartDataSet.colors = ChartColorTemplates.vordiplom()
        barChartDataSet.drawValuesEnabled = false
        
        return BarChartData(dataSet: barChartDataSet)
    }
    
}
