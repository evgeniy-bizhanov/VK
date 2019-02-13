//
//  PhotosRequestManager.swift
//  VK
//
//  Created by Евгений Бижанов on 09/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Alamofire

enum PhotoAlbumIdentifier: EnumIdentifiable {
    case wall
    case profile
    case saved
}

protocol PhotosRequestable {
    
    typealias Photos = Response<Photo>
    typealias Completion<T: Decodable> = (T) -> Void
    
    /// Gets list of photos
    ///
    /// - Parameter userId: User identifier
    func get<T>(forUser userId: String, albumId: PhotoAlbumIdentifier, completion: Completion<T>?)
    
    /// Gets specified numbers of photos
    ///
    /// - Parameter userId: User identifier
    /// - Parameter albumId: Photo album identifier that presented by `PhotoAlbumIdentifier`
    /// - Parameter count: Number of entries returned
    /// - Parameter offset: Return entries offset
    func get<T>(
        forUser userId: String,
        albumId: PhotoAlbumIdentifier,
        count: Int,
        offset: Int,
        completion: Completion<T>?
    )
}

final class PhotosRequestManager: PhotosRequestable {
    
    var requestManager: AbstractRequestManager!
    
    func get<T>(forUser userId: String, albumId: PhotoAlbumIdentifier, completion: Completion<T>?) {
        get(forUser: userId, albumId: albumId, count: 50, offset: 0, completion: completion)
    }
    
    func get<T>(
        forUser userId: String,
        albumId: PhotoAlbumIdentifier,
        count: Int,
        offset: Int,
        completion: Completion<T>?) {
        
        let urlRequest = GetRequestRouter(
            url: requestManager.url,
            ownerId: userId,
            albumId: albumId,
            count: count,
            offset: offset,
            token: requestManager.token ?? ""
        )
        
        requestManager.request(request: urlRequest, completion: completion)
    }
    
    init(requestManager: AbstractRequestManager?) {
        self.requestManager = requestManager
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
    let token: String
    
    var parameters: Parameters? {
        return [
            "owner_id": ownerId,
            "album_id": albumId.identifier,
            "extended": extended,
            "photo_sizes": photoSizes,
            "offset": offset,
            "count": count,
            "v": AppConfig.Api.version,
            "access_token": token
        ]
    }
}
