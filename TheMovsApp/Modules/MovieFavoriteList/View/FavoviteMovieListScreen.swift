//
//  FavoviteMovieListScreen.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 12/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

protocol FavoviteMovieRemoveFilterDelegate: class {
    func didTouchRemoveFilterButton()
}

final class FavoviteMovieListScreen: UIView {
    
    weak var delegate: FavoviteMovieRemoveFilterDelegate?
    
    lazy var removeFilterButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Remove Filter", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 22)
        button.setTitleColor(.lightYellow, for: .normal)
        button.backgroundColor = .darkBlue
        button.addTarget(self, action: #selector(didTouchRemoveFilterButton), for: .touchUpInside)
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.separatorColor = .white
        return tableView
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FavoviteMovieListScreen {
    @objc
    func didTouchRemoveFilterButton() {
        delegate?.didTouchRemoveFilterButton()
    }
}

extension FavoviteMovieListScreen: CodeView {
    
    func buildViewHierarchy() {
        addSubview(removeFilterButton)
        addSubview(tableView)
    }
    
    func setupConstraints() {
        
        removeFilterButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.snp_topMargin)
            make.height.equalTo(65)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(removeFilterButton.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottomMargin.equalTo(self.snp.bottomMargin)
        }
        
    }
    
}

