//
//  FirstViewController.swift
//  NBKRates
//
//  Created by Betrayer Stromrage on 5/7/17.
//  Copyright © 2017 Trayerbee Development. All rights reserved.
//

import UIKit

class CurrenciesTable: UITableViewController, FeedManagerDelegate {
    var manager:FeedManager?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.manager = FeedManager()
        self.manager?.delegate = self
    }
    func finishedParsing() {
        self.tableView.reloadData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let manager = self.manager {
            return manager.tableData.count
        }
        return 0
     }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> CurrencyTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell") as! CurrencyTableViewCell
        guard let manager = self.manager else{
            return cell
        }
        let currency = manager.tableData[indexPath.row]
        cell.configureWith(currency: currency)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let manager = self.manager{
            let currency = manager.tableData[indexPath.row]
            self.performSegue(withIdentifier: "chart", sender: currency)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let manager = self.manager{
            let chart:ChartViewController = segue.destination as! ChartViewController
            chart.currency = sender as! Currency
            chart.manager = manager
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

