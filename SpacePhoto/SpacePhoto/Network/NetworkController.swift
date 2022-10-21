//
//  NetworkController.swift
//  SpacePhoto
//
//  Created by AHMET HAKAN YILDIRIM on 21.10.2022.
//

import UIKit

class NetworkController {
    // escaping : closure içinde ki kod senkron değilde asenkron çalışacağını bildirir
    func fetchPhotoInfo (completion: @escaping(PhotoInfo?) -> Void)  {
        let baseUrl = URL(string: "https://api.nasa.gov/planetary/apod")!
        let query: [String:String] = [
            "api_key":"DEMO_KEY",
            "date":"2021-04-05"
        ]
        let apiUrl = baseUrl.withQueries(query)!
        // asenkron çalışan kod bloğundan main threade bir şey dönemeyiz
        let dataTask = URLSession.shared.dataTask(with: apiUrl) { (data, _ , error) in
            let jsonDecoder = JSONDecoder()
            if let data = data, let photoInfoObject = try? jsonDecoder.decode(PhotoInfo.self, from: data) {
                // print(photoInfoObject)
               completion(photoInfoObject)
            }else {
                completion(nil)
            }
        }
        dataTask.resume()
    }
    func fetchPhoto(from url: URL, completion: @escaping (UIImage?) -> Void){
        let dataTask = URLSession.shared.dataTask(with: url) { (data , _ , _) in
            if let data = data, let image = UIImage(data: data){
                completion(image)
            }else {
                completion(nil)
            }
        }
        dataTask.resume()
    }
}
