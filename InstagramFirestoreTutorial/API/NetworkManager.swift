//
//  HTTPManager.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/12.
//

import Foundation

enum NetworkErrorCase: Error {
    case invalidURL
    case serverError
    case cacheError
}
enum RequestMethod: String {
    case GET, POST, PUT, DELETE
}

protocol NetworkManable {
    static func getResource(from: String, completion: @escaping(Data?, Error?) -> Void) throws
}

enum EndPoint: String {
    case baseUrl =  ""
    static let paymentUrl = ""
}

class NetworkManager: NetworkManable {
    static func getResource(from: String, completion: @escaping (Data?, Error?) -> Void) throws {
        try self.getResource(endPoint: nil, from: from, completion: completion)
    }

    static func getResource(endPoint: EndPoint?, from: String, method: RequestMethod = .GET, payload: Data? = nil, completion: @escaping (Data?, Error?) -> Void) throws {
        var _from: String = from
        if let endPoint = endPoint { _from = endPoint.rawValue + _from }
        guard let url = URL(string: _from) else { throw NetworkErrorCase.invalidURL }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method.rawValue
        request.httpBody = payload
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                completion(nil, NetworkErrorCase.serverError)
                return
            }
            DispatchQueue.main.async {
                completion(data, nil)
            }
        }.resume()
    }
}

