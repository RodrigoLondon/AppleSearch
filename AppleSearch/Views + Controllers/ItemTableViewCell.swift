//
//  ItemTableViewCell.swift
//  AppleSearch
//
//  Created by Lewis Jones on 08/11/2018.
//  Copyright © 2018 Rodrigo. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemTitleLable: UILabel!
    @IBOutlet weak var itemSubtitleLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    var item: AppStoreItem? {
        //update the cell
        didSet {
            guard let item = item else { return }
            
            itemTitleLable.text = item.title
            itemSubtitleLabel.text = item.subtitle
            itemImageView.image = nil
           
            AppStoreItemController.getImageFor(item: item) { (image) in
                if let image = image {
                    DispatchQueue.main.async {
                        self.itemImageView.image = image
                    }
                } else {
                    print("Image was nil!")
                }
            }
        }
    }
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
