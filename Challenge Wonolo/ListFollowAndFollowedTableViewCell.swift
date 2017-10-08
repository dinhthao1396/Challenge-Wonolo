//
//  ListFollowAndFollowedTableViewCell.swift
//  Challenge Wonolo
//
//  Created by Tran Dinh Thao on 9/30/17.
//  Copyright © 2017 Tran Dinh Thao. All rights reserved.
//

import UIKit

class ListFollowAndFollowedTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkBoxButton.isSelected = false
        // Initialization code
    }
    
    @IBAction func checkBox(_ sender: UIButton) {
        if (sender.isSelected == true) {
            setCheckImage()
            tapToCheck(sender.isSelected)
            sender.isSelected = false
        } else {
            setUnCheckImage()
            tapToUnCheck(sender.isSelected)
            sender.isSelected = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setDataForCell(userName: String, fullName: String, urlImage: String, checkStateButton: ModelListFollowOrFollowed) {
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.clipsToBounds = true
        self.userName.text = userName
        self.fullName.text = fullName
        self.userImage.image = UIImage(userImage.downLoadFromUrlDemoSimple(urlSimple: urlImage))
        if checkStateButton.isCheck == true {
            setCheckImage()
            self.checkBoxButton.isSelected = false
        } else {
            setUnCheckImage()
            self.checkBoxButton.isSelected = true
        }
    }
    
    var tapToCheck = { (dataBool: Bool) -> Void in
    }
    
    var tapToUnCheck = { (dataBool: Bool) -> Void in
    }
    
    func setCheckImage() {
        self.checkBoxButton.setImage(UIImage(named: "check32"), for: UIControlState.normal)
    }
    
    func setUnCheckImage() {
        self.checkBoxButton.setImage(UIImage(named: "uncheck32"), for: UIControlState.normal)
    }
}
