//
//  AnimalService.swift
//  AnimalIDAppiOSNew
//
//  Created by jason debottis on 7/13/16.
//  Copyright © 2016 jason debottis. All rights reserved.
//

import UIKit

public class AnimalService: NSObject, URLSessionDelegate, URLSessionTaskDelegate {
    var baseUrl = "http://jason-debottis.com"
    let config = URLSessionConfiguration.default
    public override init() {
        super.init()
        
    }
    
    public func getAnimals(_ endPoint:String, complete:@escaping (_ jsonResult:[AnyObject])->Void, fail:@escaping (NSError)->Void)->Void{
        let urlString = baseUrl + endPoint
        let url = URL(string: urlString)
        let request = NSMutableURLRequest(url: url! as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            if statusCode == 200 {
                print("Success")
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    complete(json as! [AnyObject])
                }catch{
                    print("Error->\(error)")
                    fail(error as NSError)
                }
            }
        }
        task.resume()
    }
    
    public func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        
    }
    
    @nonobjc public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
    }
    
    public func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        
    }
}
