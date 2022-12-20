//
//  ListItemView.swift
//  MicroDates
//
//  Created by Andrey Chernoprudov on 20.12.2022.
//

import SwiftUI

struct ListItemView: View {
  let title: String
  let targetDate: Date
  let color: Color
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(title)
        .font(.title3)
        .bold()
      
      HStack {
        Text(targetDate, formatter: relativeFormatter)
        
        Spacer()
        
        Text(targetDate, formatter: dateFormatter)
      }
    }
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 10)
        .fill(color)
    )
  }
}

private let relativeFormatter: RelativeDateTimeFormatter = {
  let formatter = RelativeDateTimeFormatter()
  formatter.dateTimeStyle = .numeric
  formatter.unitsStyle = .full
  return formatter
}()


private let dateFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .short
  formatter.timeStyle = .none
  return formatter
}()

struct ListItemView_Previews: PreviewProvider {
  static var previews: some View {
    List {
      ListItemView(
        title: "My birthday",
        targetDate: Date(),
        color: .blue
      )
    }
    .listStyle(PlainListStyle())
  }
}
