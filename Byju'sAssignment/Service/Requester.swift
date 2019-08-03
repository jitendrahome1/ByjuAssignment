//
//  Requester.swift
//  NavaAssignment
//
//  Created by Jitendra Kumar Agarwal on 21/02/19.
//  Copyright © 2019 Jitendra Kumar Agarwal. All rights reserved.
//

import UIKit

class Requester:NSObject,URLSessionDelegate,URLSessionDataDelegate {
    
    let opQueue = OperationQueue()
    var response:URLResponse?
    var session:URLSession?
   
    var responseData:((_ response: [String:AnyObject]?)->())?
    static let handler = Requester()
    fileprivate override init() { }
    var time:DispatchTime! {
        return DispatchTime.now() + 1.0 // seconds
    }
    
    func request(_ success: @escaping (_ response:[String:AnyObject]?) -> ()) {
       
        
        print("Requesting...")
        self.responseData =  success
        // suspend the OperationQueue (operations will be queued but won't get executed)
        self.opQueue.isSuspended = true
        let sessionConfiguration = URLSessionConfiguration.default
      
        self.session = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: self.opQueue)
        // create a URLRequest with the given URL and initialize a URLSessionDataTask
        if let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=3fcc3cdfdbc94d05a0c3d801d3ebbf96") {
            let request = URLRequest(url: url)
            if let task = self.session?.dataTask(with: request) {
                // start the task, tasks are not started by default
                task.resume()
                
            }
        }
        
        // Open the operations queue after 1 second
        DispatchQueue.main.asyncAfter(deadline: self.time, execute: {[weak self] in
            print("Opening the OperationQueue")
            self?.opQueue.isSuspended = false
        })
    }
    
    
    
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // We've got a URLAuthenticationChallenge - we simply trust the HTTPS server and we proceed
        print("didReceive challenge")
        completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!) )
    }
    
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        // We've got an error
        if let err = error {
            print("Error: \(err.localizedDescription)")
        } else {
            print("Error. Giving up")
        }
        
    }
    
    
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didBecome streamTask: URLSessionStreamTask) {
        // The task became a stream task - start the task
        print("didBecome streamTask")
        streamTask.resume()
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didBecome downloadTask: URLSessionDownloadTask) {
        // The task became a download task - start the task
        print("didBecome downloadTask")
        downloadTask.resume()
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // We've got a URLAuthenticationChallenge - we simply trust the HTTPS server and we proceed
        print("didReceive challenge")
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: (URLRequest?) -> Void) {
        // The original request was redirected to somewhere else.
        // We create a new dataTask with the given redirection request and we start it.
        if let urlString = request.url?.absoluteString {
            print("willPerformHTTPRedirection to \(urlString)")
        } else {
            print("willPerformHTTPRedirection")
        }
        if let task = self.session?.dataTask(with: request) {
            task.resume()
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        // We've got an error
        if let err = error {
            print("Error: \(err.localizedDescription)")
            let pData = OBJ_FOR_KEY(kNewsHeadLineDetails) as? Data
            do {
                guard let dict = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(pData!) as? [String: AnyObject] else {
                    fatalError("loadWidgetDataArray - Can't get Array")
                }
                self.responseData!((dict))
            } catch {
                fatalError("loadWidgetDataArray - Can't encode data: \(error)")
            }
           
           
        } else {
            print("Error. Giving up")
        }
        
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: (URLSession.ResponseDisposition) -> Void) {
        // We've got the response headers from the server.
        print("didReceive response")
        self.response = response
       completionHandler(URLSession.ResponseDisposition.allow)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        // We've got the response body
        print("didReceive data")
        if let responseText = String(data: data, encoding: .utf8) {
            //print(self.response)
            print("\nServer's response text")
            print(responseText)
        }
        
        do {
           
           let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
           
            self.responseData!((json))

            do {
                let placesData = try NSKeyedArchiver.archivedData(withRootObject: json, requiringSecureCoding: false)
                
                SET_OBJ_FOR_KEY(placesData as AnyObject , key: kNewsHeadLineDetails)
            } catch {
                fatalError("Can't encode data: \(error)")
            }

    
        } catch let error as NSError {
            print("Error parsing JSON: \(error.localizedDescription)")
        }
        
        self.session?.finishTasksAndInvalidate()
        
        
    }
    
}
