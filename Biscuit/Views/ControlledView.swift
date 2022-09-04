//
//  File.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 09. 04..
//

import SwiftUI
import Combine

protocol ControlledView: View {
    associatedtype T: BiscuitController
    var controller: T { get }
}
