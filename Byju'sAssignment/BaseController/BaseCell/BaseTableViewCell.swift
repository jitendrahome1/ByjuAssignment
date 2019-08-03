//
//  BaseTableViewCell.swift
//  Byju'sAssignment
//
//  Created by Jitendra Kumar Agarwal on 26/07/19.
//  Copyright © 2019 Jitendra Kumar Agarwal. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
  var datasource : AnyObject?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
