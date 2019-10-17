//
//  ConnectionStatus.swift
//  myMovies
//
//  Created by Miguel Fernando Cuellar Gauna on 10/15/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import Foundation

class ConnectionStatus {
    static var shared = ConnectionStatus()
    var connected : Bool = false
    
    init() {
        connected = false
    }
}
