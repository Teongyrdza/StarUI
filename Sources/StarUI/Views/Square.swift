//
//  Square.swift
//  
//
//  Created by Ostap on 26.12.2020.
//

import SwiftUI

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public struct Square: Shape {
    public func path(in rect: CGRect) -> Path {
        let a = min(rect.size.width, rect.size.height)
        var path = Path()
        
        path.addRect(CGRect(x: rect.minX, y: rect.minY, width: a, height: a))
        
        return path
    }
    
    public init() {
        
    }
}

#if DEBUG
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
struct Square_Previews: PreviewProvider {
    static var previews: some View {
        Square()
            .fill(Color.red)
    }
}
#endif
