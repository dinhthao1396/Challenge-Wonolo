//
//  DetailPinViewController.swift
//  Challenge Wonolo
//
//  Created by Tran Dinh Thao on 10/1/17.
//  Copyright © 2017 Tran Dinh Thao. All rights reserved.
//

import UIKit

class DetailPinViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var imageCaption: UIImageView!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var nameLocation: UILabel!
    var urlImageUserDetails = ""
    var userNameDetails = ""
    var fullNameDetails = ""
    var userIdDetails = ""
    var urlImageCaptionetails = ""
    var captionDetails: String?
    var nameLocationDetails = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setDataForDetailsViewController()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            imageCaption.contentMode = UIViewContentMode.scaleAspectFit
        }
        if UIDevice.current.orientation.isPortrait {
            imageCaption.contentMode = UIViewContentMode.scaleAspectFit
        }
    }
    
    func setDataForDetailsViewController() {
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.clipsToBounds = true
        userName.text = "User: " + userNameDetails
        fullName.text = "Name: " + userNameDetails
        userId.text = "Id: " + userIdDetails
        checkInternet(flag: false) { (isConnectInterner) in
            if isConnectInterner {
                self.imageCaption.downLoadFromUrlDemoSimple(urlSimple: self.urlImageCaptionetails)
                self.userImage.downLoadFromUrlDemoSimple(urlSimple: self.urlImageUserDetails)
            } else {
                self.showAlertWarning(title: "No Internet", content: "Please check your connection and\n Try again")
            }
        }
        caption.text = captionDetails!
        nameLocation.text = nameLocationDetails
        if UIDevice.current.orientation.isLandscape {
            imageCaption.contentMode = UIViewContentMode.scaleAspectFit
        }
        if UIDevice.current.orientation.isPortrait {
            imageCaption.contentMode = UIViewContentMode.scaleAspectFit
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
