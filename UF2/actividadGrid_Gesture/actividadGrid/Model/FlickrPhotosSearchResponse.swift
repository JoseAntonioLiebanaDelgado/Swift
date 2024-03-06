//
//  FlickrPhotosSearchResponse.swift
//  actividadGrid
//
//  Created by alumne on 28/02/2024.
//

import Foundation

struct FlickrPhotosSearchResponse:Decodable{

    let photos:FlickrPhotos

    let stat:String

}

struct FlickrPhotos:Decodable{

    let page:Int

    let pages: Int

    let perpage : Int

    let total : Int

    let photo : [FlickrPhoto]

}

struct FlickrPhoto: Decodable{

    let id: String

    let owner: String

    let secret : String

    let server : String

    let farm : Int

    let title : String

    let ispublic : Int

    let isfriend : Int

    let isfamily : Int

    

    var imageURL:URL?{

            let baseURL = "https://live.staticflickr.com/%@/%@_%@_w.jpg"

            let urlString = String(format: baseURL, server, id, secret)

            return URL(string: urlString)

        }

}
