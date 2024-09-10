//
//  NavigationCoordinator.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import SwiftUI

@Observable
class NavigationCoordinator {
    var paths = NavigationPath()
    
    // add screen
    func push(_ screen: String) {
        paths.append(screen)
    }
    
    // remove last screen
    func pop() {
        paths.removeLast()
    }
    
    // go to root screen
    func popToRoot() {
        paths.removeLast(paths.count)
    }
}
