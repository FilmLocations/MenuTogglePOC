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
            //self.addAdditionalInfoToMovie()
            self.displayListOfMovies()
            
        }) { (error: Error) in
            
            print(error.localizedDescription)
        }
    }

    func addAdditionalInfoToMovie() {
        
        // TMDB has a limit of 40 APIs calls in 10s .. that's the reason why the details for the first 40th movies from the model list were fetched
        
        // some movies are added multiple times in the movies model list because they were filmed in different locations, therefore the details for one movie should be fetched only once and then should be set for all that movie's apparence in the movie model list
        
        // set current movie to the first element in the list
        var currentMovie = movies[0]
        var currentIndex = 0
        
        while currentIndex != movies.count - 1 {
            // fetch data for the current movie
            TMDSClient.sharedInstance.getMovieDetails(forTitle: currentMovie.title, and: currentMovie.releaseYear, success: { (json: JSON) in
                
                // for all movie's occurence in movies model list, set the details
                for (index, movie) in self.movies.enumerated() {
                    if movie.title == currentMovie.title {
                        self.movies[index].mappingSFOpenData(json: json)
                    }
                    else {
                        // set current movie to the next movie from the model list for which details must be fetched
                        currentMovie = movie
                        currentIndex = index
                        
                        // repeat process
                        break
                    }
                }
                
            }, failure: { (error: Error) in
                
                print(error.localizedDescription)
            })
            
        }
        
        if currentIndex != 0 {
            displayListOfMovies()
        }
    }

    private func displayListOfMovies() {
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
            
            if let posterURL = movie.posterURL {
                print("posterURL: \(posterURL)")
            }
            
            if let overview = movie.overview {
                print("overview: \(overview)")
            }
            
            if let language = movie.languageSpoken {
                print("language: \(language)")
            }
            
            if let releaseDate = movie.releaseDate {
                print("release date: \(releaseDate)")
            }
            
        }
    }
}
