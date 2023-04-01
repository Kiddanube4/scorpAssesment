//
//  Protocols.swift
//  scorpAssesment
//
//  Created by Namik Karabiyik on 31.03.2023.
//

import Foundation


protocol HomeScreenViewModelDelegate {
    func fetch (_ didFail: FetchError)
    func fetch (_ didSucceed: [Person])
}
