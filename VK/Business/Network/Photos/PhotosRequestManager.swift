//
//  PhotosRequestManager.swift
//  VK
//
//  Created by Евгений Бижанов on 09/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Alamofire

enum PhotoAlbumIdentifier: Identifiable {
    case wall
    case profile
    case saved
}

protocol PhotosRequestManager: AbstractRequestManager {
    
    typealias Photos = Response<Photo>
    
    /// Gets list of photos
    ///
    /// - Parameter userId: User identifier
    func get(forUser userId: String, albumId: PhotoAlbumIdentifier, completion: @escaping Completion<Photos>)
    
    /// Gets specified numbers of photos
    ///
    /// - Parameter userId: User identifier
    /// - Parameter albumId: Photo album identifier that presented by `PhotoAlbumIdentifier`
    /// - Parameter count: Number of entries returned
    /// - Parameter offset: Return entries offset
    func get(
        forUser userId: String,
        albumId: PhotoAlbumIdentifier,
        count: Int,
        offset: Int,
        completion: @escaping Completion<Photos>
    )
}

extension RequestManager: PhotosRequestManager {
    
    func get(forUser userId: String, albumId: PhotoAlbumIdentifier, completion: @escaping Completion<Photos>) {
        get(forUser: userId, albumId: albumId, count: 50, offset: 0, completion: completion)
    }
    
    func get(
        forUser userId: String,
        albumId: PhotoAlbumIdentifier,
        count: Int,
        offset: Int,
        completion: @escaping Completion<Photos>) {
        
        let urlRequest = GetRequestRouter(
            url: url,
            ownerId: userId,
            albumId: albumId,
            count: count,
            offset: offset,
            token: token
        )
        
        self.request(request: urlRequest, completion: completion)
    }
}


// MARK: - RequestRouter

fileprivate struct GetRequestRouter: RequestRouter {
    
    let url: URL
    let httpMethod: HTTPMethod = .get
    let apiMethod: String = "/photos.get"
    
    let ownerId: String
    let albumId: PhotoAlbumIdentifier
    let photoSizes = 1
    let extended = 1
    let count: Int
    let offset: Int
    let token: String?
    
    var parameters: Parameters? {
        return [
            "owner_id": ownerId,
            "album_id": albumId.identifier,
            "extended": extended,
            "photo_sizes": photoSizes,
            "offset": offset,
            "count": count,
            "v": AppConfig.Api.version,
            "access_token": token ?? ""
        ]
    }
}
