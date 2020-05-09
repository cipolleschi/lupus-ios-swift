//
//  JSONDictCodable.swift
//  Lupus
//
//  Created by Riccardo Cipolleschi on 09/05/2020.
//

import Foundation

protocol JSONDictCodable: Codable {
  init?(jsonInfo: [String: Any]) throws
  func jsonInfo() throws -> [String: Any]
}

enum JSONDictCodableError: Error {
  case invalidJSONObject(Data)
}

extension JSONDictCodable {
  init(jsonInfo: [String: Any]) throws {
    let data = try JSONSerialization.data(withJSONObject: jsonInfo, options: [])
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    self = try decoder.decode(Self.self, from: data)
  }

  func jsonInfo() throws -> [String: Any] {
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    let data = try encoder.encode(self)
    guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
      throw JSONDictCodableError.invalidJSONObject(data)
    }

    return dict
  }
}
