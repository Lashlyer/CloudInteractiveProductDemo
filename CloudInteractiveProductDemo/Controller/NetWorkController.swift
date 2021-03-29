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
        
        
        self.imageDownloader.download(URLRequest(url: url)) { [weak self] response  in
            guard let self = `self` else { return }
            
            switch response.result {
                
            case .success(_):
                guard let image = response.result.value else { return }
                
                self.imageCache.setObject(image, forKey: url as NSURL)
                completionHandler(image)
                
            case .failure(_):
                
                completionHandler(nil)
                print("Error")
               
            }
        }
    }
}


// api call back
//private func get(url: String, completion: @escaping (_ suceess: Bool, _ JSON: NSDictionary?) -> ()) {
//   
//   print("url:  ", url)
//
//       let manager = Alamofire.SessionManager.default
//
//       manager.session.configuration.timeoutIntervalForRequest = 40
//
//       manager.request(url).validate().responseJSON { response in
//
//           DispatchQueue.main.async {
//
//               switch response.result {
//               case .success:
//
//                   if let result = response.result.value {
//                       let JSON = result as! NSDictionary
////                            print(JSON)
//                       completion(true, JSON)
//                   }else {
//
//                       completion(false, nil)
//                   }
//
//               case .failure(let error):
//                   print("Error:  ", error)
//                   completion(false, nil)
//               }
//           }
//       }
//
//



///**
//  計算文字佔據畫面的長寬
// - Parameter text: 要計算的文字
// - Parameter font: 文字字型
// - Parameter paragraphStyle: 文字格式
// - Parameter maxSize: 文字最大尺寸限制
// - Returns: 文字佔據的尺寸
// */
//static func rectForText(text: String, font: UIFont, paragraphStyle: NSParagraphStyle, maxSize: CGSize) -> CGSize {
//
//    // text, font
//    let attrString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font:font])
//    // paragraph style
//    attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, text.utf16.count))
//    // maxSize
//    let rect = attrString.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
//
//    let size = CGSize(width: rect.size.width, height: rect.size.height)
//
//    return size
//
//}
