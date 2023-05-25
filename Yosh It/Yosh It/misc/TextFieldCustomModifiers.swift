//
//  TextFieldCustomModifiers.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-18.
//

import Foundation
import SwiftUI

struct TextFieldLimitModifer: ViewModifier {
    @Binding var value: String
    var length: Int

    func body(content: Content) -> some View {
        content
            .onReceive(value.publisher.collect()) { _ in
                if value.count > length {
                            value = String(value.prefix(length))
                }
            }
    }
}

struct TextFieldIntergerOnlyModifer: ViewModifier {
    @Binding var value: String

    func body(content: Content) -> some View {
        content
            .onReceive(value.publisher.collect()) { _ in
                let filtered = value.filter { "0123456789".contains($0) }
                if filtered != value {
                            value = filtered
                }
            }
    }
}


struct TextFieldDoubleOnlyModifer: ViewModifier {
    @Binding var value: String

    func body(content: Content) -> some View {
        content
            .onReceive(value.publisher.collect()) { _ in
                let filtered = value.filter { "0123456789.".contains($0) }
                let decimalFilter = value.filter{".".contains($0)}
                if filtered != value{
                            value = filtered
                }
                if decimalFilter.count==2{
                    value.removeLast()
                }
            }
    }
}




extension View {
    func limitInputLength(value: Binding<String>, length: Int) -> some View {
        self.modifier(TextFieldLimitModifer(value: value, length: length))
    }
    
    func intergerOnly(value: Binding<String>) -> some View {
        self.modifier(TextFieldIntergerOnlyModifer(value: value))
    }
    
    func doubleOnly(value: Binding<String>) -> some View {
        self.modifier(TextFieldDoubleOnlyModifer(value: value))
    }
    
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
