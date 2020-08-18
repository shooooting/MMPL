//
//  MovieList+CoreDataProperties.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/08/12.
//  Copyright © 2020 shooooting. All rights reserved.
//
//

import Foundation
import CoreData


extension MovieList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieList> {
        return NSFetchRequest<MovieList>(entityName: "MovieList")
    }

    @NSManaged public var link: String?
    @NSManaged public var listname: String?
    @NSManaged public var poster: String?
    @NSManaged public var title: String?

}
