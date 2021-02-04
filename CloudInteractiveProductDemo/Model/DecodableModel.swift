//
//  DecodableModel.swift
//  CloudInteractiveProductDemo
//
//  Created by Alvin on 2021/2/2.
//

import Foundation


struct DecodableModel: Codable {
    
    let albumId: Int
    let id: Int
    let title: String
    let url: String?
    let thumbnailUrl: URL

}

extension DecodableModel {
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        albumId = try container.decode(Int.self, forKey: .albumId)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        thumbnailUrl = try container.decode(URL.self, forKey: .thumbnailUrl)
    }
}


enum CodingKeys: String, CodingKey {
    
    case albumId
    case id
    case title
    case url
    case thumbnailUrl
}



