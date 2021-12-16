//
//  SingleRowTimePicker.swift
//  StarUI
//
//  Created by Ostap on 30.03.2021.
//

import SwiftUI

/// A single row time picker for small values (0 ~ 5 minutes)
/// Use it in narrow views
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public struct SingleRowTimePicker: View {
    @Binding private var selection: TimeInterval
    private let range: Range<Int>
    private let timeFormatter: (Int) -> String
    
    static func metric(forSeconds seconds: Int) -> String {
        return seconds == 1 ? "second" : "seconds"
    }
    
    static func metric(forMinutes minutes: Int) -> String {
        return minutes == 1 ? "minute" : "minutes"
    }
    
    static func label(for time: Int) -> String {
        if time < 60 {
            return "\(time) \(metric(forSeconds: time))"
        }
        else {
            let minutes = time / 60
            let seconds = time % 60
            
            return String(
                format: "%d %@ %02d %@",
                minutes, metric(forMinutes: minutes), seconds, metric(forSeconds: seconds)
            )
        }
    }
    
    public var body: some View {
        Picker("", selection: $selection) {
            ForEach(range) { time in
                Text(timeFormatter(time))
                    .tag(TimeInterval(time))
            }
        }
    }
    
    public init(selection: Binding<TimeInterval>, in range: Range<Int>) {
        self.init(selection: selection, in: range, timeFormatter: Self.label(for:))
    }
    
    public init(
        selection: Binding<TimeInterval>,
        in range: Range<Int>,
        timeFormatter: @escaping (Int) -> String
    ) {
        self._selection = selection
        self.range = range
        self.timeFormatter = timeFormatter
    }
    
    public init(
        selection: Binding<TimeInterval>,
        in range: Range<Int>,
        timeFormatter: @escaping (TimeInterval) -> String
    ) {
        self.init(selection: selection, in: range) { (time: Int) in
            timeFormatter(TimeInterval(time))
        }
    }
}

#if DEBUG
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
struct SingleRowTimePicker_Previews: PreviewProvider {
    @State static var selection: TimeInterval = 45
    
    static var previews: some View {
        SingleRowTimePicker(selection: $selection, in: 1..<181)
            .pickerStyle(.wheel)
    }
}
#endif
