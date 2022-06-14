//
//  VisualEffectView.swift
//  
//
//  Created by Ostap on 03.06.2021.
//

import SwiftUI

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

public enum VisualEffect: Equatable, Hashable {
    case light, dark
}


#if os(iOS)
extension VisualEffect {
    var parameters: UIVisualEffect { UIBlurEffect(style: self.blurStyle) }
    
    var blurStyle: UIBlurEffect.Style {
        switch self {
            case .light:
                return .light
            case .dark:
                return .dark
        }
    }
}
#elseif os(macOS)
@available(macOS 10.14, *)
extension VisualEffect {
    struct NSEffectParameters {
        var material: NSVisualEffectView.Material = .contentBackground
        var blendingMode: NSVisualEffectView.BlendingMode = .behindWindow
        var appearance: NSAppearance? = nil
    }
    
    var material: NSVisualEffectView.Material {
        .contentBackground
    }

    var blendingMode: NSVisualEffectView.BlendingMode {
        .withinWindow
    }

    var parameters: NSEffectParameters {
        switch self {
            case .light:
                return NSEffectParameters(appearance: NSAppearance(named: .aqua))
            case .dark:
                return NSEffectParameters(appearance: NSAppearance(named: .darkAqua))
        }
    }
}
#endif

#if os(iOS)
@available(iOS 13, tvOS 13, *)
public struct VisualEffectView: UIViewRepresentable {
    public var visualEffect: VisualEffect?
    
    public func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        UIVisualEffectView()
    }
    
    public func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = visualEffect?.parameters
    }
    
    public init(visualEffect: VisualEffect?) {
        self.visualEffect = visualEffect
    }
}
#elseif os(macOS)
@available(macOS 10.15, *)
public struct VisualEffectView: NSViewRepresentable {
    public var visualEffect: VisualEffect?
    
    public func makeNSView(context: NSViewRepresentableContext<Self>) -> NSVisualEffectView {
        NSVisualEffectView()
    }
    
    public func updateNSView(_ nsView: NSVisualEffectView, context: NSViewRepresentableContext<Self>) {
        let params = visualEffect!.parameters
        nsView.material = params.material
        nsView.blendingMode = params.blendingMode
        nsView.appearance = params.appearance
    }
    
    public init(visualEffect: VisualEffect?) {
        self.visualEffect = visualEffect
    }
}
#endif

#if DEBUG
@available(iOS 13, macOS 10.15, tvOS 13, *)
struct VisualEffectView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red)
            
            VisualEffectView(visualEffect: .dark)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
#endif

