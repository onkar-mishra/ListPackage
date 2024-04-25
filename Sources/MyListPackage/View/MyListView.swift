//
//  File.swift
//  MyListPackage
//
//  Created by Onkar Mishra on 24/04/24.
//

import SwiftUI
import Alamofire

@available(iOS 13.0, *)
public struct ListView: View {
    @State private var emails: [String] = []
    @State private var selectedEmail: String?
    @State private var isLoading: Bool = false // State variable to track loading status
    
    public init() {}
    
    public var body: some View {
        VStack {
            List(emails, id: \.self) { email in
                Text(email).foregroundColor(.orange)
            }
            
            Button(action: {
                fetchData()
            }) {
                Text("Load Data")
            }
            .disabled(isLoading) // Disable the button while loading
            
            if isLoading {
                HStack {
                    Spacer()
                    Text("Loading...")
                    Spacer()
                }
            }
            
            if let selectedEmail = selectedEmail {
                Text("Selected Email: \(selectedEmail)")
            }
        }
        .onAppear {
            fetchData()
        }
    }
    
    private func fetchData() {
        isLoading = true // Start loading
        AF.request("https://reqres.in/api/users?page=1").responseDecodable(of: UsersResponse.self) { response in
            switch response.result {
            case .success(let usersResponse):
                self.emails = usersResponse.data.compactMap { $0.email }
                self.selectedEmail = usersResponse.data.first?.email
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
            isLoading = false // Stop loading
        }
    }
}

struct UsersResponse: Decodable {
    let data: [User]
}

struct User: Decodable {
    let email: String
    // Add other properties if needed
}
