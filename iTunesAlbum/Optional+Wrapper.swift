//
//  Optional+Wrapper.swift
//  iTunesAlbum
//
//  Created by Priyanka Saroha on 10/27/18.
//  Copyright © 2018 Priyanka Saroha. All rights reserved.
//

import Foundation

extension Optional {
    func wrappedString()-> String {
        if let value =  self {
            if value is String {
                return value as! String
            }
        }
        return ""
    }
    
    func wrappedFloat()-> Float {
        if let value =  self {
            if value is Float {
                return value as! Float
            }
        }
        return 0
    }
}
