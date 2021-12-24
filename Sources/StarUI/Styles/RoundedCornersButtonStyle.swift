//
//  RoundedButtonStyle.swift
//  
//
//  Created by Ostap on 30.05.2021.
//

import SwiftUI

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
struct BoundsPreferenceKey: PreferenceKey {
    typealias Value = CGRect
    
    static let defaultValue: Value = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
struct RoundedButton: View {
    @State var labelBounds = CGRect.zero
    
    let configuration: ButtonStyleConfiguration
    let lineWidth: CGFloat
    let cornerRadius: CGFloat
    let insets: RoundedButtonInsets
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(lineWidth: lineWidth)
                .frame(
                    width: labelBounds.width + insets.horizontal,
                    height: labelBounds.height + insets.vertical
                )
            
            configuration.label
                .background(
                    GeometryReader { geo in
                        Color.clear
                            .preference(
                                key: BoundsPreferenceKey.self,
                                value: geo.frame(in: .named("zStack"))
                            )
                    }
                )
        }
        .foregroundColor(.accentColor)
        .coordinateSpace(name: "zStack")
        .onPreferenceChange(BoundsPreferenceKey.self) { bounds in
            labelBounds = bounds
        }
    }
}

public struct RoundedButtonInsets {
    public var horizontal: CGFloat
    public var vertical: CGFloat
    
    public init(horizontal: CGFloat = 30, vertical: CGFloat = 25) {
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
        RoundedButton(
            configuration: configuration,
            lineWidth: lineWidth,
            cornerRadius: cornerRadius,
            insets: insets
        )
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
