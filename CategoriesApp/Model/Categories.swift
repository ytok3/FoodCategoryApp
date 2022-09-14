//
//  Categories.swift
//  CategoriesApp
//
//  Created by Yasemin TOK on 9.09.2022.
//

import Foundation

// MARK: - Categories
struct CategoriesList: Codable {
    let success: Bool?
    let data: [Categories]?
}

// MARK: - Datum
struct Categories: Codable {
    let categoryID, name: String?
    let icon: String?
    let orderIndex: Int?
    let createDate, updateDate: String?
    let totalProducts: Int?
    let isActive: Bool?

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case name, icon, orderIndex, createDate, updateDate, totalProducts, isActive
    }
}
