//
//  FirstViewController.swift
//  NBKRates
//
//  Created by Betrayer Stromrage on 5/7/17.
//  Copyright © 2017 Trayerbee Development. All rights reserved.
//

import UIKit

class CurrenciesTable: UITableViewController, FeedParserDelegate {
    var parser:FeedParser?
    var tableData:Array<FeedItem> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.parser = FeedParser(feedURL:"http://www.nationalbank.kz/rss/rates_all.xml")
        self.parser?.delegate = self
        self.parser?.parse()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func feedParser(_ parser: FeedParser, didParseItem item: FeedItem) {
        self.tableData.append(item)
        self.tableView.reloadData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
     }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> CurrencyTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell") as! CurrencyTableViewCell
        let currency = self.tableData[indexPath.row]
        cell.configureWith(feedItem: currency)
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

