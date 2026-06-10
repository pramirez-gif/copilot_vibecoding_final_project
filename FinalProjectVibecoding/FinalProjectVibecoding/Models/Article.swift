//
//  Article.swift
//  FinalProjectVibecoding
//
//  Created by Pablo Ramirez on 10/06/26.
//



import Foundation

/// Response wrapper for the sample JSON.
struct NewsResponse: Decodable {
    let status: String
    let totalResults: Int
    let results: [Article]
    let nextPage: String
}

/// Represents a news article. Conforms to Decodable, Identifiable and Hashable for use in SwiftUI lists and navigation.
struct Article: Decodable, Identifiable, Hashable {
    // Provide a locally-generated id so each decoded article is identifiable in SwiftUI lists.
    let articleID: String
    var id: String { articleID }
    let link: String
    let title: String
    let description: String?
    let content: String
    let keywords: [String]?
    let creator: [String]?
    let language: Language
    let country, category: [String]
    let datatype: Datatype
    let pubDate: String
    let pubDateTZ: PubDateTZ
    let fetchedAt: String
    let imageURL: String?
    let videoURL: String?
    let sourceID, sourceName: String
    let sourcePriority: Int
    let sourceURL: String
    let sourceIcon: String?
    let sentiment: Sentiment
    let sentimentStats: SentimentStats
    let aiTag: [String]
    let aiRegion, aiOrg: [String]?
    let aiSummary: String?
    let duplicate: Bool
    
    enum CodingKeys: String, CodingKey {
        case articleID = "article_id"
        case link, title, description, content, keywords, creator, language, country, category, datatype, pubDate, pubDateTZ
        case fetchedAt = "fetched_at"
        case imageURL = "image_url"
        case videoURL = "video_url"
        case sourceID = "source_id"
        case sourceName = "source_name"
        case sourcePriority = "source_priority"
        case sourceURL = "source_url"
        case sourceIcon = "source_icon"
        case sentiment
        case sentimentStats = "sentiment_stats"
        case aiTag = "ai_tag"
        case aiRegion = "ai_region"
        case aiOrg = "ai_org"
        case aiSummary = "ai_summary"
        case duplicate
    }
}

enum Datatype: String, Codable {
    case analysis = "analysis"
    case blog = "blog"
    case news = "news"
    case research = "research"
}

enum Language: String, Codable {
    case english = "english"
}

enum PubDateTZ: String, Codable {
    case utc = "UTC"
}

enum Sentiment: String, Codable {
    case negative = "negative"
    case neutral = "neutral"
    case positive = "positive"
}

// MARK: - SentimentStats
struct SentimentStats: Codable {
    let negative, neutral, positive: Double
}

/// Source information for an article.
struct Source: Decodable, Hashable {
    let id: String?
    let name: String?
}

// Use articleID as the unique identifier for equality and hashing
extension Article {
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.articleID == rhs.articleID
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(articleID)
    }
}
