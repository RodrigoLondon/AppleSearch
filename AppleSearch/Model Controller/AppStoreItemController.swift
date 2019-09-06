//
//  AppStoreItemController.swift
//  AppleSearch
//
//  Created by Lewis Jones on 08/11/2018.
//  Copyright © 2018 Rodrigo. All rights reserved.
//

import Foundation
import UIKit


class AppStoreItemController {
    
    static func getItemsOf(type: AppStoreItem.ItemType, searchText: String, completion: @escaping (([AppStoreItem]) -> Void)) {
        let baseURL = URL(string: "https://itunes.apple.com/search")!
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            print("Our URL is not working.")
            completion([])
            return
        }
        
        let searchTermQuery = URLQueryItem(name: "term", value: searchText)
        let entityQuery = URLQueryItem(name: "entity", value: type.rawValue)
        components.queryItems = [searchTermQuery, entityQuery]
        
        guard let url = components.url else {
            print("Our query items are causing trouble.")
            completion([])
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error getting stuff back from Apple: \(error.localizedDescription).")
                completion([])
                return
            }
            guard let data = data else {
                print("No data was received from Apple.")
                completion([])
                return
            }
            guard let topLevelJSON = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String : Any] else {
                print("Could not convert data into JSON.")
                completion([])
                return
            }
            guard let appStoreItemDictionaries = topLevelJSON["results"] as? [[String : Any]] else {
                print("Could not get dictionaries from the results.")
                completion([])
                return
            }
            var allItems: [AppStoreItem] = []
            
            for itemDictionary in appStoreItemDictionaries {
                if let newItem = AppStoreItem(itemType: type, dictionary: itemDictionary) {
                    allItems.append(newItem)
                }
            }
            completion(allItems)
        }
        dataTask.resume()
    }
    
    static func getImageFor(item: AppStoreItem, completion: @escaping ((UIImage?) -> Void)) {
        guard let imageURLAsString = item.imageURL,
            let url = URL(string: imageURLAsString) else {
                print("Item did'nt have an image that could be made into a url.")
                completion(nil)
                return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("Could not get data back from image.")
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        } .resume()
    }
}
