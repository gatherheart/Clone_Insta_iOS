//
//  HTTPManager.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/12.
//

import FirebaseStorage

enum NetworkErrorCase: Error {
    case invalidURL
    case serverError
    case cacheError
}
enum RequestMethod: String {
    case GET, POST, PUT, DELETE
}

protocol FirestoreManable {
    func getResource(from: String, completion: @escaping(Data?, Error?) -> Void) throws
    func download(from: StorageReference, completion: @escaping (Data?, Error?) -> Void) throws
    func upload(data: Data, completion: @escaping (StorageMetadata?, Error?) -> Void) throws
}

enum EndPoint: String {
    case basePath =  "/"
    static let profileImagePath = "/profile_images"
}

class FirestoreManager: FirestoreManable {
    
    func getResource(from: String, completion: @escaping (Data?, Error?) -> Void) throws {
            try self.getResource(endPoint: nil, from: from, completion: completion)
        }

        func getResource(endPoint: EndPoint?, from: String, method: RequestMethod = .GET, payload: Data? = nil, completion: @escaping (Data?, Error?) -> Void) throws {
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
    
    func downloadURL(from: StorageReference, completion: @escaping (Data?, Error?) -> Void) throws {
        from.downloadURL { url, error in
            guard let imageUrl = url?.absoluteString else { return }
            completion(imageUrl, nil)
        }
    }
    
    func upload(data: Data, completion: @escaping (StorageMetadata?, Error?) -> Void) throws {
        let filename = UUID().uuidString
        let to = Storage.storage().reference(withPath: "\(EndPoint.profileImagePath)/\(filename)")
        to.putData(data, metadata: nil) { metaData, error in
            guard error == nil else { print("DEBUG: Upload Failure \(String(describing: error?.localizedDescription))") }
            completion(metaData, error)
        }
    }
    
    

}
