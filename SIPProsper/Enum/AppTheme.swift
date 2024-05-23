//
//  AppTheme.swift
//  SIPProsper
//
//  Created by kintan on 23/05/24.
//

import Foundation

enum AppTheme: String, CaseIterable, Identifiable {
    case light
    case dark
    case system

    var id: String { self.rawValue }
}
