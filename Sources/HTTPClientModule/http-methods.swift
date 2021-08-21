//
//  http-methods.swift
//  HTTPClientModule
//
//  Created by Cem Yilmaz on 20.08.21.
//

import Foundation

extension HTTPClient {
    // A selection of http methods
    public enum HttpMethod: String {
        case POST, PATCH, PUT, GET, DELETE, OPTIONS, HEAD, TRACE
    }
}
