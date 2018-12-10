//
//  MovieDetailViewController.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 07/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {
    
    @IBOutlet private weak var backdropImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var genreViewContainer: UIView!
    @IBOutlet private weak var plotLabel: UILabel!
    
    private var presenter: MovieDetailPresenterProtocol
    
    required init(with movie: MovieModel) {
        presenter = MovieDetailPresenter(with: movie)
        super.init(nibName: MovieDetailViewController.identifier, bundle: .main)
        presenter.attachView(self)
    }
    
    required init(presenter: MovieDetailPresenterProtocol) {
        self.presenter = presenter
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
    
    func fillMovieTitle(with title: String?) {
        titleLabel.text = title
    }
    
    func fillMovieYear(with year: String?) {
        yearLabel.text = year
    }
    
    func fillMovieGenre(with genre: String) {
        genreLabel.text = genre
        
    }
    
    func fillMoviePlot(with plot: String?) {
        plotLabel.text = plot
    }
    
    func fillMovieBackdrop(with url: URL?) {
        DispatchQueue.main.async { [weak self] in
            self?.backdropImageView.kf.setImage(with: url)
        }
    }
    
    func setGenreInfoHidden(_ isHidden: Bool) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.genreViewContainer.isHidden = isHidden
        })
    }
    
}
