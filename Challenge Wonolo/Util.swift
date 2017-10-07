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

extension UIViewController {
    func getUserData(url: String, completion: @escaping (_ data: [String: Any]?, String, String) -> Void) {
        Alamofire.request(url)
        .validate()
        .responseJSON{ response in
            if response.result.isSuccess {
                print("JSON Link Available")
            } else {
                print("Error: \(String(describing: response.result.error))")
                let isErrorGetData = String(describing: response.result.error!)
                let isSuccessGetData = "NOT SUCCESS"
                completion(nil, isSuccessGetData, isErrorGetData)
                return
            }
            guard let jsonData = response.result.value as? [String: Any] else {
                let isErrorGetData = String(describing: response.result.error!)
                let isSuccessGetData = "NOT SUCCESS"
                completion(nil, isSuccessGetData, isErrorGetData)
                return
            }
            let isErrorGetData = "NO ERROR"
            let isSuccessGetData = "SUCCES"
            completion(jsonData, isSuccessGetData, isErrorGetData)
            self.view.reloadInputViews()
        }
    }
    
    func getListFollowAndFollowed(url: String, completion: @escaping (_ data: [[String: Any]]?, String, String) -> Void) {
        Alamofire.request(url)
        .validate()
        .responseJSON{ response in
            if response.result.isSuccess {
                print("JSON Link Available")
            } else {
                print("Error: \(String(describing: response.result.error))")
                let isErrorGetData = "ERROR"
                let isSuccessGetData = "NOT SUCCESS"
                completion(nil, isSuccessGetData, isErrorGetData)
                return
            }
            guard let jsonData = response.result.value as? [String: Any],
                let results = jsonData["data"] as? [[String: Any]] else {
                    let errorGetData = "ERROR"
                    let successGetData = "NOT SUCCESS"
                    completion(nil, successGetData, errorGetData)
                    return
            }
            let errorGetData = "NO ERROR"
            let successGetData = "SUCCESS"
            completion(results, successGetData, errorGetData)
            self.view.reloadInputViews()
        }
    }
    
    func getListUserLocation(url: String, completion: @escaping (_ data: [[String: Any]]?, String, String) -> Void) {
        Alamofire.request(url)
        .validate()
        .responseJSON{ response in
            if response.result.isSuccess {
                print("JSON Link Available")
            } else {
                print("Error: \(String(describing: response.result.error))")
                let isErrorGetData = "EROOR"
                let isSuccessGetData = "NOT SUCCESS"
                completion(nil, isSuccessGetData, isErrorGetData)
                return
            }
            guard let jsonData = response.result.value as? [String: Any],
                let results = jsonData["data"] as? [[String: Any]] else {
                    let errorGetData = "EROOR"
                    let successGetData = "NOT SUCCESS"
                    completion(nil, successGetData, errorGetData)
                    return
            }
            let errorGetData = "NO ERROR"
            let successGetData = "SUCCESS"
            completion(results, successGetData, errorGetData)
            self.view.reloadInputViews()
        }
    }
}

