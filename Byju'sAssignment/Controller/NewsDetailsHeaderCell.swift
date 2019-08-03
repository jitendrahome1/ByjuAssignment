//
//  NewsDetailsHeaderCell.swift
//  ByjuAssignment
//
//  Created by Jitendra Kumar Agarwal on 02/08/19.
//  Copyright © 2019 Jitendra Kumar Agarwal. All rights reserved.
//

import UIKit

class NewsDetailsHeaderCell: BaseTableViewCell {
    
    @IBOutlet weak var labelHeader: UILabel!
    @IBOutlet weak var imgNewsImage: UIImageView!
    @IBOutlet weak var labelNewsDate: UILabel!
    @IBOutlet weak var labelNewsID: UILabel!
    @IBOutlet weak var labelNewDetails: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override var datasource: AnyObject? {
        didSet {
            
            guard datasource != nil else {
                return
            }
            let data =  datasource as! NewsHeadLines
            self.labelHeader.text =  (String.isSafeString(data.newsTitle as AnyObject?)) ? data.newsTitle : ""
            self.labelNewDetails.text =  (String.isSafeString(data.newsDescription as AnyObject?)) ? data.newsDescription : ""
            self.labelNewsID.text =  (String.isSafeString(data.name as AnyObject?)) ? data.name : ""
            self.labelNewsDate.text =  (String.isSafeString(data.newsData as AnyObject?)) ? Date().getFormattedDate(data.newsData!) : ""
            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                
                if data.newsImage != nil {
                    DispatchQueue.main.async{
                        if let imageUrl = data.newsImage {
                            self.imgNewsImage.setImage(withURL: URL(string: imageUrl)!, placeHolderImageNamed: "news-default", andImageTransition: .noTransition)
                        }
                        else {
                            self.imgNewsImage.image = #imageLiteral(resourceName: "news-default.jpeg")
                        }
                    }
                }
            }
            
        }
    }
}
