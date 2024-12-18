//
//  ExtensionForUIImageView.swift
//  InstagramClone
//
//  Created by Nino Kurshavishvili on 23.11.24.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}

