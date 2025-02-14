//
//  Foods.swift
//  Beybi
//
//  Created by Banu on 25.09.2024.
//

import Foundation

public struct Food: Codable {
    
    public var id: Int?
    public var name: String?
    public var cookingTime: String?
    public var recipe: String?
    public var imageUrl: String?
    public var type: String?
    public var introText: String?
    public var ingredients: [String?]
    public var recipeStep: [String?]
    public var mealId: String?
    
    public init(name: String? = nil, cookingTime: String? = nil, recipe: String? = nil, imageUrl: String? = nil, type: String? = nil, introText: String? = nil, ingredients: [String?], recipeStep: [String?], mealId: String) {
        self.name = name
        self.cookingTime = cookingTime
        self.recipe = recipe
        self.imageUrl = imageUrl
        self.type = type
        self.introText = introText
        self.ingredients = ingredients
        self.recipeStep = recipeStep
        self.mealId = mealId
    }
}

public struct EmotionalDiary: Codable {
    public var titleText: String?
    public var diaryText: String?
}

public struct FavoriteRequest: Codable {
    let deviceID: String
    let mealId: String
    
    enum CodingKeys: String, CodingKey {
        case mealId = "mealid"
        case deviceID = "deviceid"
    }
    
    public init(deviceID: String, mealId: String) {
        self.deviceID = deviceID
        self.mealId = mealId
    }
}

