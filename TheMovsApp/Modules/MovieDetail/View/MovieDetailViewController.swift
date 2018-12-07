//
//  MovieDetailViewController.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 07/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    
    private var presenter: MovieDetailPresenterProtocol
    
    required init(with movie: MovieModel) {
        presenter = MovieDetailPresenter(with: movie)
        super.init(nibName: MovieDetailViewController.identifier, bundle: .main)
        presenter.attachView(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        fatalError("init() has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    

}

// MARK: - MovieDetailViewProtocol

extension MovieDetailViewController: MovieDetailViewProtocol {
    
    func setScreenTitle(_ title: String) {
        self.title = title
    }
    
    func setFavoriteMovie(_ isFavorite: Bool) {
        //TODO
    }
    
    func fillMovieTitle(with title: String?) {
        titleLabel.text = title
    }
    
    func fillMovieYear(with year: String?) {
        yearLabel.text = year
    }
    
    func fillMovieGenre(with genre: String?) {
        genreLabel.text = genre
    }
    
    func fillMoviePlot(with plot: String?) {
        plotLabel.text = plot
    }
    
    func fillMovieBackdrop(with url: String?) {
        //TODO
    }
    
}
