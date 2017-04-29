//
//  TMDBClient.swift
//  Film Locations
//
//  Created by Laura on 4/25/17.
//  Copyright © 2017 Codepath Spring17. All rights reserved.
//

import Foundation
import SwiftyJSON

class TMDSClient {
    
    private let baseStringURL = "https://api.themoviedb.org/3"
    private let apiKey = "bd557ccc38dcfca42ec3e8bafda73329"
    
    private let searchMovieEndpoint = "/search/movie"
    
    static let sharedInstance = TMDSClient()
    
    func getMovieDetails(forTitle title: String?, and releaseYear: NSNumber?, success: @escaping (JSON) -> (), failure: @escaping (Error) -> ()) {
        
        var params: [String: AnyObject] = [:]
        
        if let title = title {
            params["query"] = title as AnyObject?
        }
        
        if let releaseYear = releaseYear {
            params["year"] = releaseYear as AnyObject?
        }
        
        // Search for movies using title and releaseYear
        let stringURL = createAPICall(with: params as NSDictionary)
        
        if let url = URL(string: stringURL) {
            let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
            
            let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                
                if error != nil {
                    failure(error!)
                }
                else {
                                        
                    if data != nil {
                        
                        let json = JSON(data: data!)
                        let firstReleaseMovieJSON = self.getFirstReleaseMovieInfo(json: json)
                        success(firstReleaseMovieJSON)
                    }
                }
            })
            
            task.resume()
        }
    }
    
    private func createAPICall(with parameters: NSDictionary) -> String {
        
        var apiStringURL = baseStringURL + searchMovieEndpoint + "?api_key=" + apiKey
        
        // Add parameters to API URL
        for (_, value) in parameters.enumerated() {
            apiStringURL = apiStringURL + "&\(value.key)=\(value.value)"
        }
        
        return apiStringURL
    }
    
    private func getFirstReleaseMovieInfo(json: JSON) -> JSON {
        // the json contains all the release date around the world, but we want to have the very first one
        
        let results = json["results"]
        var firstReleaseMovieInfoJSON = results.arrayValue[0]
        let firstReleaseDate = getFirstReleaseDate(from: results)
        
        for result in results.arrayValue {
            if result["release_date"].stringValue == firstReleaseDate {
                firstReleaseMovieInfoJSON = result
            }
        }
        return firstReleaseMovieInfoJSON
    }
    
    private func getFirstReleaseDate(from results: JSON) -> String {

        var firstRelease = Date()
        
        for result in results.arrayValue {
            let releaseDateString = result["release_date"].stringValue
            // to support date comparison, the string date value must be converted into a DATE value
            if let releaseDate = DateFormatter().date(from: releaseDateString) {
                if firstRelease.compare(releaseDate) != ComparisonResult.orderedAscending {
                    firstRelease = releaseDate
                }
            }
        }
        return DateFormatter().string(from: firstRelease)
    }
}
