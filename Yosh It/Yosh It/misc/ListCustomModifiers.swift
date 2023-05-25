//
//  ListCustomModifiers.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-24.
//

import Foundation
import SwiftUI

struct ClearListBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.scrollContentBackground(.hidden)
        } else {
            content
        }
    }
}

extension View {
    func clearListBackground() -> some View {
        modifier(ClearListBackgroundModifier())
    }
}
