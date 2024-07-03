//
//  FCError.swift
//  FetchChallenge
//
//  Created by Daniel Berezhnoy on 6/28/24.
//

import Foundation

/// FetchChallenge Error
enum FCError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}
