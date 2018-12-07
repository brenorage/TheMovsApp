//
//  UICollectionView+Extension.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 04/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func dequeueReusableCell<T: UICollectionViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else { fatalError() }
        return cell
    }
    
    public func register<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = String(describing: cellType)
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }
}
