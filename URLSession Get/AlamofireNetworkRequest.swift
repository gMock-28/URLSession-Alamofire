//
//  AlamofireNetworkRequest.swift
//  URLSession Get
//
//  Created by Gold_Mock on 06.10.2021.
//

import Foundation
import Alamofire
import UIKit

class AlamofireNetworkRequest {
    
    static var onProgress: ((Double) -> ())?
    static var completed: ((String) -> ())?
    
    static func sendRequest(url: String, completion: @escaping (_ courses: [Course])->()) {
        
        guard let url = URL(string: url) else { return }
        
        AF.request(url).validate().responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                
                var courses = [Course]()
                courses = Course.getArray(from: value)!
                
                completion(courses)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func downloadImage(url: String, completion: @escaping (_ image: UIImage)->()) {
        guard let url = URL(string: url) else { return }
        
        AF.request(url).responseData { (response) in
            
            switch response.result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                completion(image)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func requestData(url: String) {
        AF.request(url).responseData { (responseData) in
            switch responseData.result {
            case .success(let data):
                guard let string = String(data: data, encoding: .utf8) else { return }
                print(string)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    static func requestString(url: String) {
        AF.request(url).responseString { (response) in
            switch response.result {
            case .success(let string):
                print(string)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    static func request(url: String) {
        AF.request(url).response { (response) in
            guard
                let data = response.data,
                let string = String(data: data, encoding: .utf8)
                else { return }
            
            print(string)
            
        }
    }
    
    static func downloadImageWithProgress(url: String, completion: @escaping (_ image: UIImage)->()) {
        guard let url = URL(string: url) else { return }

        AF.request(url).validate().downloadProgress { (progress) in
            print("totalUnitCount: \(progress.totalUnitCount)")
            print("completedUnitCount: \(progress.completedUnitCount)")
            print("fractionCompleted: \(progress.fractionCompleted)")
            print("localizedDescription: \(progress.localizedDescription as Any)")
            print("localizedAdditionalDDescription: \(progress.localizedAdditionalDescription as Any)")
            print("-----------------------------------------------------------------------")
            
            self.onProgress?(progress.fractionCompleted)
            self.completed?(progress.localizedDescription)
        }.response { (response) in
            guard let data = response.data, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
