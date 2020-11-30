//
//  Extentions.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/11/30.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit

extension String {
    func safeDatabaseKey() -> String {
        return self.replacingOccurrences(of: "@", with: "-").replacingOccurrences(of: ".", with: "-")
    }
}
