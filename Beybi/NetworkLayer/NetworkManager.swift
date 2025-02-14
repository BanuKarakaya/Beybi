//
//  NetworkManager.swift
//  Beybi
//
//  Created by Banu on 9.02.2025.
//

import Foundation
import Food
import UIKit

protocol NetworkManagerInterface {
    func request<T: Decodable> (_ endpoint: Endpoint, completion: @escaping (Swift.Result  <T, Error>) -> Void) -> Void
    
    func getRecommendedRecipes(completion: @escaping (Swift.Result<[Food] , Error>) -> Void) -> Void
    func getSoups(completion: @escaping (Swift.Result<[Food] , Error>) -> Void) -> Void
    func getBreakfasts(completion: @escaping (Swift.Result<[Food] , Error>) -> Void) -> Void
    func getMainDishes(completion: @escaping (Swift.Result<[Food] , Error>) -> Void) -> Void
    func getPurees(completion: @escaping (Swift.Result<[Food] , Error>) -> Void) -> Void
    func getSnacks(completion: @escaping (Swift.Result<[Food] , Error>) -> Void) -> Void
    func addToFavorites(mealId: String, completion: @escaping (Bool) -> Void)
    func removeToFavorites(mealId: String, completion: @escaping (Bool) -> Void)
    func getFavs(completion: @escaping (Swift.Result<[Food] , Error>) -> Void) -> Void
    func getDailyBreakfastMenu(completion: @escaping (Swift.Result<[Food] , Error>) -> Void) -> Void
    func getDailyLunchMenu(completion: @escaping (Swift.Result<[Food] , Error>) -> Void) -> Void
    func getDailyDinnerMenu(completion: @escaping (Swift.Result<[Food] , Error>) -> Void) -> Void
}

final class NetworkManager: NetworkManagerInterface {

    static let shared = NetworkManager()
    
    private init() {}
    
    func request<T:Decodable> (_ endpoint : Endpoint, completion : @escaping (Swift.Result  <T, Error>) ->Void) ->Void {
        
        let urlSessionTask = URLSession.shared.dataTask(with: endpoint.request()) {(data ,response , error) in
            if let error = error {
                print(error)
            }
            if let response = response as? HTTPURLResponse {}
            
            if let data = data {
                do {
                    let jsonData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(jsonData))
                    
                }catch let error {
                    completion(.failure(error))
                }
            }
            
        }
        urlSessionTask.resume()
    }
    
    func getRecommendedRecipes (completion: @escaping (Swift.Result<[Food] , Error>) ->Void) -> Void {
        let endpoint = Endpoint.recommendedRecipes(query: "recommendedRecipe")
        request(endpoint, completion: completion)
    }
    
    func getSoups (completion: @escaping (Swift.Result<[Food] , Error>) ->Void) -> Void {
        let endpoint = Endpoint.recommendedRecipes(query: "soups")
        request(endpoint, completion: completion)
    }
    
    func getBreakfasts (completion: @escaping (Swift.Result<[Food] , Error>) ->Void) -> Void {
        let endpoint = Endpoint.recommendedRecipes(query: "breakfasts")
        request(endpoint, completion: completion)
    }
    
    func getMainDishes (completion: @escaping (Swift.Result<[Food] , Error>) ->Void) -> Void {
        let endpoint = Endpoint.recommendedRecipes(query: "mainDishes")
        request(endpoint, completion: completion)
    }
    
    func getPurees (completion: @escaping (Swift.Result<[Food] , Error>) ->Void) -> Void {
        let endpoint = Endpoint.recommendedRecipes(query: "recommendedRecipe")
        request(endpoint, completion: completion)
    }
    
    func getSnacks (completion: @escaping (Swift.Result<[Food] , Error>) ->Void) -> Void {
        let endpoint = Endpoint.recommendedRecipes(query: "recommendedRecipe")
        request(endpoint, completion: completion)
    }
    
    func getFavs (completion: @escaping (Swift.Result<[Food] , Error>) ->Void) -> Void {
        let endpoint = Endpoint.recommendedRecipes(query: "favorites/get")
        request(endpoint, completion: completion)
    }
    
    func addToFavorites(mealId: String, completion: @escaping (Bool) -> Void) {
        let deviceID = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
        let favoriteRequest = FavoriteRequest(deviceID: deviceID, mealId: mealId)
        let endpoint = Endpoint.addFavorite(request: favoriteRequest)
        
        let task = URLSession.shared.dataTask(with: endpoint.request()) { _, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, error == nil else {
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }
            DispatchQueue.main.async {
                completion(true)
            }
        }
        task.resume()
    }
    
    func removeToFavorites(mealId: String, completion: @escaping (Bool) -> Void) {
        let deviceID = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
        let request = FavoriteRequest(deviceID: deviceID, mealId: mealId)
        let endpoint = Endpoint.removeFavorite(request: request)
        
        let task = URLSession.shared.dataTask(with: endpoint.request()) { _, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, error == nil else {
                DispatchQueue.main.async { completion(false) }
                return
            }
            DispatchQueue.main.async { completion(true) }
        }
        task.resume()
    }
    
    func getDailyBreakfastMenu (completion: @escaping (Swift.Result<[Food] , Error>) ->Void) -> Void {
        let endpoint = Endpoint.recommendedRecipes(query: "daily-menu/breakfast")
        request(endpoint, completion: completion)
    }
    
    func getDailyLunchMenu (completion: @escaping (Swift.Result<[Food] , Error>) ->Void) -> Void {
        let endpoint = Endpoint.recommendedRecipes(query: "daily-menu/lunch")
        request(endpoint, completion: completion)
    }
    
    func getDailyDinnerMenu (completion: @escaping (Swift.Result<[Food] , Error>) ->Void) -> Void {
        let endpoint = Endpoint.recommendedRecipes(query: "daily-menu/dinner")
        request(endpoint, completion: completion)
    }
}
