//
//  RoundedButtonStyle.swift
//  
//
//  Created by Ostap on 30.05.2021.
//

import SwiftUI

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
struct BoundsPreferenceKey: PreferenceKey {
    typealias Value = Anchor<CGRect>?
    
    static let defaultValue: Value = nil
    
    static func reduce(value: inout Anchor<CGRect>?, nextValue: () -> Anchor<CGRect>?) {
        value = nextValue()
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
struct RoundedButton: View {
    let lineWidth: CGFloat
    let cornerRadius: CGFloat
    let configuration: ButtonStyleConfiguration
    
    var body: some View {
            configuration.label
                .anchorPreference(key: BoundsPreferenceKey.self, value: .bounds) {
                    $0
                }
                .backgroundPreferenceValue(BoundsPreferenceKey.self) { bounds in
                    GeometryReader { geo in
                        let label = geo[bounds!]
                        
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(lineWidth: lineWidth)
                            .position(x: label.midX, y: label.midY)
                            .frame(width: label.width + 20, height: label.height + 20)
                    }
                }
                .foregroundColor(.accentColor)
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public struct RoundedCornersButtonStyle: ButtonStyle {
    public static let defaultLineWidth: CGFloat = 10
    public static let defaultCornerRadius: CGFloat = 5
    
    public let lineWidth: CGFloat
    public let cornerRadius: CGFloat
    
    public func makeBody(configuration: Configuration) -> some View {
        RoundedButton(lineWidth: lineWidth, cornerRadius: cornerRadius, configuration: configuration)
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
    
    static var roundedCorners: Self {
        roundedCorners()
    }
}

#if DEBUG
@available(macOS 11, iOS 13, watchOS 6, tvOS 13, *)
struct RoundedButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button("Press Me", action: {})
                .buttonStyle(.roundedCorners(lineWidth: 5, cornerRadius: 10))
                .accentColor(.purple)
                .padding(.bottom, 50)
            
            Button("No, me!", action: {})
                .buttonStyle(.roundedCorners)
                .accentColor(.yellow)
        }
    }
}
#endif
