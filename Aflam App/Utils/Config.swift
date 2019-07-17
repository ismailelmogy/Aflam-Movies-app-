//
//  Config.swift
//  Movies App
//
//  Created by Esraa Hassan on 7/9/19.
//  Copyright © 2019 Developers. All rights reserved.
//

import Foundation

struct  URLS {
    
    static let CREATE_TOKEN_URL = "https://api.themoviedb.org/3/authentication/token/new?api_key=a6b36328e027adf7d2cf115046c6dd11"
    
    static let CREATE_SESSION_ID_URL = "https://api.themoviedb.org/3/authentication/session/new?api_key=a6b36328e027adf7d2cf115046c6dd11"
    
    static let ACCOUNT_INFROMATION_URL = "https://api.themoviedb.org/3/account?api_key=a6b36328e027adf7d2cf115046c6dd11"
    
    static let LOGIN_URL = "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=a6b36328e027adf7d2cf115046c6dd11"
    
    static let TOP_RATED_URL = "https://api.themoviedb.org/3/movie/top_rated?api_key=a6b36328e027adf7d2cf115046c6dd11"
    
    static let POPULAR_URL = "https://api.themoviedb.org/3/movie/popular?api_key=1b5062dd05eaace07a10010e59798def"
    
    static let IMAGE_URL = "https://image.tmdb.org/t/p/w185/"
    static let BASE_GRAVATAR_URL = "https://www.gravatar.com/avatar/"
}
