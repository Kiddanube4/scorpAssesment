//
//  Extensions.swift
//  scorpAssesment
//
//  Created by Namik Karabiyik on 31.03.2023.
//

import Foundation


extension Array {
    func unique<T: Hashable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        var set = Set<T>()
        return self.reduce(into: [Element]()) { result, value in
            guard !set.contains(value[keyPath: keyPath]) else {
                return
            }
            set.insert(value[keyPath: keyPath])
            result.append(value)
        }
    }
}
