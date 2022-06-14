//
//  ListPicker.swift
//  
//
//  Created by Ostap on 14.06.2022.
//

import SwiftUI

public struct ListPickerCell<Selection: Hashable>: View {
    let selected: Bool
    let label: String
    let action: () -> ()
    
    public var body: some View {
        Button(action: action) {
            Text(label)
                .foregroundColor(.primary)
        }
        .if(selected)
        .listRowBackground(Color.accentColor)
        .endif()
    }
    
    public struct Builder {
        @Binding var selection: Selection
        
        public func callAsFunction(value: Selection, label: String) -> some View {
            ListPickerCell(selected: selection == value, label: label) {
                selection = value
            }
        }
        
        public func callAsFunction(_ label: String, selected: Bool, action: @escaping () -> ()) -> some View {
            ListPickerCell(selected: selected, label: label, action: action)
        }
    }
}

public struct ListPicker<Selection: Hashable, Content: View>: View {
    public typealias Builder = ListPickerCell<Selection>.Builder
    
    @Binding var selection: Selection
    let content: (Builder) -> Content
    
    public var body: some View {
        List {
            content(Builder(selection: $selection))
        }
        .listStyle(.grouped)
    }
    
    public init(selection: Binding<Selection>, @ViewBuilder content: @escaping (Builder) -> Content) {
        _selection = selection
        self.content = content
    }
    
    public init(@ViewBuilder content: @escaping (Builder) -> Content) where Selection == Int {
        _selection = .constant(0)
        self.content = content
    }
}

#if DEBUG
@available(macOS 12, iOS 15, watchOS 8, tvOS 15, *)
struct SelectionPreview: View {
    @State var selection = "AMD"
    @State var laptop = false
    @State var desktop = true
    
    var body: some View {
        ListPicker(selection: $selection) { cell in
            Section("Choose your chipmaker") {
                ForEach(["Apple", "Intel", "AMD"], id: \.self) { chipmaker in
                    cell(value: chipmaker, label: chipmaker)
                }
            }
            
            Section("What computers do you use?") {
                cell("Mac Studio", selected: desktop && selection == "Apple") {
                    desktop.toggle()
                    selection = "Apple"
                }
                
                cell("MacBook Pro", selected: laptop && selection == "Apple") {
                    laptop.toggle()
                    selection = "Apple"
                }
                
                cell("Intel NUC", selected: desktop && selection == "Intel") {
                    desktop.toggle()
                    selection = "Intel"
                }
                
                cell("HP Probook 430 g3", selected: laptop && selection == "Intel") {
                    laptop.toggle()
                    selection = "Intel"
                }
                
                cell("64-Core AMD Threadripper + RTX 3090 Workstation", selected: desktop && selection == "AMD") {
                    desktop.toggle()
                    selection = "AMD"
                }
            }
        }
    }
}

@available(macOS 12, iOS 15, watchOS 8, tvOS 15, *)
struct ListPicker_Previews: PreviewProvider {
    static var previews: some View {
        SelectionPreview()
    }
}
#endif
