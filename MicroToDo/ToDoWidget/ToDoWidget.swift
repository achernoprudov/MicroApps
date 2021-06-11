//
//  ToDoWidget.swift
//  ToDoWidget
//
//  Created by Andrey Chernoprudov on 10.06.2021.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> ListEntry {
        ListEntry(titles: [], configuration: ConfigurationIntent())
    }

    func getSnapshot(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (ListEntry) -> ()
    ) {
        let entry = ListEntry(titles: ["loading"], configuration: configuration)
        completion(entry)
    }

    func getTimeline(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (Timeline<Entry>) -> ()
    ) {
        let entries: [ListEntry] = [
            ListEntry(titles: ["foo", "bar"], configuration: configuration)
        ]
        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}

struct ListEntry: TimelineEntry {
    let titles: [String]
    let date = Date()
    let configuration: ConfigurationIntent
}

struct ToDoWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            AppBackground()
            
            if entry.titles.isEmpty {
                VStack(spacing: 10) {
                    Text("Add ToDo")
                    Image(systemName: "plus")
                }
                .padding()
            } else {
                VStack {
                    ForEach(entry.titles, id: \.description) { title in
                        HStack(alignment: .top) {
                            CheckBoxView(checked: false, onChecked: {})
                                .padding(.top, 2)
                            Text(title)
                                .lineLimit(2)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
    }
}

@main
struct ToDoWidget: Widget {
    let kind: String = "ToDoWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind,
            intent: ConfigurationIntent.self,
            provider: Provider()
        ) { entry in
            ToDoWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct ToDoWidget_Previews: PreviewProvider {
    static var previews: some View {
        ToDoWidgetEntryView(
            entry: ListEntry(
                titles: [
                    "buy milk for mike",
                    "find zoo",
                    "ca l",
//                    "ca l",
//                    "ca l",
//                    "ca l",
//                    "ca l",
//                    "ca l",
//                    "ca l",
//                    "ca l"
                ],
                configuration: ConfigurationIntent()
            )
        )
        .previewContext(WidgetPreviewContext(family: .systemSmall))
        .preferredColorScheme(.dark)
    }
}
