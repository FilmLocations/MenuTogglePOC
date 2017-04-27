//
//  Movie.swift
//  Film Locations
//
//  Created by Laura on 4/25/17.
//  Copyright © 2017 Codepath Spring17. All rights reserved.
//

import Foundation
import SwiftyJSON

class Movie {
    
    // MARK: Data source: SFData
    
    var title: String {
        return sfDataJSON["title"].stringValue
    }
    
    var releaseYear: NSNumber {
        return sfDataJSON["release_year"].numberValue
    }
    
    var locations: String {
        return sfDataJSON["locations"].stringValue
    }
    
    var funFacts: String? {
        // In case fun facts is missing in SFData, no value is set
        return sfDataJSON["fun_facts"].stringValue != "" ? sfDataJSON["fun_facts"].stringValue : nil
    }
    
    var company: String? {
        // In case company is missing in SFData, no value is set
        return sfDataJSON["production_company"].stringValue != "" ? sfDataJSON["production_company"].stringValue : nil
    }
    
    var distributor: String? {
        // In case distributor is missing in SFData, no value is set
        return sfDataJSON["distributor"].stringValue != "" ? sfDataJSON["distributor"].stringValue : nil
    }
    
    var director: String? {
        // In case director is missing in SFData, no value is set
        return sfDataJSON["director"].stringValue != "" ? sfDataJSON["director"].stringValue : nil
    }
    
    var writer: String? {
        // In case writer is missing in SFData, no value is set
        return sfDataJSON["writer"].stringValue != "" ? sfDataJSON["writer"].stringValue : nil
    }
    
    var actor1: String? {
        // In case actor1 is missing in SFData, no value is set
        return sfDataJSON["actor_1"].stringValue != "" ? sfDataJSON["actor_1"].stringValue : nil
    }
    
    var actor2: String? {
        // In case actor2 is missing in SFData, no value is set
        return sfDataJSON["actor_2"].stringValue != "" ? sfDataJSON["actor_2"].stringValue : nil
    }
    
    var actor3: String? {
        // In case actor3 is missing in SFData, no value is set
        return sfDataJSON["actor_3"].stringValue != "" ? sfDataJSON["actor_3"].stringValue : nil
    }
    
    private var sfDataJSON: JSON!
    
    init(json: JSON) {
        sfDataJSON = json
    }
    
    // MARK: Data source: TMDB
    
    private var tmdbJSON: JSON?
    
    var posterURL: URL? {
        /* 
         
         According to https://developers.themoviedb.org/3/search/search-movies the poster_path is string or null.
         Not sure if this will work in both cases!!!!
         
         */

        guard let posterStringURL = tmdbJSON?["poster_path"].stringValue else {
            return nil
        }
        let url = URL(string: posterStringURL)
        return url
    }
    
    var overview: String? {
        return tmdbJSON?["overview"].stringValue
    }
    
    var languageSpoken: String? {
        return tmdbJSON?["original_language"].stringValue
    }
    
    var releaseDate: Date? {

        guard let releaseStringDate = tmdbJSON?["release_date"].stringValue else {
            return nil
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-DD"
        return formatter.date(from: releaseStringDate)
    }
    
    func mappingSFOpenData(json: JSON) {
        tmdbJSON = json
    }
}
