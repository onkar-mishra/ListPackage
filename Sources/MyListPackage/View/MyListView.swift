//
//  File.swift
//  MyListPackage
//
//  Created by Onkar Mishra on 24/04/24.
//

import Foundation
import SwiftUI


//MARK: VIEW

@available(iOS 13.0, *)
public struct ListView: View {
    @State private var emails: [String] = ["nsaljncnla","fcsncwnclowncl","csnclnwqncnkjlc","cnalksndcnsjkncj"]
    
    public init(email: [String]) {
        emails = email
    }
    
    public var body: some View {
        VStack {
            List(emails, id: \.self) { email in
                Text(email).foregroundColor(.orange)
            }
        }
    }
}

