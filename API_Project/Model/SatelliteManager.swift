//
//  SatelliteManager.swift
//  API_Project
//
//  Created by english on 2024-03-15.
//

import Foundation

protocol TestProtocol {
    func doSomething(satellite: SatelliteModel)
}

struct SatelliteManager {
    
    var delegate : TestProtocol?
    
    let partOne = "https://api.n2yo.com/rest/v1/satellite/positions/"
    
    let partTwo = "/41.702/-76.014/0/2/&apiKey=QJ6CL5-P7YJTF-UMPMJL-5825"
//    let partTwo = "27000/41.702/-76.014/0/2/&apiKey=QJ6CL5-P7YJTF-UMPMJL-5825""
    
    func fetchSatellite(satelliteId: Int) {
        let urlString = "\(partOne)\(satelliteId)\(partTwo)"
        
        performRequest(urlString: urlString, satelliteId: satelliteId)
    }
    
    func performRequest(urlString: String, satelliteId: Int) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error)
                    return
                }
                print("Check")
                if let safeData = data {
                    print("Inside")
                    // Parse JSON data and create SatelliteModel
                    if let satellite = self.parseJSON(satelliteData: safeData, satelliteId: satelliteId) {
                        DispatchQueue.main.async {
                            if delegate != nil {
                                // if somebody is listening/connected to the delegate
                                    delegate!.doSomething(satellite: satellite) // give the order to the "delegate" class to "do something"
                            }
                        }
                    }
                }else {
                    print("Data is nil")
                }
                
            }
            task.resume()
        }
    }
    
    func parseJSON(satelliteData: Data, satelliteId: Int) -> SatelliteModel? {
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(SatelliteData.self, from: satelliteData)
            
            print(decodedData)
            
            let latitude = decodedData.positions[0].satlatitude
            let longitude = decodedData.positions[0].satlongitude
            
            let satellite = SatelliteModel(satlatitude: latitude, satlongitude: longitude)
            
            print(satellite)
            
            return satellite
        }
        
        catch {
            print(error)
            return nil
        }
        
    }
}
