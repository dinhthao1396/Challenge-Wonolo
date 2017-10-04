//
//  ShowUserInformationViewController.swift
//  Challenge Wonolo
//
//  Created by Tran Dinh Thao on 9/30/17.
//  Copyright © 2017 Tran Dinh Thao. All rights reserved.
//

import UIKit

class ShowUserInformationViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var follow: UILabel!
    @IBOutlet weak var followed: UILabel!
    var listFollowOrFollowed = Int()
    var isAllList = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.clipsToBounds = true
        setDataForView()
        // Do any additional setup after loading the view.
    }
    
    func setDataForView(){
        let urlString = "https://api.instagram.com/v1/users/self/?access_token=6108635271.c0befbb.2b2ccd4afb6d4f89b53499c41eacee6b"
        getUserData(url: urlString) { (listData, successData, errorData) in
            self.setDataForLabel(data: listData)
        }
    }

    func setDataForLabel(data: [ModelUser]){
        self.userName.text = "User Name: " + (data.first?.userName)!
        self.fullName.text = "Full Name: " + (data.first?.fullName)!
        self.userID.text = "User ID: " + (data.first?.id)!
        self.follow.text = "Follow: " + (data.first?.follows)!
        self.followed.text = "Followed: " + (data.first?.followed)!
        self.userImage.image = UIImage(userImage.downLoadFromUrlDemoSimple(urlSimple: (data.first?.urlImage)!))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func listFollowAndFollowedAction(_ sender: UIButton) {
        listFollowOrFollowed = 1
        performSegue(withIdentifier: "listFollowAndListFollowed", sender: self)
    }
    
    @IBAction func listFollowedAction(_ sender: UIButton) {
        listFollowOrFollowed = 2
        performSegue(withIdentifier: "listFollowAndListFollowed", sender: self)
    }
    
    @IBAction func showAllListAction(_ sender: UIButton) {
        isAllList = 1
        performSegue(withIdentifier: "connectToMapView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "listFollowAndListFollowed"){
            let desViewController = segue.destination as! ListFollowAndFollowedViewController
            desViewController.listFollowOrFollowed = self.listFollowOrFollowed
        }
        if (segue.identifier == "connectToMapView"){
            let desViewController = segue.destination as! MapViewController
            desViewController.isAllList = self.isAllList
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
