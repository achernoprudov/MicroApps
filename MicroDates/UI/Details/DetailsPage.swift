//
//  DetailsPage.swift
//  MicroDates
//
//  Created by Andrey Chernoprudov on 20.12.2022.
//

import SwiftUI
import CoreData

struct DetailsPage: View {
  @Environment(\.managedObjectContext)
  private var viewContext
  
  let dateItemId: NSManagedObjectID
  
  var body: some View {
    VStack {
      Text("Hello, World!")
    }
  }
}

//struct DetailsPage_Previews: PreviewProvider {
//  static var previews: some View {
//    DetailsPage()
//      .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//  }
//}
