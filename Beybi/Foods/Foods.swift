//
//  Foods.swift
//  Beybi
//
//  Created by Banu on 25.09.2024.
//

import Foundation

struct Food: Codable {
    var name: String?
    var cookingTime: String?
    var recipe: String?
    var imageUrl: String?
    var type: String?
    var introText: String?
    var ingredients: [String?]
    var recipeStep: [String?]
}

struct Eym {
    var imageUrl: String?
}

struct Info {
    var imageUrl: String?
    var infoText: String?
}


struct EmotionalDiary: Codable {
    var titleText: String?
    var diaryText: String?
}
