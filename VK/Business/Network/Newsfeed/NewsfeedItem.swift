//
//  NewsfeedItem.swift
//  VK
//
//  Created by Евгений Бижанов on 16/03/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

struct NewsfeedItem: BidirectionalMappable {
    let type: String
    let sourceId: Int
    let date: Int
    let text: String?
    let comments: Comments?
    let likes: Likes?
    let reposts: Reposts?
    let photos: Photos?
}

extension NewsfeedItem {
    enum DecodingKeys: String, CodingKey {
        case sourceId = "source_id"
    }
    
    public init(from decoder: Decoder) throws {
        let decodingContainer = try decoder.container(keyedBy: DecodingKeys.self)
        sourceId = try decodingContainer.decode(Int.self, forKey: .sourceId)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        date = try container.decode(Int.self, forKey: .date)
        text = try? container.decode(String.self, forKey: .text)
        comments = try? container.decode(Comments.self, forKey: .comments)
        likes = try? container.decode(Likes.self, forKey: .likes)
        reposts = try? container.decode(Reposts.self, forKey: .reposts)
        photos = try? container.decode(Photos.self, forKey: .photos)
    }
}


// MARK: - Comments

struct Comments: BidirectionalMappable {
    
    let count: Int
    
    /// Can user post a comment
    let canPost: Int
}

extension Comments {
    enum DecodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        canPost = try container.decode(Int.self, forKey: .canPost)
    }
}


// MARK: - Likes

struct Likes: BidirectionalMappable {
    
    let count: Int
    
    /// Like from user
    let userLikes: Int
    
    /// Can user check "Like" mark
    let canLike: Int
    
    /// Can user repost
    let canPublish: Int
}

extension Likes {
    enum DecodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        userLikes = try container.decode(Int.self, forKey: .userLikes)
        canLike = try container.decode(Int.self, forKey: .canLike)
        canPublish = try container.decode(Int.self, forKey: .canPublish)
    }
}


// MARK: - Reposts

struct Reposts: BidirectionalMappable {
    
    let count: Int
    
    /// Repost from user
    let userReposted: Int
}

extension Reposts {
    enum DecodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        userReposted = try container.decode(Int.self, forKey: .userReposted)
    }
}

// MARK: - Rhotos

struct Photos: BidirectionalMappable {
    let count: Int
    let items: [Photo]
}
