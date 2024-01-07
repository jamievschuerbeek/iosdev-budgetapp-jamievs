//
//  addObject.swift
//  budgetApp
//
//  Created by Jamie Van Schuerbeek on 07/01/2024.
//

import Foundation

func addObject<T: Codable>(urlPath: String, object: T) async throws{
    let urlString = "\(dataUrl)/\(urlPath)"
    
    guard let url = URL(string: urlString) else {
        throw HttpError.badURL
    }
    
    try await HttpClient.shared.sendData(to: url, object: object, httpMethod: HttpMethods.POST.rawValue)
}
