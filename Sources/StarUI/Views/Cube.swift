//
//  Cube.swift
//  
//
//  Created by Ostap on 26.12.2020.
//

import SwiftUI

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public struct Cube: View {
    public let size: CGFloat
    
    public var body: some View {
        Square().frame(height: size)
            .modifier(
                ExtrudedModifier(
                    depth: size,
                    texture: Square().frame(height: size)
                )
            )
            .modifier(IsometricViewModifier())
    }
    
    public init(size: CGFloat) {
        self.size = size
    }
}


#if DEBUG
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
struct Cube_Previews: PreviewProvider {
    static var previews: some View {
        Cube(size: 300)
            .foregroundColor(.red)
    }
}
#endif
