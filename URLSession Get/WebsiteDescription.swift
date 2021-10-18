//
//  WebsiteDescription.swift
//  URLSession Get
//
//  Created by Gold_Mock on 21.09.2021.
//

import Foundation

struct WebsiteDescription: Decodable {
    
    let websiteDesription: String
    let websiteName: String
    let courses: [Course]
}
