//
//  GenericErrorView.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 07/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

final class GenericErrorView: UIView {
    
    private var model: GenericErrorModel
    
    private lazy var errorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = model.image
        imageView.tintColor = model.imageColor
        return imageView
    }()
    
    private lazy var errorMessage: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(28)
        label.textAlignment = .center
        label.textColor = .black
        label.accessibilityHint = model.message
        label.accessibilityLabel = "Campo da mensagem de erro"
        label.numberOfLines = 0
        label.text = model.message
        return label
    }()
    
    private let errorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    init(frame: CGRect = .zero, model: GenericErrorModel) {
        self.model = model
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GenericErrorView: CodeView {
    func buildViewHierarchy() {
        addSubview(errorStackView)
        errorStackView.addArrangedSubview(errorImage)
        errorStackView.addArrangedSubview(errorMessage)
    }
    
    func setupConstraints() {
        errorStackView.snp.makeConstraints { maker in
            maker.centerX.centerY.equalToSuperview()
            maker.left.equalTo(10)
            maker.right.equalTo(-10)
        }
    }

    func setupAdditionalConfiguration() {
        self.backgroundColor = .white
    }
}
