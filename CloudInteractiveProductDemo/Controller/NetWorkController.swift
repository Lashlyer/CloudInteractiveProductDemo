//
//  NetWorkController.swift
//  CloudInteractiveProductDemo
//
//  Created by Alvin on 2021/2/2.
//

import Foundation
import Alamofire
import AlamofireImage
import UIKit

class NetworkController {
    
    static let shared = NetworkController()
    
    private let imageCache = NSCache<NSURL, UIImage>()
    
    fileprivate let imageDownloader = ImageDownloader(
        configuration: ImageDownloader.defaultURLSessionConfiguration(),
        downloadPrioritization: .fifo,
        maximumActiveDownloads: 4,
        imageCache: AutoPurgingImageCache()
    )
    
    func fetchImage(url: URL, completionHandler: @escaping (UIImage?) -> ()) {
        
        if let image = imageCache.object(forKey: url as NSURL) {
            completionHandler(image)
            return
        }
        
        
        self.imageDownloader.download(URLRequest(url: url)) { [weak self] response in
            guard let self = `self` else { return }
            
            guard let image = response.result.value else {
                
                completionHandler(nil)
                return
            }
            
            self.imageCache.setObject(image, forKey: url as NSURL)
            completionHandler(image)
        }
    }
}
