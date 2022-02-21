//
//  UITableView+Reusable.swift
//  OpenWeather
//
//  Created by Yang Yang on 19/2/22.
//

import UIKit

protocol Reusable {
    static var identifier: String { get }
}

extension Reusable {
    static var identifier: String { String(describing: self) }
}

extension UITableViewCell: Reusable {}
