//
//  DishType.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/2/23.
//

import Foundation

enum DishType: RawRepresentable, Codable {
    case main
    case side
    case dessert
    case appetizer
    case salad
    case bread
    case breakfast
    case soup
    case beverage
    case sauce
    case marinade
    case fingerfood
    case snack
    case drink
    case lunch
    case dinner
    case other(String)
    
    var rawValue: String {
        switch self {
        case .main:
            "main course"
        case .side:
            "side dish"
        case .dessert:
            "dessert"
        case .appetizer:
            "appetizer"
        case .salad:
            "salad"
        case .bread:
            "bread"
        case .breakfast:
            "breakfast"
        case .soup:
            "soup"
        case .beverage:
            "beverage"
        case .sauce:
            "sauce"
        case .marinade:
            "marinade"
        case .fingerfood:
            "fingerfood"
        case .snack:
            "snack"
        case .drink:
            "drink"
        case .lunch:
            "lunch"
        case .dinner:
            "dinner"
        case .other(let string):
            string
        }
    }
    
    init?(rawValue: String) {
        switch rawValue.lowercased() {
        case "main dish", "main course", "main":
            self = .main
        case "side dish", "side course", "side":
            self = .side
        case "beverage":
            self = .beverage
        case "sauce":
            self = .sauce
        case "marinade":
            self = .marinade
        case "fingerfood", "finger food", "finger":
            self = .fingerfood
        case "snack", "snacks":
            self = .snack
        case "drink", "drinks":
            self = .drink
        case "lunch", "luncheon":
            self = .lunch
        case "dinner", "supper":
            self = .dinner
        default:
            self = .other(rawValue)
        }
    }
}

extension DishType: Equatable {
    static func ==(lhs: DishType, rhs: DishType) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}
