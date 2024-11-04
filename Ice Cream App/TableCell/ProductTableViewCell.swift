//
//  ProductTableViewCell.swift
//  Ice Cream App
//
//  Created by Muhamad Septian Nugraha on 03/11/24.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var nameProduct: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
