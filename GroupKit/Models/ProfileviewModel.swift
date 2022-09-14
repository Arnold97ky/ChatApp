//
//  ProfileviewModel.swift
//  GroupKit
//
//  Created by Arnold Sylvestre on 8/19/22.
//

import Foundation

enum ProfileViewModelType {
    case info, logout
}

struct ProfileViewModel {
    let viewModelType: ProfileViewModelType
    let title: String
    let handler: (() -> Void)?
}

