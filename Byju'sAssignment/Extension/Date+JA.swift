//
//  Date+JA.swift
//  ByjuAssignment
//
//  Created by Jitendra Kumar Agarwal on 26/07/19.
//  Copyright © 2019 Jitendra Kumar Agarwal. All rights reserved.
//

import Foundation
//MARK: -  NSDate
extension Date {
    func getFormattedDate(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        let date = dateFormatter.date(from: format)
        dateFormatter.dateFormat = "yyyy MM dd"
        dateFormatter.timeZone = NSTimeZone.local
        let formatedDate = dateFormatter.string(from: date!)
        return formatedDate
    }
}
