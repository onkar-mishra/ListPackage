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

    public var didSelectEmailAction: ((String) -> Void)? // Closure to handle email selection

    public init(didSelectEmailAction: ((String) -> Void)?) {
        self.didSelectEmailAction = didSelectEmailAction
    }

    public var body: some View {
        VStack {
            List(emails, id: \.self) { email in
                Text(email).foregroundColor(.orange)
            }
            
            Spacer()
            
            Button(action: {
                if let email = selectedEmail {
                    didSelectEmailAction?(email) // Call the closure to handle email selection
                }
            }) {
                Text("Return to App")
                    .padding()
            }
        }
        .padding()
        .onAppear {
            fetchData()
        }
    }

    private func fetchData() {
        AF.request("https://reqres.in/api/users?page=1").responseDecodable(of: UsersResponse.self) { response in
            switch response.result {
            case .success(let usersResponse):
                self.emails = usersResponse.data.compactMap { $0.email }
                self.selectedEmail = self.emails.first // Set the selectedEmail to the first email
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
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
