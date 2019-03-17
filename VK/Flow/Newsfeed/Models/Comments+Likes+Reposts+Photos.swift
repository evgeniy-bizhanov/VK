//
//  Comments+Likes+Reposts.swift
//  VK
//
//  Created by Евгений Бижанов on 17/03/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

// MARK: - Comments

struct VMComments: BidirectionalMappable {
    
    let count: Int
    
    /// Can user post a comment
    let canPost: Bool
}

extension VMComments {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        canPost = try container.decode(Int.self, forKey: .canPost) > 0
    }
}


// MARK: - Likes

struct VMLikes: BidirectionalMappable {
    
    let count: Int
    
    /// Like from user
    let userLikes: Bool
    
    /// Can user check "Like" mark
    let canLike: Bool
    
    /// Can user repost
    let canPublish: Bool
}

extension VMLikes {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        userLikes = try container.decode(Int.self, forKey: .userLikes) > 0
        canLike = try container.decode(Int.self, forKey: .canLike) > 0
        canPublish = try container.decode(Int.self, forKey: .canPublish) > 0
    }
}


// MARK: - Reposts

struct VMReposts: BidirectionalMappable {
    
    let count: Int
    
    /// Repost from user
    let userReposted: Bool
}

extension VMReposts {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        userReposted = try container.decode(Int.self, forKey: .userReposted) > 0
    }
}

// MARK: - Rhotos

struct VMPhotos: BidirectionalMappable {
    let count: Int
    let items: [Photo]
}
