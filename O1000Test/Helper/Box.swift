//
//  Box.swift
//  O1000Test
//
//  Created by Kuziboev Siddikjon on 07/10/23.
//

import Foundation

final class Box<T> {
    
    typealias Listener = (T) -> Void
  
    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }
    
  
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
