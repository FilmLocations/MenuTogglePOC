//
//  ViewController.swift
//  Film Locations
//
//  Created by Jessica Thrasher on 4/23/17.
//  Copyright © 2017 Codepath Spring17. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        SFDataClient.sharedInstance.getAllFilmLocations(success: { (movies: [Movie]) in
            
            self.movies = movies
            self.addAdditionalInfoToMovie()
            
            for movie in movies {
             
                // SFData:
                
                print("---------------------------------------------------------")
                print("title: \(movie.title)")
                print("release year: \(movie.releaseYear)")
                print("locations: \(movie.locations)")

                if let funFacts = movie.funFacts {
                    print("funFacts: \(funFacts)")
                }
                
                if let company = movie.company {
                    print("company: \(company)")
                }
                
                if let distributor = movie.distributor {
                    print("distributor: \(distributor)")
                }
                
                if let director = movie.director {
                    print("director: \(director)")
                }
                
                if let writer = movie.writer {
                    print("writer: \(writer)")
                }
                
                if let actor1 = movie.actor1 {
                    print("actor1: \(actor1)")
                }

                if let actor2 = movie.actor2 {
                    print("actor2: \(actor2)")
                }

                if let actor3 = movie.actor3 {
                    print("actor3: \(actor3)")
                }

                // TMDB data:
                
                if let language = movie.languageSpoken {
                    print("language: \(language)")
                }
                
                if let overview = movie.overview {
                    print("overview: \(overview)")
                }
                
            }
        }) { (error: Error) in
            
            print(error.localizedDescription)
        }
    }

    func addAdditionalInfoToMovie() {
        //for movie in movies {
            TMDSClient.sharedInstance.getMovieDetails(forTitle: movies[0].title, and: movies[0].releaseYear, success: { (json: JSON) in
                
                print("json TMDB: \(json)")
                self.movies[0].mappingSFOpenData(json: json)
                
            }, failure: { (error: Error) in
                
                print(error.localizedDescription)
            })
        //}
    }

}
