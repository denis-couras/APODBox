//
//  UIImageView+Extension.swift
//  APODBox
//
//  Created by Denis Couras on 30/01/25.
//
import UIKit

public extension UIImageView {
    private static let imageCache = NSCache<NSURL, UIImage>()

    func loadImage(
        from url: URL,
        contentMode: ContentMode = .scaleAspectFit,
        with renderingMode: UIImage.RenderingMode = .automatic,
        errorImage: UIImage? = nil
    ) {
        self.contentMode = contentMode
        if let cachedImage = UIImageView.imageCache.object(forKey: url as NSURL) {
            self.image = cachedImage.withRenderingMode(renderingMode)
            return
        }

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

            UIImageView.imageCache.setObject(image, forKey: url as NSURL)

            DispatchQueue.main.async { [weak self] in
                self?.image = image.withRenderingMode(renderingMode)
            }
        }.resume()
    }
}
