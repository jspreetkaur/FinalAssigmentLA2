//
//  ItemCell.swift
//  A2_FA_iOS_Jaspreet_C0812273
//
//  Created by Jaspreet Kaur on 25/05/21.
//

import UIKit

class ItemCell: UITableViewCell {
    

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var providerName: UILabel!

    @IBOutlet weak var providerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        providerView.layer.cornerRadius = 5
        providerView.layer.borderWidth = 0.7
        providerView.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
