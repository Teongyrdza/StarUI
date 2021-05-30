//
//  SwiftUIView.swift
//  
//
//  Created by Ostap on 30.05.2021.
//

import SwiftUI

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public struct RoundedButtonStyle: ButtonStyle {
    public let lineWidth: CGFloat
    public let cornerRadius: CGFloat
    
    public func makeBody(configuration: Configuration) -> some View {
        ZStack {
            configuration.label
                .foregroundColor(.accentColor)
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.accentColor, lineWidth: lineWidth)
        }
    }
}

#if DEBUG
@available(macOS 11, iOS 13, watchOS 6, tvOS 13, *)
struct RoundedButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("Press Me", action: {})
            .buttonStyle(RoundedButtonStyle(lineWidth: 5, cornerRadius: 10))
            .accentColor(.purple)
            .frame(width: 75, height: 50)
    }
}
#endif
