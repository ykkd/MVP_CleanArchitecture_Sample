//
//  View+.swift
//  
//
//  Created by ykkd on 2023/06/15.
//

import SwiftUI
import SharedPresentation

extension View {

    @ViewBuilder
    public func when(
        _ condition: Bool,
        @ViewBuilder transform: (Self) -> some View
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

extension View {

    @ViewBuilder
    public func errorAlert(error: Binding<PresentationError?>) -> some View {
        alert(isPresented: .constant(error.wrappedValue != nil), error: error.wrappedValue?.value) { _ in
            Button("OK") {
                error.wrappedValue = nil
            }
            if let action = error.wrappedValue?.retryAction {
                Button("Retry") {
                    Task {
                        await action()
                    }
                }
            }
        } message: { error in
            Text(error.recoverySuggestion ?? "")
        }
    }
}
