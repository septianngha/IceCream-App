//
//  TransactionsTableViewCell.swift
//  Ice Cream App
//
//  Created by Muhamad Septian Nugraha on 03/11/24.
//

import UIKit

class TransactionsTableViewCell: UITableViewCell {

    @IBOutlet weak var pricesOfItemsLabel: UILabel!
    @IBOutlet weak var numberOfItemsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
