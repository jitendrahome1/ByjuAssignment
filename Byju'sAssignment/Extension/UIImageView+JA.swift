//
//  UIImageView + AlamofireImage.swift
//  Byju'sAssignment
//
//  Created by Jitendra Kumar Agarwal on 26/07/19.
//  Copyright © 2019 Jitendra Kumar Agarwal. All rights reserved.
//

import Foundation
import AlamofireImage
extension UIImageView {
    
    static var imageCache: AutoPurgingImageCache?
    static var downloader: ImageDownloader?
    
    static func configureCache(withMemoryCapacity memoryCapacity: UInt64?, andPreferredMemoryAfterPurge preferredMemory:UInt64?) {
        imageCache = AutoPurgingImageCache(memoryCapacity: memoryCapacity!, preferredMemoryUsageAfterPurge: preferredMemory!)
        downloader = ImageDownloader(configuration: ImageDownloader.defaultURLSessionConfiguration(), downloadPrioritization: .fifo, maximumActiveDownloads: 10, imageCache: imageCache)
    }
    
    func setImage(withURL url: URL, placeHolderImageNamed placeholder:String?, andImageTransition imageTransition:ImageTransition) {
        
        var placeholderImage: UIImage? {
            if let placeholderImageName = placeholder {
                return UIImage(named: placeholderImageName)!
            }
            return nil
        }
        
        self.af_imageDownloader = UIImageView.downloader!
        
        
        
        
        
        self.af_setImage(withURL: url, placeholderImage: placeholderImage, filter: nil, progress: { (progess) in }, progressQueue: DispatchQueue.main, imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: true, completion: { (image) in
            
        })
        
        
        
        
        
        
    }
    
    func setImage(withURL url: URL, placeHolderImageNamed placeholder:String?) {
        // self.setImage(withURL: url, placeHolderImageNamed: placeholder, andImageTransition: .none)
        self.setImage(withURL: url, placeHolderImageNamed: String(describing: placeholder), andImageTransition:.noTransition)
    }
    
}
