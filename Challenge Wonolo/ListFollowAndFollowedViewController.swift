//
//  ListFollowAndFollowedViewController.swift
//  Challenge Wonolo
//
//  Created by Tran Dinh Thao on 9/30/17.
//  Copyright © 2017 Tran Dinh Thao. All rights reserved.
//

import UIKit

class ListFollowAndFollowedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    var listUserToShow: [ModelListFollowOrFollowed] = []
    var listUserChoiceToShow: [ModelListFollowOrFollowed] = []
    var listUserIdFromListView = [String]()
    var userId = String()
    var listFollowOrFollowed = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        getListFollowOrListFollowed()
        myTableView.delegate = self
        myTableView.dataSource = self
        let nib = UINib(nibName: "ListFollowAndFollowedTableViewCell", bundle: nil)
        myTableView.register(nib, forCellReuseIdentifier: "myCell")
        myTableView.estimatedRowHeight = 50
        myTableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var showListUserChoice: UIBarButtonItem!
    
    @IBAction func showListUserChoiceAction(_ sender: UIBarButtonItem) {
        if listUserChoiceToShow.count > 0 {
            listUserIdFromListView.removeAll()
            for value in listUserChoiceToShow {
                let data = value.id
                listUserIdFromListView.append(data)
            }
            performSegue(withIdentifier: "connectToMap", sender: self)
            
        } else {
            showAlertWarning(title: "OMG !!!", content: "You need choice something to show")
        }
    }

    func getListFollowOrListFollowed(){
        var urlString = String()
        if listFollowOrFollowed == 1 {
            urlString = "https://api.instagram.com/v1/users/self/follows?access_token=6108635271.c0befbb.2b2ccd4afb6d4f89b53499c41eacee6b"
        }else {
            urlString = "https://api.instagram.com/v1/users/self/followed-by?access_token=6108635271.c0befbb.2b2ccd4afb6d4f89b53499c41eacee6b"
        }
        getListFollowAndFollowed(url: urlString) { (listData, successData , errorData) in
            print("In o List Ne")
            for value in listData! {
                let tempData = ModelListFollowOrFollowed(JSON: value, isCheck: false)
                self.listUserToShow.append(tempData!)
            }
            self.myTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listUserToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! ListFollowAndFollowedTableViewCell
        let myData = listUserToShow[indexPath.row]
        cell.setDataForCell(userName: "Name: " + myData.userName, fullName: "Full Name: " + myData.fullName, urlImage: myData.urlImage, checkStateButton: myData)
        
        cell.testToCheck = { data in
            myData.manageStateCheck = true
            let dataInCell = self.listUserToShow[indexPath.row]
            if self.listUserChoiceToShow.contains(dataInCell) {
                print("We just add this element")
            }else{
                self.listUserChoiceToShow.append(dataInCell)
                print("User Check \(dataInCell.userName)")
            }
        }
        
        cell.testToUnCheck = { data in
            myData.manageStateCheck = false
            let dataInCell = self.listUserToShow[indexPath.row]
            var sum = 0
            if self.listUserChoiceToShow.contains(dataInCell) {
                for i in 0..<self.listUserChoiceToShow.count {
                    if dataInCell == self.listUserChoiceToShow[i] {
                        sum = sum + i
                    }
                }
                self.listUserChoiceToShow.remove(at: sum)
                print("User UnCheck \(dataInCell.userName)")
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "connectToMap"){
            let desViewController = segue.destination as! MapViewController
            desViewController.listUserIdFromListView = self.listUserIdFromListView
        }
    }
    
    func showAlertWarning(title: String, content: String) {
        let alert = UIAlertController(title: title, message: content , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
            print("User Click Ok To Choice Again")
        }))
        self.present(alert, animated:  true, completion: nil)
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
