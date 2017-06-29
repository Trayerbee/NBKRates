//
//  FeedManager.swift
//  NBKRates
//
//  Created by Betrayer Stromrage on 6/29/17.
//  Copyright © 2017 Trayerbee Development. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
protocol FeedManagerDelegate {
    func finishedParsing()
}
class FeedManager: NSObject, FeedParserDelegate {
    var user:User?
    var parser:FeedParser?
    var tableData:Array<Currency> = []
    var delegate:FeedManagerDelegate?
    var ref: DatabaseReference!
    override init() {
        super.init()
        self.authenticate()
        self.ref = Database.database().reference()
        self.parser = FeedParser(feedURL:"http://www.nationalbank.kz/rss/rates_all.xml")
        self.parser?.delegate = self
        self.parser?.parse()
    }
    
    func authenticate() {
        Auth.auth().signIn(withEmail: "defaultuser@gmail.com", password: "Passw0rd", completion: { (user, error) in
            if ((error) != nil){
                print("Failed to log in %@", error?.localizedDescription ?? "No error");}
            else{
                self.user = user;
            }
        });
    }
    
    func feedParser(_ parser: FeedParser, didParseItem item: FeedItem) {
        let currency = Currency(feedItem: item)
        print(item)
        if let timestamp = item.feedPubDate?.timeIntervalSince1970 {
            let dateString = String(Int(timestamp))
            let payload = ["rate":currency.rate, "quantity":currency.quantity, "change":currency.change]
            self.ref.child("\(currency.name)/\(dateString)").setValue(payload)
        }
        self.tableData.append(currency)
    }
    
    func feedParser(_ parser: FeedParser, successfullyParsedURL url: String) {
        if let delegate = self.delegate {
            delegate.finishedParsing()
        }
    }
    
    func getChartDataForCurrency(currency: Currency, complete:@escaping (NSDictionary) -> Void){
        self.ref.child(currency.name).observeSingleEvent(of: .value, with: { (snapshot) in
            if let value:NSDictionary = snapshot.value as? NSDictionary{
                complete(value)
            }
        })
    }
    
}
