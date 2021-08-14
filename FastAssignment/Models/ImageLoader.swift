//
//  ImageLoader.swift
//  FastAssignment
//
//  Created by Jianhua Wang on 8/12/21.
//

import Foundation
import UIKit

class ImageLoader {
    @discardableResult
    static func loadImage(forURL url: URL, queue: DispatchQueue = .main, callback: @escaping (UIImage?) -> Void) -> URLSessionTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, err in
            let result: UIImage?
            if let data = data, err == nil {
                result = UIImage(data: data)
            } else {
                result = nil
            }
            queue.async {
                callback(result)
            }
        }
        task.resume()
        return task
    }
}
