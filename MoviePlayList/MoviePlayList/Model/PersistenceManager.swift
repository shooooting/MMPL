//
//  PersistenceManager.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/08/12.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit
import CoreData

class PersistenceManager {
  
  private init(){}
  static let shared = PersistenceManager()
  
//  var movieList = [MovieList]()
  
  // MARK: - Core Data stack
  
  lazy var persistentContainer: NSPersistentContainer = {

      let container = NSPersistentContainer(name: "CoreData")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
          if let error = error as NSError? {

              fatalError("Unresolved error \(error), \(error.userInfo)")
          }
      })
      return container
  }()
  
  lazy var context = persistentContainer.viewContext // saveContext안에 있던 변수를 밖으로 꺼냈다.
  
  // MARK: - Core Data Saving support

  func save() {
      if context.hasChanges {
          do {
              try context.save()
            print(context)
          } catch {

              let nserror = error as NSError
              fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
      }
  }

//   저장된 데이터를 가져오는 함수
//  func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
//      let entityName = String(describing: objectType)
//      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//
//      do {
//          let fetchedObjects = try context.fetch(fetchRequest) as? [T]
//          return fetchedObjects ?? [T]()
//      }
//      catch {
//          print(error)
//          return []
//      }
//  }

  //삭제 해주는 부분 삭제해줫으면 세이브도 해줘야 한다.
//  func delete(_ object: NSManagedObject) {
//      context.delete(object)
//      save()
//  }
//
//  //loadData
//  func loadMovieListData() {
//      let movieList = self.fetch(MovieList.self) // fetch 를 실행할 경우 array 의 형태로 값을 돌려받게 된다.
//      self.movieList = movieList
//
//    self.movieList.forEach {_ in
//
//      }
//  }
//
//  //Custom 메소드
//  func saveCustom(title: String, link: String, listname: String, poster: Data) {
//    let movieList = MovieList(context: self.context)
//    movieList.title = title
//    movieList.listname = listname
//    movieList.link = link
//    movieList.poster = poster
//    self.save()
//  }
}
