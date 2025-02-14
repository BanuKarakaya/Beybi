//
//  Endpoint.swift
//  Beybi
//
//  Created by Banu on 9.02.2025.
//

import Foundation
import Food

enum Endpoint {
    case recommendedRecipes(query: String)
    case soups(query: String)
    case breakfasts(query: String)
    case mainDishes(query: String)
    case snacks(query: String)
    case purees(query: String)
    case getFavs(query: String)
    case getDailyBreakfastMenu(query: String)
    case getDailyLunchMenu(query: String)
    case getDailyDinnerMenu(query: String)
    case addFavorite(request: FavoriteRequest)
    case removeFavorite(request: FavoriteRequest)
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

protocol EndpointProtocol {
    var baseUrl: String {get}
    var path : String {get}
    var body: Data? {get}
    func request () -> URLRequest
}

extension Endpoint: EndpointProtocol {
    var baseUrl: String {
        "https://beybibackend-production.up.railway.app/"
    }
    
    var path: String {
        switch self {
        case .recommendedRecipes(let query):
            return "\(query)"
        case .soups(let query):
            return "\(query)"
        case .breakfasts(let query):
            return "\(query)"
        case .mainDishes(let query):
            return "\(query)"
        case .purees(let query):
            return "\(query)"
        case .snacks(let query):
            return "\(query)"
        case .getFavs(let query):
            return "\(query)"
        case .addFavorite:
            return "favorites/add"
        case .removeFavorite:
            return "favorites/remove"
        case .getDailyBreakfastMenu(let query):
            return "\(query)"
        case .getDailyLunchMenu(let query):
            return "\(query)"
        case .getDailyDinnerMenu(let query):
            return "\(query)"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .addFavorite:
            return .post
        case .removeFavorite:
            return .delete
        default:
            return .get
        }
    }
    
    var body: Data? {
            switch self {
            case .addFavorite(let request):
                return try? JSONEncoder().encode(request)
            case .removeFavorite(let request):
                return try? JSONEncoder().encode(request)
            default:
                return nil
            }
        }
    
    func request() -> URLRequest {
        guard var component = URLComponents(string: baseUrl) else {
            fatalError("Invalid Error")
        }
        component.path = path
        var request = URLRequest(url: URL(string: baseUrl+path)!)
        request.httpMethod = method.rawValue
        
        if let body = body {
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        return request
    }
}
