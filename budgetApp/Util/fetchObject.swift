//
//  fetchObject.swift
//  budgetApp
//
//  Created by Jamie Van Schuerbeek on 04/01/2024.
//

import Foundation

var dataUrl = "https://budgetapi.fly.dev"

func fetchObject<T: Codable>(urlPath: String) async throws -> [T]{
    let urlString = "\(dataUrl)/\(urlPath)"
    
    guard let url = URL(string: urlString) else {
        throw HttpError.badURL
    }
    
    let response: [T] = try await HttpClient.shared.fetch(url: url)
    
    return response
}

func fetchObjectWithDate<T: Codable>(urlPath: String, year: Int, month: String) async throws -> [T] {
    let urlString = "\(dataUrl)/\(urlPath)/date/\(year)/month/\(month)"
        
    guard let url = URL(string: urlString) else {
        throw HttpError.badURL
    }
    
    let response: [T] = try await HttpClient.shared.fetch(url: url)
    
    return response
}

func fetchSingleObject<T: Codable>(urlPath: String, id: UUID) async throws -> T {
    let urlString = "\(dataUrl)/\(urlPath)/\(id)"
    
    guard let url = URL(string: urlString) else {
        throw HttpError.badURL
    }
    
    let response: T = try await HttpClient.shared.fetchSingle(url: url)
    
    return response
}
