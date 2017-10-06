//
//  Util.swift
//  Challenge Wonolo
//
//  Created by Tran Dinh Thao on 9/30/17.
//  Copyright © 2017 Tran Dinh Thao. All rights reserved.
//

import UIKit
import Alamofire
class Util: NSObject {

}

extension UIImageView {
    func downLoadFromUrlDemoSimple(urlSimple: String) {
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: URL(string: urlSimple )!)
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
    }
}

extension UIViewController{
    func getUserData(url: String, completion: @escaping ([ModelUser], String,String) -> Void) {
        Alamofire.request(url)
        .validate()
        .responseJSON{ response in
            if response.result.isSuccess {
                print("JSON Link Available")
            } else {
                print("Error: \(String(describing: response.result.error))")
                let isErrorGetData = String(describing: response.result.error!)
                let isSuccessGetData = "NOT SUCCESS"
                completion([ModelUser](), isSuccessGetData, isErrorGetData)
                return
            }
            guard let jsonData = response.result.value as? [String: Any],
                let results = jsonData["data"] as? [String: Any] else {
                let isErrorGetData = String(describing: response.result.error!)
                let isSuccessGetData = "NOT SUCCESS"
                completion([ModelUser](), isSuccessGetData, isErrorGetData)
                return
            }
            guard let userName = results["username"] as? String ,
                let userID = results["id"] as? String,
                let fullName = results["full_name"] as? String ,
                let urlImage = results["profile_picture"] as? String ,
                let counts = results["counts"] as? [String: Float],
                let follows = counts["follows"],
                let followed = counts["followed_by"] else {return}
                let isErrorGetData = "NO ERROR"
                let isSuccessGetData = "SUCCES"
                completion([ModelUser(userName: userName, fullName: fullName, follows: Int(follows), followed: Int(followed), urlImage: urlImage, id: userID, isCheck: false)], isSuccessGetData, isErrorGetData)
                self.view.reloadInputViews()
        }
        
    }
    
    func getListFollowAndFollowed(url: String, completion: @escaping ([ModelUser], String,String) -> Void) {
        Alamofire.request(url)
        .validate()
        .responseJSON{ response in
            if response.result.isSuccess {
                print("JSON Link Available")
            } else {
                    print("Error: \(String(describing: response.result.error))")
                    let isErrorGetData = String(describing: response.result.error!)
                    let isSuccessGetData = "NOT SUCCESS"
                    completion([ModelUser](), isSuccessGetData, isErrorGetData)
                    return
                }
            guard let jsonData = response.result.value as? [String: Any],
                let results = jsonData["data"] as? [[String: Any]] else {
                    let errorGetData = String(describing: response.result.error!)
                    let successGetData = "NOT SUCCESS"
                    completion([ModelUser](), successGetData, errorGetData)
                    return
            }
            let list = results.flatMap({ (dict) -> ModelUser? in
                guard let userName = dict["username"] as? String ,
                    let fullName = dict["full_name"] as? String ,
                    let urlImage = dict["profile_picture"] as? String ,
                    let userId = dict["id"] as? String else { return nil }
                return ModelUser(userName: userName, fullName: fullName , follows: 0 , followed: 0, urlImage: urlImage, id: userId, isCheck: false)
            })
            let errorGetData = "NO ERROR"
            let successGetData = "SUCCESS"
            completion(list, successGetData, errorGetData)
            self.view.reloadInputViews()
        }
    }
    
    func getListUserLocation(url: String, completion: @escaping ([ModelUserPostPin], String,String) -> Void) {
        Alamofire.request(url)
        .validate()
        .responseJSON{ response in
            if response.result.isSuccess {
                print("JSON Link Available")
            } else {
                print("Error: \(String(describing: response.result.error))")
                let isErrorGetData = String(describing: response.result.error!)
                let isSuccessGetData = "NOT SUCCESS"
                completion([ModelUserPostPin](), isSuccessGetData, isErrorGetData)
                return
            }
            guard let jsonData = response.result.value as? [String: Any],
                let results = jsonData["data"] as? [[String: Any]] else {
                    let errorGetData = String(describing: response.result.error!)
                    let successGetData = "NOT SUCCESS"
                    completion([ModelUserPostPin](), successGetData, errorGetData)
                    return
            }
            let list = results.flatMap({ (dict) -> ModelUserPostPin? in
                guard let user = dict["user"] as? [String: Any] ,
                    let fullName = user["full_name"] as? String ,
                    let urlImageUser = user["profile_picture"] as? String ,
                    let userName = user["username"] as? String ,
                    let userId = user["id"] as? String ,
                    let images = dict["images"] as? [String: Any],
                    let low = images["low_resolution"] as? [String: Any],
                    let urlImage = low["url"] as? String,
                    let caption = dict["caption"] as? [String: Any],
                    let text = caption["text"] as? String,
                    let location = dict["location"] as? [String: Any],
                    let lat = location["latitude"] as? Float,
                    let lng = location["longitude"] as? Float,
                    let nameLocation = location["name"] as? String,
                    let idLocation = location["id"] as? Float else { return nil }
                return ModelUserPostPin(userName: userName, fullName: fullName, urlImageCaption: urlImage, text: text, lat: lat, lng: lng, urlImageUser: urlImageUser, userId: userId, nameLocation: nameLocation, locationId: String(idLocation))
            })
            let errorGetData = "NO ERROR"
            let successGetData = "SUCCESS"
            completion(list, successGetData, errorGetData)
            self.view.reloadInputViews()
        }
    }
}

