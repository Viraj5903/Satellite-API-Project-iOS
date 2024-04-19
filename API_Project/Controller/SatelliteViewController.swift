//
//  ViewController.swift
//  API_Project
//
//  Created by english on 2024-03-08.
//

import UIKit
import MapKit

//URL: https://api.n2yo.com/rest/v1/satellite/positions/27000/41.702/-76.014/0/2/&apiKey=QJ6CL5-P7YJTF-UMPMJL-5825
class SatelliteViewController: UIViewController, UITextFieldDelegate, TestProtocol {
    
    func doSomething(satellite: SatelliteModel) {
        didUpdateSatellite(satellite: satellite)
    }

    @IBOutlet weak var SatellitePicker: UIPickerView!
    
    @IBOutlet weak var SatelliteMapView: MKMapView!
    
    var satellites = ["Space Station", "DELTA 2 DEB (DPAF)", "SL-13 R/B", "STS 89", "PSLV DEB", "ASTRA 3A", "INTELSAT 902"]
    var selectedSatellite = "Space Station"
    
    var satelliteManager = SatelliteManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let annontation = MKPointAnnotation()
//        let montreal = CLLocationCoordinate2D(latitude: 73.5674, longitude: 45.5019)
//        annontation.coordinate = montreal
//        SatelliteMapView.addAnnotation(annontation)
//        let region = MKCoordinateRegion(center: montreal, latitudinalMeters: 100, longitudinalMeters: 100)
//        SatelliteMapView.setRegion(region, animated: true)
        
        satelliteManager.delegate = self
        
        SatellitePicker.dataSource = self
        SatellitePicker.delegate = self
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        
        let region = MKCoordinateRegion(center: annotation.coordinate , latitudinalMeters: 1000000, longitudinalMeters: 1000000)
        self.SatelliteMapView.setRegion(region, animated: true)
    }

    func didUpdateSatellite(satellite: SatelliteModel) {
        DispatchQueue.main.async {
            if let latitude = satellite.satlatitude, let longitude = satellite.satlongitude {
                // Remove all existing annotations from the map view
                self.SatelliteMapView.removeAnnotations(self.SatelliteMapView.annotations)
                
                // Create a new annotation with the satellite's coordinates
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                
                // Set the title of the annotation to the selected satellite
                annotation.title = self.selectedSatellite
                
                // Add the new annotation to the map view
                self.SatelliteMapView.addAnnotation(annotation)
                
                let region = MKCoordinateRegion(center: annotation.coordinate , latitudinalMeters: 10000000, longitudinalMeters: 10000000)
                self.SatelliteMapView.setRegion(region, animated: true)
                
            
            } else {
                // Handle error condition if latitude or longitude is nil
                print("Error")
            }
        }
    }

    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    @IBAction func SearchButton(_ sender: UIButton) {
        if let satelleteId = getSatelliteId(satellite: selectedSatellite) {
            satelliteManager.fetchSatellite(satelliteId: satelleteId)
        }
    }
    
    func getSatelliteId(satellite: String) -> Int? {
        
        switch(satellite) {
        case satellites[0]:
            return 25544
        case satellites[1]:
            return 27000
        case satellites[2]:
            return 26401
        case satellites[3]:
            return 26143
        case satellites[4]:
            return 27290
        case satellites[5]:
            return 27400
        case satellites[6]:
            return 26900
        default:
            break
        }
        
        return -1
    }
    
}

extension SatelliteViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return satellites.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return satellites[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSatellite = satellites[row]
    }
}
