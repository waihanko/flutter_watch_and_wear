//
//  ContentView.swift
//  apple_watch Watch App
//
//  Created by Han Gyi on 13/03/2024.
//

import SwiftUI

struct ContentViewTest: View {
    @ObservedObject var session = WatchSessionDelegateTest()
    @State private var message = ""
    
    var body: some View {
        ScrollView {
            VStack {
                
                HStack{
                    TextField("Type a message", text: $message)
                        .padding()
                    
                    Button(action: {
                        session.sendMessage(message)
                    }) {
                        Image(systemName: "paperplane.fill")
                               .font(.system(size: 8))
                               .foregroundColor(.white)
                               .padding(10) // Add padding around the icon
                               .background(Color.blue) // Set background color for the button
                               .clipShape(Circle())
                    }
                }.buttonStyle(.borderless)

                
                Button("Refresh") {
                    session.refresh()
                }
                .padding()
                
                Text("Log \(session.log.count)")
                    .padding(.bottom)
                
                ForEach(session.log, id: \.self) { logEntry in
                    Text(logEntry)
                }
            }
        }
        .padding()
    }
}


struct ContentViewTest_Previews: PreviewProvider {
   static var previews: some View {
       ContentViewTest()
    }
}
