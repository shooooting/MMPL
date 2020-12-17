//
//  RegistrationViewModel.swift
//  MoviePlayList
//
//  Created by ㅇ오ㅇ on 2020/12/17.
//  Copyright © 2020 shooooting. All rights reserved.
//

import Foundation

struct RegistrationViewModel: AuthenticationProtocol {
    var email: String?
    var password: String?
    var nickname: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
            && password?.isEmpty == false
            && nickname?.isEmpty == false
    }
    
    
}
