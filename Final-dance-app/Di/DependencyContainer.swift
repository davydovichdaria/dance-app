//
//  DependencyContainer.swift
//  Final-dance-app
//
//  Created by Daria Davydovich on 6/25/23.
//

import Foundation

final class DependencyContainer {
    let screenFactory: ScreenFactoryImpl
    //let coordinatorFactory: CoordinatorFactoryImpl
    
    init() {
        screenFactory = ScreenFactoryImpl()
        //coordinatorFactory = CoordinatorFactoryImpl(screenFactory: screenFactory)
        
        screenFactory.di = self
    }
    
}
