//
//  Foods.swift
//  Beybi
//
//  Created by Banu on 25.09.2024.
//

import Foundation

public struct Food: Codable {
    
    public var name: String?
    public var cookingTime: String?
    public var recipe: String?
    public var imageUrl: String?
    public var type: String?
    public var introText: String?
    public var ingredients: [String?]
    public var recipeStep: [String?]
    
    public init(name: String? = nil, cookingTime: String? = nil, recipe: String? = nil, imageUrl: String? = nil, type: String? = nil, introText: String? = nil, ingredients: [String?], recipeStep: [String?]) {
        self.name = name
        self.cookingTime = cookingTime
        self.recipe = recipe
        self.imageUrl = imageUrl
        self.type = type
        self.introText = introText
        self.ingredients = ingredients
        self.recipeStep = recipeStep
    }
}

public struct Eym {
    
    public var imageUrl: String?
    
    public init(imageUrl: String? = nil) {
        self.imageUrl = imageUrl
    }
}

public struct Info {
    
    public var imageUrl: String?
    public var infoText: String?
    
    public init(imageUrl: String? = nil, infoText: String? = nil) {
        self.imageUrl = imageUrl
        self.infoText = infoText
    }
}


public struct EmotionalDiary: Codable {
    public var titleText: String?
    public var diaryText: String?
}
