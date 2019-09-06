//
//  AppStoreItem.swift
//  AppleSearch
//
//  Created by Lewis Jones on 08/11/2018.
//  Copyright © 2018 Rodrigo. All rights reserved.
//

import Foundation

struct AppStoreItem {
    let title: String
    let subtitle: String
    let imageURL: String?
    
    
    
    enum ItemType: String {
        case app = "software"
        case song = "musicTrack"
    }
}


extension AppStoreItem {
    init?(itemType: AppStoreItem.ItemType, dictionary: [String : Any]) {
       
        if itemType == .app {
            //build an app AppStoreItem
            guard let title = dictionary["trackName"] as? String, let subtitle = dictionary["description"] as? String else { return nil }
            let imageURL = dictionary["artworkUrl100"] as? String
            
            self.title = title
            self.subtitle = subtitle
            self.imageURL = imageURL
            
        } else if itemType == .song {
            //build a song AppStoreItem
            guard let title = dictionary["artistName"] as? String, let subtitle = dictionary["trackName"] as? String else { return nil }
            let imageURL = dictionary["artworkUrl100"] as? String
//            "artworkUrl60":"https://is5-ssl.mzstatic.com/image/thumb/Video/v4/85/2b/ed/852bedbc-6cbf-b4cd-dd31-26324e91c0f6/source/60x60bb.jpg",
            self.title = title
            self.subtitle = subtitle
            self.imageURL = imageURL
            
            
        } else {
            print("I Forgot to add availability for other types of items")
         return nil
        }
    }
}
