//
//  Products.swift
//  CategoriesApp
//
//  Created by Yasemin TOK on 10.09.2022.
//

import Foundation

// MARK: - ProductsList
struct ProductsList: Codable {
    let success: Bool?
    let data: [Products]?
    let meta: Meta?
}

// MARK: - Datum
struct Products: Codable {
    let id, appID: String?
    let category: Category?
    let categoryID: String?
    let isUnLimitedStock: Bool?
    let title: String?
    let featuredImage: FeaturedImage?
    let images: [FeaturedImage]?
    let videos: [String]?
    let datumDescription: String?
    let stock: Int?
    let stockCode: String?
    let price: Int?
    let currency: String?
    let maxQuantityPerOrder: Int?
    let itemType: String?
    let campaignPrice, shippingPrice, orderIndex: Int?
    let isPublished, isActive: Bool?
    let publishmentDate, endDate, createDate, updateDate: String?
    let useFixPrice: Bool?
    let variantData: [String]?
    let brand: Brand?
    let brandID: String?

    enum CodingKeys: String, CodingKey {
        case id
        case appID = "appId"
        case category
        case categoryID = "categoryId"
        case isUnLimitedStock, title, featuredImage, images, videos
        case datumDescription = "description"
        case stock, stockCode, price, currency, maxQuantityPerOrder, itemType, campaignPrice, shippingPrice, orderIndex, isPublished, isActive, publishmentDate, endDate, createDate, updateDate, useFixPrice, variantData, brand
        case brandID = "brandId"
    }
}

// MARK: - Brand
struct Brand: Codable {
    let id, name: String?
    let icon: FeaturedImage?
    let isActive: Bool?
    let createDate, updateDate: String?
}

// MARK: - FeaturedImage
struct FeaturedImage: Codable {
    let t, n: String?
}

// MARK: - Category
struct Category: Codable {
    let categoryID, name: String?
    let icon: FeaturedImage?
    let orderIndex: Int?
    let createDate, updateDate: String?
    let totalProducts: Int?
    let isActive: Bool?
    let subCategories: [String]?

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case name, icon, orderIndex, createDate, updateDate, totalProducts, isActive, subCategories
    }
}

// MARK: - Meta
struct Meta: Codable {
    let queryCount, itemsCount: Int?
}
