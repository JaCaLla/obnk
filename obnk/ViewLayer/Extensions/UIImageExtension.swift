//
//  UIImageExtension.swift
//  obnk
//
//  Created by Javier Calatrava on 29/12/22.
//

import UIKit

extension UIImageView {

    // MARK: - Typealias
    typealias Completion = (ImageError?) -> Void

    // MARK: - Error enum
    enum ImageError: Error {
        case badRequest
        case general
        case imageUnparseable
        case invalidData
    }

    func setImage(from url: URL?,
                  alpha: CGFloat = 0,
                  removeCurrentIfNil removeIfNil: Bool = true,
                  completed: Completion? = nil) {
        self.alpha = alpha
        if let imageFromCache = ImagesCache.shared.object(forKey: url as AnyObject) as? UIImage {
            animateImage(image: imageFromCache, removeIfNil: removeIfNil, completed: completed)
            return
        }

        request(url: url, completed: { response in
            switch response {
            case .success(let image):
                self.animateImage(image: image, removeIfNil: removeIfNil, completed: completed)
            case .failure(let error):
                self.animateImage(removeIfNil: removeIfNil, completed: completed, error: error)
            }
        })
    }

    private func animateImage(image: UIImage? = nil,
                              removeIfNil: Bool,
                              completed: Completion? = nil,
                              error: ImageError? = nil) {
        if image != nil || removeIfNil {
            self.image = image
        }

        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
        }, completion: { _ in
            completed?(error)
        })
    }

    // MARK: - Private Methods
    private func request(url: URL?,
                         completed: @escaping(Result<UIImage, ImageError>) -> Void) {

        guard let request = makeRequest(url) else {
            completed(.failure(.badRequest))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if error != nil {
                    completed(.failure(.general))
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completed(.failure(.invalidData))
                    return
                }

                guard let data = data else {
                    completed(.failure(.invalidData))
                    return
                }

                if let image = UIImage(data: data) {
                    ImagesCache.shared.setObject(image, forKey: url as AnyObject)
                    completed(.success(image))
                } else {
                    completed(.failure(.imageUnparseable))
                }
            }
        }
            .resume()
    }

    private func makeRequest(_ route: URL?) -> URLRequest? {
        guard let url = route else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
