//
//  DetailsContainer.swift
//  MicroDates
//
//  Created by Andrey Chernoprudov on 20.12.2022.
//

import SwiftUI
import CoreData

struct DetailsContainer: View {
  let dateItem: DateItem
  
  @State
  var date = Date()
  @State
  var color = Color.blue
  @State
  var title = "New title"
  
  
  var body: some View {
    VStack {
      TextField("Title", text: $title)
        .font(.title)
        .padding(.horizontal, 30)
      
      List {
        DatePicker("Target date", selection: $date, displayedComponents: .date)
        ColorPicker("Color", selection: $color, supportsOpacity: false)
        Text(dateItem.creationDate, formatter: DateFormatter())
      }
    }
  }
}

struct DetailsContainer_Previews: PreviewProvider {
  static var previews: some View {
    let items = try! DateItem.fetchAll(with: PersistenceController.preview.container.viewContext)
    
    return DetailsContainer(dateItem: items.first!)
  }
}
