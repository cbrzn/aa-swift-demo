//
//  Connect.swift
//  account-abstraction-demo
//
//  Created by Cesar Brazon on 26/3/23.
//

import SwiftUI

struct Connect: View {
    var body: some View {
        HStack {
            
            
            Button {
                connect()
            } label: {
                Text("Connect")
            }
        }
        
    }
    
    func connect() {
        
    }
}

struct Connect_Previews: PreviewProvider {
    static var previews: some View {
        Connect()
    }
}
