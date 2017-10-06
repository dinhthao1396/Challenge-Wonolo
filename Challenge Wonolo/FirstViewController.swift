//
//  ViewController.swift
//  Challenge Wonolo
//
//  Created by Tran Dinh Thao on 9/30/17.
//  Copyright © 2017 Tran Dinh Thao. All rights reserved.
// sssssassad

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        performSegue(withIdentifier: "userView", sender: self)
    }


}

