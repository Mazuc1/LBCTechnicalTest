//
//  ContentState.swift
//  LBCTechnicalTest
//
//  Created by Loic Mazuc on 04/05/2023.
//

import Foundation

enum ContentState<Content> {
    case loading
    case error(Error)
    case loaded(Content)

    var content: Content? {
        switch self {
        case let .loaded(content): return content
        default: return nil
        }
    }

    func hasError() -> Bool {
        switch self {
        case .error: return true
        default: return false
        }
    }
}
