//
//  Core.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/08/17.
//  Copyright © 2020 shooooting. All rights reserved.
//

import Foundation
import CoreData

struct Person {
  var name: String
  var phoneNumber: String
  var shortcutNumber: Int
}
let zedd = Person(
  name: "Zedd",
  phoneNumber: "010-1234-5678",
  shortcutNumber: 1
)

let persistenceManager = PersistenceManager()
let context = persistenceManager.persistentContainer.viewContext
let entity = NSEntityDescription.entity(forEntityName: "MovieList", in: context)

let entity = entity {
  let person = NSManagedObject(entity: entity, insertInto: context)
  person.setValue(zedd.name, forKey: "name")
  person.setValue(zedd.phoneNumber, forKey: "phoneNumber")
  person.setValue(zedd.shortcutNumber, forKey: "shortcutNumber")
}
