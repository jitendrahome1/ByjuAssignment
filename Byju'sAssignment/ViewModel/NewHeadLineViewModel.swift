//
//  NewHeadLineViewModel.swift
//  Byju'sAssignment
//
//  Created by Jitendra Kumar Agarwal on 26/07/19.
//  Copyright © 2019 Jitendra Kumar Agarwal. All rights reserved.
//

import Foundation
protocol NewsHeadLineListDelegate {
    func updateUI()
}
class NewHeadLineViewModel {
    fileprivate var arrNewsHeadLine =  [NewsHeadLines]()
    var delegate: NewsHeadLineListDelegate?
    
    init() {
        self.getNewsHeadLinesApiCall()
    }
}
   
// API WORK.
extension NewHeadLineViewModel {
    
    fileprivate func getNewsHeadLinesApiCall() {
        APIHandler.handler.getUserProfileList({ (response) in
            guard let arrObjet =  response!["articles"] as? [AnyObject] else {
                return
            }
            
            if arrObjet.count > 0  {
                self.arrNewsHeadLine.removeAll()
                for dict in arrObjet {
                   let model =  NewsHeadLines(dict: dict as! [String: AnyObject])
                    self.arrNewsHeadLine.append(model)
                }
            }
            else{
               // arrObjet count zero.
            }
            self.delegate?.updateUI()
       
       
        }, failure: { (error) in
            // failure case.
        })
    }
}

// USER FUNCTION
extension NewHeadLineViewModel {
    
    var numberOfRowInSection: Int {
        get {
            return self.arrNewsHeadLine.count
        }
    }
    var getNewsHeadLine: [NewsHeadLines] {
        get {
            return self.arrNewsHeadLine
        }
    }
    
    
}
