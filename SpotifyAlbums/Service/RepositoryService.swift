//
//  RepositoryService.swift
//  SpotifyAlbums
//
//  Created by Ricardo Hurla on 04/07/2020.
//  Copyright © 2020 Ricardo Hurla. All rights reserved.
//

import Foundation

public typealias RepositoryParameters = [String: String]

public protocol RepositoryServiceType {
    func makeGetRequest<T: Decodable>(url: URL?,
                                      header: RepositoryParameters?,
                                      success: @escaping (T) -> Void,
                                      failure: @escaping (Error?) -> Void)
    func makePostRequest<T: Decodable>(url: URL?,
                                       header: RepositoryParameters?,
                                       body: RepositoryParameters?,
                                       success: @escaping (T) -> Void,
                                       failure: @escaping (Error?) -> Void)
}

public struct RepositoryService: RepositoryServiceType {
    public func makeGetRequest<T: Decodable>(url: URL?,
                                             header: RepositoryParameters?,
                                             success: @escaping (T) -> Void,
                                             failure: @escaping (Error?) -> Void) {
        guard let requestUrl = url else {
            failure(RepositoryError.urlError)
            return
        }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        if let headerParameters = header {
            headerParameters.forEach {
                request.setValue($0.value, forHTTPHeaderField: $0.key)
            }
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let requestData = data, error == nil else {
                failure(error)
                return
            }
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: requestData)
                success(decodedObject)
            } catch {
                failure(error)
            }
        }.resume()
    }

    public func makePostRequest<T: Decodable>(url: URL?,
                                              header: RepositoryParameters?,
                                              body: RepositoryParameters?,
                                              success: @escaping (T) -> Void,
                                              failure: @escaping (Error?) -> Void) {

        guard let requestUrl = url, let requestBody = body else {
            failure(RepositoryError.urlError)
            return
        }

        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        if let headerParameters = header {
            headerParameters.forEach {
                request.setValue($0.value, forHTTPHeaderField: $0.key)
            }
        }
        request.httpBody = requestBody.percentEncoded()
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let requestData = data, error == nil else {
                failure(error)
                return
            }

            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: requestData)
                success(decodedObject)
            } catch {
                failure(error)
            }
        }.resume()
    }
}
