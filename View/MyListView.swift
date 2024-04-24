//
//  File.swift
//  MyListPackage
//
//  Created by Onkar Mishra on 24/04/24.
//

import Foundation
import SwiftUI
import Alamofire

public struct DemoView: View {
    @State private var emails: [String] = []

    public init() {}

    public var body: some View {
        VStack {
            List(emails, id: \.self) { email in
                Text(email)
            }
            Button(action: {
                self.fetchData()
            }) {
                Text("Fetch Data")
            }
        }
        .onAppear {
            self.fetchData()
        }
    }

    func fetchData(completion: @escaping (Result<[String], Error>) -> Void) {
        let url = "https://reqres.in/api/users?page=1"
        
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any], let dataArray = json["data"] as? [[String: Any]] {
                    let emails = dataArray.compactMap { $0["email"] as? String }
                    completion(.success(emails))
                } else {
                    completion(.failure(NSError(domain: "Parsing Error", code: 0, userInfo: nil)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

