//
//  RoundedButtonStyle.swift
//  
//
//  Created by Ostap on 30.05.2021.
//

import SwiftUI

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public struct RoundedCornersButtonStyle: ButtonStyle {
    public static let defaultLineWidth: CGFloat = 10
    public static let defaultCornerRadius: CGFloat = 5
    
    public let lineWidth: CGFloat
    public let cornerRadius: CGFloat
    
    public func makeBody(configuration: Configuration) -> some View {
        ZStack {
            configuration.label
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(lineWidth: lineWidth)
        }
        .foregroundColor(.accentColor)
    }
    
    public init(lineWidth: CGFloat = defaultLineWidth, cornerRadius: CGFloat = defaultCornerRadius) {
        self.lineWidth = lineWidth
        self.cornerRadius = cornerRadius
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension ButtonStyle where Self == RoundedCornersButtonStyle {
    static func roundedCorners(
        lineWidth: CGFloat = Self.defaultLineWidth,
        cornerRadius: CGFloat = Self.defaultCornerRadius
    ) -> Self {
        .init(lineWidth: lineWidth, cornerRadius: cornerRadius)
    }
}

#if DEBUG
@available(macOS 11, iOS 13, watchOS 6, tvOS 13, *)
struct RoundedButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("Press Me", action: {})
            .buttonStyle(.roundedCorners(lineWidth: 5, cornerRadius: 10))
            .accentColor(.purple)
            .frame(width: 75, height: 50)
    }
}
#endif
