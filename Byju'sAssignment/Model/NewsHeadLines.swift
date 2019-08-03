//
//  NewsHeadLines.swift
//  Byju'sAssignment
//
//  Created by Jitendra Kumar Agarwal on 25/07/19.
//  Copyright © 2019 Jitendra Kumar Agarwal. All rights reserved.
//

import Foundation
import UIKit
struct NewsHeadLines {
    
    var newsID: String?
    var name: String?
    var newsTitle: String?
    var newsDescription: String?
    var newsImage:String?
    var newsData: String?
    
    init(dict:[String:AnyObject]) {
        newsID      =   dict["source"]!["id"] as? String
        name        =   dict["source"]!["name"] as? String
        newsTitle   =   dict["title"] as? String
        newsDescription =   dict["description"] as? String
        newsImage   =   dict["urlToImage"] as? String
        newsData    =   dict["publishedAt"] as? String
    }
}
