//
//  SFDataClient.swift
//  Film Locations
//
//  Created by Laura on 4/25/17.
//  Copyright © 2017 Codepath Spring17. All rights reserved.
//

import Foundation
import SwiftyJSON

class SFDataClient {
    
    private let apiEndpoint = "https://data.sfgov.org/resource/wwmu-gmzc.json"
    
    private let apiKey = "AetNNLauSDztSTKTwgvCFhX1K"
    
    // ApiSecret wasn't used for data fetch request !!!!
    private let apiSecret = "tgbRM_id9Bf0tseGvBhV3bSFzO7n3CpQIqFp"
    
    static let sharedInstance = SFDataClient()
    
    func getAllFilmLocations(success: @escaping ([Movie]) -> (), failure: @escaping (Error) -> ()) {
        
        let stringURL = createAPICall()
        
        if let url = URL(string: stringURL) {
            let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)

            let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                if error != nil {
                    failure(error!)
                }
                else {
                    if data != nil {
                        
                        // Fetch all the data from the SFOpenData DB
                        let jsonArray = JSON(data: data!)
                        
                        var movies: [Movie] = []
                        
                        for json in jsonArray.array! {
                        
                            let movie = Movie(json: json)
                            movies.append(movie)
                        }
                        
                        success(movies)
                    }
                }
            })
            task.resume()
        }
    }
    
    private func createAPICall() -> String {
        
        // Add API token parameter to the API URL
        let apiStringURL = apiEndpoint + "?$$app_token=" + apiKey
        return apiStringURL
    }
}
