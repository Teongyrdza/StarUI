//
//  SwiftUIView.swift
//  
//
//  Created by Ostap on 30.05.2021.
//

import SwiftUI

@available(macOS 11, iOS 13, watchOS 6, tvOS 13, *)
public struct CheckmarkToggleStyle: ToggleStyle {
    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Rectangle()
                .foregroundColor(configuration.isOn ? .green : .gray)
                .frame(width: 51, height: 31, alignment: .center)
                .overlay(
                    Circle()
                        .foregroundColor(.white)
                        .padding(.all, 3)
                        .overlay(
                            Image(systemName: configuration.isOn ? "checkmark" : "xmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .font(Font.title.weight(.black))
                                .frame(width: 8, height: 8, alignment: .center)
                                .foregroundColor(configuration.isOn ? .green : .gray)
                        )
                        .offset(x: configuration.isOn ? 11 : -11, y: 0)
                        .animation(Animation.linear(duration: 0.1))
                        
                )
                .cornerRadius(20)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
    
    public init() {
        
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public struct PowerToggleStyle: ToggleStyle {
    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Rectangle()
                .foregroundColor(configuration.isOn ? .green : .gray)
                .frame(width: 51, height: 31, alignment: .center)
                .overlay(
                    Circle()
                        .foregroundColor(.white)
                        .padding(.all, 3)
                        .overlay(
                            GeometryReader { geo in
                                Path { p in
                                    if !configuration.isOn {
                                        let center = CGPoint(x: 25, y: 15)
                                        p.addArc(
                                            center: center,
                                            radius: 7.5,
                                            startAngle: .degrees(0),
                                            endAngle: .degrees(360),
                                            clockwise: true
                                        )
                                    } else {
                                        p.move(to: CGPoint(x: 51/2, y: 10))
                                        p.addLine(to: CGPoint(x: 51/2, y: 31-10))
                                    }
                                }.stroke(configuration.isOn ? Color.green : Color.gray, lineWidth: 2)
                            }
                        )
                        .offset(x: configuration.isOn ? 11 : -11, y: 0)
                        .animation(Animation.linear(duration: 0.1))
                        
                )
                .cornerRadius(20)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
    
    public init() {
        
    }
}

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public struct ImageToggleStyle: ToggleStyle {
    public var onImageName: String
    public var offImageName: String
    
    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Image(configuration.isOn ? onImageName : offImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 51, height: 31, alignment: .center)
                .overlay(
                    Circle()
                        .foregroundColor(.white)
                        .padding(.all, 3)
                        .offset(x: configuration.isOn ? 11 : -11, y: 0)
                        .animation(Animation.linear(duration: 0.1))
                )
                .cornerRadius(20)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
    
    public init(onImageName: String, offImageName: String) {
        self.onImageName = onImageName
        self.offImageName = offImageName
    }
}

@available(macOS 11, iOS 13, watchOS 6, tvOS 13, *)
struct CustomToggles: View {
    @State var isOn = true
    
    var body: some View {
        VStack {
            Toggle(isOn: $isOn) {
                Text("Checkmark Toggle Style")
            }
            .toggleStyle(CheckmarkToggleStyle())
            
            Toggle(isOn: $isOn) {
                Text("Power Toggle Style")
            }
            .toggleStyle(PowerToggleStyle())
            
            /*
            Toggle(isOn: $isOn) {
                Text("Image Toggle Style")
            }
            .toggleStyle(ImageToggleStyle(onImageName: "Sun", offImageName: "Night"))
            */
        }
        .padding()
    }
}

@available(macOS 11, iOS 13, watchOS 6, tvOS 13, *)
struct CustomToggle_Previews: PreviewProvider {
    static var previews: some View {
        CustomToggles()
    }
}
