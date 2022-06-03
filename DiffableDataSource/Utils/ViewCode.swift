//
//  ViewCode.swift
//  DiffableDataSource
//
// 
//

import Foundation

protocol ViewCode {
    func buildViewHierarchy()
    func addConstraints()
    func additionalConfiguration()
    func setup()
}

extension ViewCode {
    func setup() {
        buildViewHierarchy()
        addConstraints()
    }
    
    func additionalConfiguration() { }
    
}
