//
//  ViewController.swift
//  MapApplication
//
//  Created by Henry Aguinaga on 2016-03-30.
//  Copyright © 2016 Henry Aguinaga. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var Mapview: MKMapView!
    @IBOutlet weak var SegmentControl: UISegmentedControl!
    
    
    var manager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
   
        let pinlocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(59.330423, 18.058287)
        let objectAnn = MKPointAnnotation()
        objectAnn.coordinate = pinlocation
        objectAnn.title = "Stockholm Centrum"
        objectAnn.subtitle = "Stockholm, Sweden"
        self.Mapview.addAnnotation(objectAnn)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func Direction2(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://maps.apple.com/maps?daddr=59.330423,18.058287")!)
        
    }

    
    @IBAction func MapType(sender: AnyObject) {
        
        if (SegmentControl.selectedSegmentIndex == 0){
            
            Mapview.mapType = MKMapType.Standard
        }
        
        if (SegmentControl.selectedSegmentIndex == 1){
            
            Mapview.mapType = MKMapType.Satellite
        }
        
        if (SegmentControl.selectedSegmentIndex == 2){
            
            Mapview.mapType = MKMapType.Hybrid
        }
        
    }

    @IBAction func LocateMe(sender: AnyObject) {
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        Mapview.showsUserLocation = true
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userlocation:CLLocation = locations[0] as CLLocation
        
        manager.stopUpdatingLocation()
        
        let location = CLLocationCoordinate2D(latitude: userlocation.coordinate.latitude, longitude: userlocation.coordinate.longitude)
        
        let span = MKCoordinateSpanMake(0.5, 0.5)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        Mapview.setRegion(region, animated: true)
       
    }
}
