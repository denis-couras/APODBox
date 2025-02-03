//
//  UIImageView+Extension.swift
//  APODBox
//
//  Created by Denis Couras on 30/01/25.
//
import UIKit

public extension UIImageView {
    func loadImage(
        from url: URL,
        contentMode: ContentMode = .scaleAspectFit,
        with renderingMode: UIImage.RenderingMode = .automatic,
        errorImage: UIImage? = nil
    ) {
        self.contentMode = contentMode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse,
                httpURLResponse.statusCode == 200,
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {
                DispatchQueue.main.async { [weak self] in
                    self?.image = errorImage
                }
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.image = image.withRenderingMode(renderingMode)
            }
        }.resume()
    }
}
