//
//  DetailsContainer.swift
//  MicroDates
//
//  Created by Andrey Chernoprudov on 20.12.2022.
//

import SwiftUI

struct DetailsContainer: View {
  @Binding
  var title: String
  @Binding
  var targetDate: Date
  @Binding
  var color: Color
  let creationDate: Date
  
  let onDelete: () -> Void
  
  var body: some View {
    VStack {
      TextField("Title", text: $title)
        .font(.title)
        .padding(.horizontal, 30)
        .padding(.vertical)
      
      List {
        DatePicker("Target date", selection: $targetDate, displayedComponents: .date)
        ColorPicker("Color", selection: $color, supportsOpacity: false)
        LabeledContent("Creation date") {
          Text(creationDate, formatter: itemFormatter)
        }
        
        Button("Delete", action: onDelete)
      }
    }
  }
}

private let itemFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .medium
  formatter.timeStyle = .none
  return formatter
}()


struct DetailsContainer_Previews: PreviewProvider {
  static var previews: some View {
    
    return DetailsContainer(
      title: .constant("Wife birthday"),
      targetDate: .constant(Date()),
      color: .constant(.blue),
      creationDate: Date(),
      onDelete: {}
    )
  }
}
