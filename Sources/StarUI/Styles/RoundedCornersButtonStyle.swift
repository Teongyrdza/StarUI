//
//  RoundedButtonStyle.swift
//  
//
//  Created by Ostap on 30.05.2021.
//

import SwiftUI

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public struct RoundedCornersButtonStyle: ButtonStyle {
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
    
    public init(lineWidth: CGFloat = 10, cornerRadius: CGFloat = 5) {
        self.lineWidth = lineWidth
        self.cornerRadius = cornerRadius
    }
}

#if DEBUG
@available(macOS 11, iOS 13, watchOS 6, tvOS 13, *)
struct RoundedButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("Press Me", action: {})
            .buttonStyle(RoundedCornersButtonStyle(lineWidth: 5, cornerRadius: 10))
            .accentColor(.purple)
            .frame(width: 75, height: 50)
    }
}
#endif
