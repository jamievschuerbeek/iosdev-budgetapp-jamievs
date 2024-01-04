//
//  HttpClient.swift
//  budgetApp
//
//  Created by Jamie Van Schuerbeek on 31/12/2023.
//

//SOURCE: https://github.com/codewithchris/YT-Vapor-iOS-App/blob/lesson-3/YT-Vapor-iOS-App/Utilities/HttpClient.swift

import Foundation

enum HttpMethods: String {
    case POST, GET, PUT, DELETE
}

enum MIMEType: String {
    case JSON = "application/json"
}

enum HttpHeaders: String {
    case contentType = "Content-Type"
}

enum HttpError: Error {
    case badURL, badResponse, errorDecodingData, invalidURL
}

class HttpClient {
    private init() { }
    
    static let shared = HttpClient()
    
    func fetch<T: Codable>(url: URL) async throws -> [T] {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
        
        //geeft anders problemen met dates decoderen
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        //TODO: Delete in prod - is er voor debug in case dat decoden zou failen
        do {
            try decoder.decode([T].self, from: data)
        } catch {
            print("\(error)")
        }
        
        guard let object = try? decoder.decode([T].self, from: data) else {
            throw HttpError.errorDecodingData
        }
        return object
    }
    
    func sendData<T: Codable>(to url: URL, object: T, httpMethod: String) async throws {
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod
        request.addValue(MIMEType.JSON.rawValue,
                         forHTTPHeaderField: HttpHeaders.contentType.rawValue)
        
        request.httpBody = try? JSONEncoder().encode(object)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
    }
}
