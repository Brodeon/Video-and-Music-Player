//
//  ViewController.swift
//  Video Player
//
//  Created by Przemek on 3/9/19.
//  Copyright © 2019 Przemek Broda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, VideoCellDelegate {
  
    @IBOutlet weak var moviesTableView: UITableView!
    var movies = [Movie]()
    var selectedMovie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        movies = MovieModel().loadMovies()
        
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.capacity
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMovieCell", for: indexPath) as! VideoCell
        cell.movie = movies[indexPath.row]
        cell.delegate = self
        cell.titleLabel.text = cell.movie?.title
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCustomView" {
            var controller = segue.destination as! BuiltInViewController
            controller.movie = selectedMovie
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func cellClicked(movie: Movie?) {
        if let selectedMovie = movie {
            self.selectedMovie = selectedMovie
            performSegue(withIdentifier: "toCustomView", sender: self)
        }
    }
    
    
}

