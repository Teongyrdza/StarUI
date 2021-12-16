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

public struct RoundedButtonInsets {
    public var horizontal: CGFloat
    public var vertical: CGFloat
    
    public init(horizontal: CGFloat = 30, vertical: CGFloat = 20) {
        self.horizontal = horizontal
        self.vertical = vertical
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public struct RoundedCornersButtonStyle: ButtonStyle {
    public static let defaultLineWidth: CGFloat = 10
    public static let defaultCornerRadius: CGFloat = 5
    
    public let lineWidth: CGFloat
    public let cornerRadius: CGFloat
    public let insets: RoundedButtonInsets
    
    public func makeBody(configuration: Configuration) -> some View {
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
                        .frame(
                            width: label.width + insets.horizontal + cornerRadius,
                            height: label.height + insets.vertical  + cornerRadius
                        )
                }
            }
            .foregroundColor(.accentColor)
    }
    
    public init(
        lineWidth: CGFloat = defaultLineWidth,
        cornerRadius: CGFloat = defaultCornerRadius,
        insets: RoundedButtonInsets = .init()
    ) {
        self.lineWidth = lineWidth
        self.cornerRadius = cornerRadius
        self.insets = insets
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension ButtonStyle where Self == RoundedCornersButtonStyle {
    static func roundedCorners(
        lineWidth: CGFloat = Self.defaultLineWidth,
        cornerRadius: CGFloat = Self.defaultCornerRadius,
        insets: RoundedButtonInsets = .init()
    ) -> Self {
        .init(lineWidth: lineWidth, cornerRadius: cornerRadius, insets: insets)
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
                .buttonStyle(.roundedCorners(insets: .init(horizontal: 50, vertical: 35)))
                .accentColor(.yellow)
        }
    }
}
#endif
