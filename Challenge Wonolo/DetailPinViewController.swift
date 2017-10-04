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
    var captionDetails = ""
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
        if UIDevice.current.orientation.isLandscape{
            imageCaption.contentMode = UIViewContentMode.scaleAspectFit
        }
        if UIDevice.current.orientation.isPortrait{
            imageCaption.contentMode = UIViewContentMode.scaleToFill
        }
    }
    
    func setDataForDetailsViewController(){
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.clipsToBounds = true
        userImage.downLoadFromUrlDemoSimple(urlSimple: urlImageUserDetails)
        userName.text = "User: " + userNameDetails
        fullName.text = "Name: " + userNameDetails
        userId.text = "Id: " + userIdDetails
        imageCaption.downLoadFromUrlDemoSimple(urlSimple: urlImageCaptionetails)
        caption.text = "Caption: " + captionDetails
        nameLocation.text = nameLocationDetails
        if UIDevice.current.orientation.isLandscape{
            imageCaption.contentMode = UIViewContentMode.scaleAspectFit
        }
        if UIDevice.current.orientation.isPortrait{
            imageCaption.contentMode = UIViewContentMode.scaleToFill
        }
    }
//    if UIDevice.current.orientation.isLandscape{
//    self.imageUrl.image = UIImage(imageUrl.downLoadFromUrlDemoSimple(urlSimple: urlForGetData))
//    imageUrl.contentMode = UIViewContentMode.scaleAspectFit
//    }
//    if UIDevice.current.orientation.isPortrait{
//    self.imageUrl.image = UIImage(imageUrl.downLoadFromUrlDemoSimple(urlSimple: urlForGetData))
//    imageUrl.contentMode = UIViewContentMode.scaleToFill
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
