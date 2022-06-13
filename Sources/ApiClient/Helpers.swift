//
//  File.swift
//  
//
//  Created by Roberto Casula on 05/06/22.
//

#if DEBUG
import Foundation

public func ok<A: Encodable>(
    _ value: A,
    encoder: JSONEncoder = encoder
) -> (value: Data, response: URLResponse) {
    (
        try! encoder.encode(value),
        HTTPURLResponse(
            url: URL(string: "/")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    )
}

public func ok(
    _ jsonObject: Any
) -> (value: Data, response: URLResponse) {
    (
        try! JSONSerialization.data(withJSONObject: jsonObject, options: []),
        HTTPURLResponse(
            url: URL(string: "/")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    )
}
#endif
