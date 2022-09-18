//
//  ProductDetail.swift
//  CategoriesApp
//
//  Created by Yasemin TOK on 11.09.2022.
//

import Foundation

// MARK: - ProductDetail
struct ProductDetail: Codable {
    let success: Bool?
    let data: Detail?
}

// MARK: - DataClass
struct Detail: Codable {
    let id, appID: String?
    let category: Category?
    let categoryID: String?
    let isUnLimitedStock: Bool?
    let title: String?
    let featuredImage: FeaturedImage?
    let images: [FeaturedImage]?
    let videos: [String]?
    let dataDescription: String?
    let stock: Int?
    let stockCode: String?
    let price: Double?
    let currency: String?
    let maxQuantityPerOrder: Int?
    let itemType: String?
    let campaignPrice: Double?
    let shippingPrice, orderIndex: Int?
    let isPublished, isActive: Bool?
    let publishmentDate, endDate, createDate, updateDate: String?
    let useFixPrice: Bool?
    let variantData, variationGroups, variants: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case appID = "appId"
        case category
        case categoryID = "categoryId"
        case isUnLimitedStock, title, featuredImage, images, videos
        case dataDescription = "description"
        case stock, stockCode, price, currency, maxQuantityPerOrder, itemType, campaignPrice, shippingPrice, orderIndex, isPublished, isActive, publishmentDate, endDate, createDate, updateDate, useFixPrice, variantData, variationGroups, variants
    }
}
