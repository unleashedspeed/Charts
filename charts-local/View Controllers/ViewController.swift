//
//  ViewController.swift
//  charts-local
//
//  Created by Saurabh Gupta on 28/08/20.
//  Copyright © 2020 Saurabh Gupta. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var barChartSlider: UISlider!
    @IBOutlet weak var pieChartStepper: UIStepper!
    
    var imagePicker: ImagePicker!
    let chartData = ChartData()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        pieChartView.delegate = self
        barChartView.delegate = self
                
        configurePieChart()
        configureBarChart()
        configureImagePicker()
    }
    
    // MARK: UIElement configurations
    private func configurePieChart() {
        let legand = pieChartView.legend
        legand.horizontalAlignment = .right
        legand.verticalAlignment = .top
        legand.orientation = .vertical
        legand.xEntrySpace = Constants.PieChart.legandEntrySpace
        legand.yEntrySpace = Constants.zero
        legand.yOffset = Constants.zero
        
        // entry label styling
        pieChartView.entryLabelColor = .gray
        pieChartView.entryLabelFont = .systemFont(ofSize: 12, weight: .light)
        
        pieChartView.usePercentValuesEnabled = true
        
        // Initial configuration to display a filled pie chart
        pieChartStepper.value = Constants.PieChart.stepperInitialValue
        stepperValueChanged(nil)
        
        pieChartView.animate(xAxisDuration: Constants.PieChart.xAxisDuration, easingOption: .easeOutBack)
    }
    
    private func configureBarChart() {
        barChartView.chartDescription?.enabled = false
        barChartView.maxVisibleCount = Constants.BarChart.maxVisibleCount
        barChartView.pinchZoomEnabled = false
        barChartView.drawBarShadowEnabled = false
        
        let xAxis = barChartView.xAxis
        xAxis.labelPosition = .bottom
                
        barChartView.legend.enabled = false
        
        // Initial configuration to display a filled bar chart
        barChartSlider.value = Constants.BarChart.sliderIniaialValue
        sliderValueChanged(nil)
    }
    
    private func configureImagePicker() {
        imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    // MARK: PieChart Data functions
    private func updatePieChartData() {
        let data = chartData.getPieChartData(range: UInt32(Int(pieChartStepper.value)))
        
        pieChartView.data = data
        pieChartView.highlightValues(nil)
    }
    
    // MARK: BarChart Data functions
    private func updateBarChartData() {
        let data = chartData.getBarChartData(range: Double(barChartSlider.value))
            
        barChartView.data = data
        barChartView.fitBars = true
        barChartView.setNeedsDisplay()
    }

    // MARK: IBActions
    @IBAction func captureButtonTapped(_ sender: UIButton) {
        imagePicker.present(from: sender)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        // Not defined in test instructions, what to do with it.
    }
    
    @IBAction func stepperValueChanged(_ sender: Any?) {
        updatePieChartData()
    }
    
    @IBAction func sliderValueChanged(_ sender: Any?) {
        updateBarChartData()
    }
}

// MARK: ImagePickerDelegate
extension ViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        if image != nil {
            self.avatarImageView.image = image
        }
    }
}
