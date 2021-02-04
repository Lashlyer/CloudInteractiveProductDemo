//
//  DetailViewModel.swift
//  CloudInteractiveProductDemo
//
//  Created by Alvin on 2021/2/2.
//

import Foundation


class DetaiViewModel {
    
    var productData: [DecodableModel] = []
    
    var onRequestEnd: (() -> Void)?
    
    func prepareRequest() {
        
        guard let downloadUrl = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
                
        let task = URLSession.shared.dataTask(with: downloadUrl) { [weak self] (data, response, error) in
            guard let self = `self` else { return }
            
            DispatchQueue.main.async {
                
                guard error == nil, let datas = data else {
                    print(error as Any)
                    return
                }
                
                do {
                    
                    let classer = try JSONDecoder().decode([DecodableModel].self, from: datas)
                    
                    self.productData = classer
                    self.onRequestEnd?()
                    
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
