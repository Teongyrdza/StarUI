//
//  CircularProgressViewStyle.swift
//  
//
//  Created by Ostap on 30.05.2021.
//

import SwiftUI

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension Color {
    static var backgroundColor: Color = .gray
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public extension View {
    func backgroundColor(_ backgroundColor: Color) {
        Color.backgroundColor = backgroundColor
    }
}


@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
struct Ring: InsettableShape {
    let startAngle: Angle
    let endAngle: Angle
    let clockwise: Bool
    let thickness: CGFloat
    var insets: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        let h = min(rect.height, rect.width) - insets
        let c = CGPoint(x: rect.midX, y: rect.midY)
        
        var path = Path()
        
        path.addArc(
            center: c,
            radius: h / 2,
            startAngle: .degrees(startAngle.degrees - 90),
            endAngle: .degrees(endAngle.degrees - 90),
            clockwise: clockwise
        )
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        return Ring(
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: clockwise,
            thickness: thickness,
            insets: amount
        )
    }
}

@available(macOS 11, iOS 14, watchOS 7, tvOS 14, *)
public struct CircularProgressViewStyle: ProgressViewStyle {
    public static let defaultThickness: CGFloat = 10
    
    public let thickness: CGFloat
    
    public func makeBody(configuration: Configuration) -> some View {
        VStack {
            if configuration.label != nil {
                Spacer()
            }
            
            configuration.label
            
            ZStack {
                // Background circle
                Ring(startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false, thickness: thickness)
                    .strokeBorder(
                        Color.backgroundColor,
                        style: .init(lineWidth: thickness, lineCap: .round, lineJoin: .round),
                        antialiased: true
                    )
                
                // Progress ring
                Ring(startAngle: .degrees(0), endAngle: .degrees(360 * (configuration.fractionCompleted ?? 0)), clockwise: false, thickness: thickness)
                    .strokeBorder(
                        style: .init(lineWidth: thickness, lineCap: .round, lineJoin: .round),
                        antialiased: true
                    )
            }
            
            if configuration.label != nil {
                Spacer()
            }
        }
    }
    
    public init(thickness: CGFloat = defaultThickness) {
        self.thickness = thickness
    }
}

@available(macOS 11, iOS 14, watchOS 7, tvOS 14, *)
public extension ProgressViewStyle where Self == CircularProgressViewStyle {
    static func circular(thickness: CGFloat = Self.defaultThickness) -> Self {
        .init(thickness: thickness)
    }
    
    static var circular: Self {
        circular()
    }
}

#if DEBUG
@available(macOS 12, iOS 15, watchOS 8, tvOS 15, *)
struct ProgressCircle_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView("Progress Circle", value: 75, total: 100)
            .progressViewStyle(.circular(thickness: 30))
            .padding()
            .foregroundStyle(
                .angularGradient(
                    colors: [.red, .orange, .yellow],
                    center: .center,
                    startAngle: .degrees(260),
                    endAngle: .degrees(-90)
                )
            )
    }
}
#endif
