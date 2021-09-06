//
//  UIImage+Extension.swift
//  NewsAppAssignment
//
//  Created by M1066900 on 27/08/21.
//

import UIKit
import Alamofire

extension UIImageView{
    
//MARK:- Loading the image using Alamofire
    func loadImageAF(url:String){
        AF.request( url ,method: .get).response{ response in

           switch response.result {
            case .success(let responseData):
                self.image = UIImage(data: responseData!, scale:1)

            case .failure(let error):
                print("error--->",error)
            }
        }
    }
    
//MARK:-loading the image in the cell using URLSession
    func loadImage(url:URL) -> URLSessionDownloadTask {
        print("Image server url \(url)")
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: url){ localurl, _, error in
        if error == nil, let localurl = localurl, let data = try? Data(contentsOf: localurl), let image = UIImage(data: data){
            DispatchQueue.main.async {
                self.image = image
            }
        }
        }
        downloadTask.resume()
        return downloadTask
    }
    
    
//MARK:-downloading the image and storing them in cache
    func downloadImage(from urlString:String){
        let cacheKey = NSString(string: urlString)

        if let image = ServiceRequest.shared.cache.object(forKey: cacheKey){
            self.image = image
            return
        }

        guard let url = URL(string: urlString) else{return}
        //check if it is cached or not
        let task = URLSession.shared.dataTask(with: url){ [weak self] data,resonse,error in
            guard let self = self else {return}
            if error != nil {return}
            guard let response = resonse as? HTTPURLResponse, response.statusCode == 200 else{return}
            guard let data = data else{return}
            guard let image = UIImage(data: data) else { return}
            //store the image in cache
            ServiceRequest.shared.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
