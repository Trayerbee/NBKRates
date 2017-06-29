//
//  ChartViewController.swift
//  NBKRates
//
//  Created by Betrayer Stromrage on 6/29/17.
//  Copyright © 2017 Trayerbee Development. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController, ChartViewDelegate {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var chartView: LineChartView!
    var currency:Currency!
    var manager:FeedManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currency = self.currency{
            self.title = currency.name
            self.manager.getChartDataForCurrency(currency: currency, complete: { (result) in
                self.updateChart(chartData:result)
                self.activityIndicator.stopAnimating()
                self.chartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
            })
        }
        self.chartView.delegate = self
        self.chartView.chartDescription?.text = "\(self.currency?.name ?? "Currency") rate history"
        self.chartView.chartDescription?.textColor = .blue
        self.chartView.noDataText = "No data loaded"
        
    }
    func updateChart(chartData:NSDictionary){
        var chartEntries:[ChartDataEntry] = []
        for entry in chartData.allKeys{
            let x_value = entry as! String
            let objectData = chartData.object(forKey: entry) as! NSDictionary
            let rate = objectData.object(forKey: "rate") as! String
            chartEntries.append(ChartDataEntry(x: Double(x_value)!, y: Double(rate)!))
            let data = LineChartData()
            let dataSet = LineChartDataSet(values: chartEntries, label:self.currency?.name)
            data.addDataSet(dataSet)
            self.chartView.data = data
            }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
