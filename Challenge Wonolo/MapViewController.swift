//
//  MapViewController.swift
//  Challenge Wonolo
//
//  Created by Tran Dinh Thao on 9/30/17.
//  Copyright © 2017 Tran Dinh Thao. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire
class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
   
    
    @IBOutlet weak var myMaps: MKMapView!
    var locationManager = CLLocationManager()
    var listDataToShow = [ModelUserPostPin]()
    var listUserIdFromListView = [String]()
    var listUserIdAllList = [String]()
    var userId = String()
    var isAllList = 0
    var urlImageUserDetails = ""
    var userNameDetails = ""
    var fullNameDetails = ""
    var userIdDetails = ""
    var urlImageCaptionetails = ""
    var captionDetails = ""
    var nameLocationDetails = ""

    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = false
        super.viewDidLoad()
        myMaps.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "My Location", style: .plain, target: self, action: #selector(MapViewController.comeBackMyLocation) )
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        let latitude:CLLocationDegrees = (locationManager.location?.coordinate.latitude)!
        let longitude:CLLocationDegrees = (locationManager.location?.coordinate.longitude)!
        let latDelta:CLLocationDegrees = 0.05
        let longDelta:CLLocationDegrees = 0.05
        let span = MKCoordinateSpanMake(latDelta, longDelta)
        let location = CLLocationCoordinate2DMake(latitude, longitude)
        let region = MKCoordinateRegionMake(location, span)
        myMaps.setRegion(region, animated: false)
        checkDataToShow()
    }
    
    func comeBackMyLocation(){
        let latitude:CLLocationDegrees = (locationManager.location?.coordinate.latitude)!
        let longitude:CLLocationDegrees = (locationManager.location?.coordinate.longitude)!
        let latDelta:CLLocationDegrees = 0.05
        let lonDelta:CLLocationDegrees = 0.05
        let span = MKCoordinateSpanMake(latDelta, lonDelta)
        let location = CLLocationCoordinate2DMake(latitude, longitude)
        let region = MKCoordinateRegionMake(location, span)
        myMaps.setRegion(region, animated: false)
        myMaps.reloadInputViews()
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation{
            return nil
        }
        var annotationView = self.myMaps.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil{
            annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = false
            //annotationView?.isEnabled = true
            
        }else{
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "marker")
        return annotationView
    }
    
    func checkDataToShow(){
        if isAllList == 1{
            loadAllListOnMap()
        }else{
            loadDataLocation(listUserId: listUserIdFromListView)
        }
    }
    
    func loadAllListOnMap(){
        myMaps.showsUserLocation = true
        var arrayApi = [String]()
        let tempApiFollows = "https://api.instagram.com/v1/users/self/follows?access_token=6108635271.c0befbb.2b2ccd4afb6d4f89b53499c41eacee6b"
        arrayApi.append(tempApiFollows)
        let tempApiFollowed = "https://api.instagram.com/v1/users/self/followed-by?access_token=6108635271.c0befbb.2b2ccd4afb6d4f89b53499c41eacee6b"
        arrayApi.append(tempApiFollowed)
        for api in arrayApi {
            getListFollowAndFollowed(url: api) { (listData, successData , errorData) in
                for value in listData{
                    let tempUserId = value.id
                    self.listUserIdAllList.append(tempUserId)
                }
                self.loadDataLocation(listUserId: self.listUserIdAllList)
                self.myMaps.reloadInputViews()
                self.view.reloadInputViews()
            }
        }
    }
    
    func setDataForPin(dataArray: [ModelUserPostPin]){
        for value in dataArray {
            myMaps.delegate = self
            myMaps.showsUserLocation = true
            let annotation = MyCusTomAnnotation(coordinate: CLLocationCoordinate2D(latitude: Double(value.lat) , longitude: Double(value.lng)))
            annotation.caption = value.text
            annotation.userName = value.userName
            annotation.urlImageCaption = value.urlImageCaption
            annotation.userId = value.userId
            annotation.fullName = value.fullName
            annotation.urlImageUser = value.urlImageUser
            annotation.nameLocation = value.nameLocation
            self.myMaps.addAnnotation(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        if view.annotation is MKUserLocation{
            return
        }
        let myAnnotation = view.annotation as! MyCusTomAnnotation
        let views = Bundle.main.loadNibNamed("CustomCalloutViewController", owner: nil, options: nil)
        let calloutView = views?[0] as! CustomCalloutViewController
        calloutView.captionPin.text = myAnnotation.caption
        calloutView.userNamePin.text = myAnnotation.userName
        calloutView.userId = myAnnotation.userId
        calloutView.fullName = myAnnotation.fullName
        calloutView.urlImageUser = myAnnotation.urlImageUser
        calloutView.nameLocation = myAnnotation.nameLocation
        calloutView.urlImageCaption = myAnnotation.urlImageCaption
        let button = UIButton(frame: calloutView.frame)
        button.addTarget(self, action: #selector(MapViewController.callPhoneNumber(sender:)), for: .touchUpInside)
        calloutView.addSubview(button)
        calloutView.imagePin.downLoadFromUrlDemoSimple(urlSimple: myAnnotation.urlImageCaption)
        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
        view.addSubview(calloutView)
        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
    }
    
    func callPhoneNumber(sender: UIButton)
    {
        makeChoice(title: "More Details")
        let v = sender.superview as! CustomCalloutViewController
        urlImageUserDetails = v.urlImageUser
        urlImageCaptionetails = v.urlImageCaption
        userNameDetails = v.userNamePin.text!
        fullNameDetails = v.fullName
        userIdDetails = v.userId
        nameLocationDetails = v.nameLocation
        captionDetails = v.captionPin.text!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetails"){
            let desViewController = segue.destination as! DetailPinViewController
            desViewController.urlImageUserDetails = self.urlImageUserDetails
            desViewController.urlImageCaptionetails = self.urlImageCaptionetails
            desViewController.userNameDetails = self.userNameDetails
            desViewController.fullNameDetails = self.fullNameDetails
            desViewController.userIdDetails = self.userIdDetails
            desViewController.nameLocationDetails = self.nameLocationDetails
            desViewController.captionDetails = self.captionDetails
        }
    }
//    var urlImageUserDetails = ""
//    var userNameDetails = ""
//    var fullNameetails = ""
//    var userIdDetails = ""
//    var urlImageCaptionetails = ""
//    var captionetails = ""
    
    func loadDataLocation(listUserId: [String]) {
        for value in listUserId{
            let urlToShow = "https://api.instagram.com/v1/users/\(value)/media/recent/?access_token=6108635271.c0befbb.2b2ccd4afb6d4f89b53499c41eacee6b"
            getListUserLocation(url: urlToShow, completion: { (listData, success, error) in
                self.setDataForPin(dataArray: listData)
                self.view.reloadInputViews()
                self.myMaps.reloadInputViews()
            })
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: AnnotationView.self)
        {
            for subview in view.subviews
            {
                subview.removeFromSuperview()
            }
        }
    }
        
    func makeChoice(title: String){
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Details", style: .default, handler: detailsPin))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
        }))
        self.present(alert, animated:  true, completion: nil)
    }
    
    func detailsPin(alert: UIAlertAction){
        print("More Detail")
        performSegue(withIdentifier: "showDetails", sender: self)
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

