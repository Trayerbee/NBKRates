//
//  Currency.swift
//  NBKRates
//
//  Created by Betrayer Stromrage on 6/29/17.
//  Copyright © 2017 Trayerbee Development. All rights reserved.
//

import UIKit

class Currency: NSObject {
    let name:String
    let quantity:String
    let rate:String
    let change:String
    init(feedItem:FeedItem) {
        if let name = feedItem.feedTitle{
            self.name = name
        }
        else{
            self.name = ""
        }
        if let quant = feedItem.feedQuantity{
            self.quantity = quant
        }
        else{
            self.quantity = ""
        }
        if let rate = feedItem.feedContent{
            self.rate = rate
        }
        else{
            self.rate = ""
        }
        if let change = feedItem.feedChange{
            self.change = change
        }
        else{
            self.change = ""
        }
    }
}
