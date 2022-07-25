//
//  RequestMethod.swift
//  Biscuit
//
//  Created by Andras Olah on 2022. 07. 26..
//

enum RequestMethod: String, Codable {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
  case patch = "PATCH"
  case head = "HEAD"
  case unknown
}
