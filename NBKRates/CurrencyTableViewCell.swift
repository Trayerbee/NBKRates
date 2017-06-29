//
//  CurrencyTableViewCell.swift
//  NBKRates
//
//  Created by Betrayer Stromrage on 6/29/17.
//  Copyright © 2017 Trayerbee Development. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    @IBOutlet weak var arrowIndicator: UIImageView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureWith(feedItem:FeedItem){
        self.currencyLabel?.text = feedItem.feedTitle
        self.rateLabel?.text = feedItem.feedContent
        self.changeLabel?.text = feedItem.feedChange
        if let change = feedItem.feedChange{
            if let changeScale = Double(change){
                if changeScale >= 0 {
                    self.changeLabel.textColor = .green
                    self.arrowIndicator?.image  = UIImage(named: "arrow_up")
                    self.arrowIndicator?.tintColor = .green
                }
            else{
                self.changeLabel.textColor = .red
                self.arrowIndicator?.image  = UIImage(named: "arrow_down")
                self.arrowIndicator?.tintColor = .red
                }
            }
        }
    }
    func configureWith(currency:Currency){
        self.currencyLabel?.text = currency.name
        self.rateLabel?.text = currency.rate
        self.changeLabel?.text = currency.change
            if let changeScale = Double(currency.change){
                if changeScale >= 0 {
                    self.changeLabel.textColor = .green
                    self.arrowIndicator?.image  = UIImage(named: "arrow_up")
                    self.arrowIndicator?.tintColor = .green
                }
                else{
                    self.changeLabel.textColor = .red
                    self.arrowIndicator?.image  = UIImage(named: "arrow_down")
                    self.arrowIndicator?.tintColor = .red
                }
            }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
