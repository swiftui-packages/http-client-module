//
//  HTTPClient.swift
//  HTTPClientModule
//
//  Created by Cem Yilmaz on 20.08.21.
//

import Foundation

public class HTTPClient {
    /// A plain http request with the method GET
    public static func get(
        url urlString: String,
        printResponse: Bool = false,
        headers: [(key: String, value: String)] = [],
        beforeRequest: @escaping () -> Void = {},
        response: @escaping (_ response: (status: ResponseStatus, body: Data)) -> Void,
        afterResponse: @escaping () -> Void = {}
    ) {
        self.request(
            url: urlString,
            httpMethod: HttpMethod.GET,
            printResponse: printResponse,
            headers: headers,
            body: Data(),
            beforeRequest: beforeRequest,
            response: response,
            afterResponse: afterResponse
        )
    }

    /// An http request with the method POST, which submits an encodable object
    public static func post<T: Encodable>(
        url urlString: String,
        printResponse: Bool = false,
        headers: [(key: String, value: String)] = [],
        body: T,
        beforeRequest: @escaping () -> Void = {},
        response: @escaping (_ response: (status: ResponseStatus, body: Data)) -> Void,
        afterResponse: @escaping () -> Void = {}
    ) {
        self.request(
            url: urlString,
            httpMethod: HttpMethod.POST,
            printResponse: printResponse,
            headers: headers,
            body: body,
            beforeRequest: beforeRequest,
            response: response,
            afterResponse: afterResponse
        )
    }

    /// A plain http request with the method POST
    public static func post(
        url urlString: String,
        printResponse: Bool = false,
        headers: [(key: String, value: String)] = [],
        body: Data = Data(),
        beforeRequest: @escaping () -> Void = {},
        response: @escaping (_ response: (status: ResponseStatus, body: Data)) -> Void,
        afterResponse: @escaping () -> Void = {}
    ) {
        self.request(
            url: urlString,
            httpMethod: HttpMethod.POST,
            printResponse: printResponse,
            headers: headers,
            body: body,
            beforeRequest: beforeRequest,
            response: response,
            afterResponse: afterResponse
        )
    }

    /// An http request with the method PATCH, which submits an encodable object
    public static func patch<T: Encodable>(
        url urlString: String,
        printResponse: Bool = false,
        headers: [(key: String, value: String)] = [],
        body: T,
        beforeRequest: @escaping () -> Void = {},
        response: @escaping (_ response: (status: ResponseStatus, body: Data)) -> Void,
        afterResponse: @escaping () -> Void = {}
    ) {
        self.request(
            url: urlString,
            httpMethod: HttpMethod.PATCH,
            printResponse: printResponse,
            headers: headers,
            body: body,
            beforeRequest: beforeRequest,
            response: response,
            afterResponse: afterResponse
        )
    }

    /// A plain http request with the method PATCH
    public static func patch(
        url urlString: String,
        printResponse: Bool = false,
        headers: [(key: String, value: String)] = [],
        body: Data,
        beforeRequest: @escaping () -> Void = {},
        response: @escaping (_ response: (status: ResponseStatus, body: Data)) -> Void,
        afterResponse: @escaping () -> Void = {}
    ) {
        self.request(
            url: urlString,
            httpMethod: HttpMethod.PATCH,
            printResponse: printResponse,
            headers: headers,
            body: body,
            beforeRequest: beforeRequest,
            response: response,
            afterResponse: afterResponse
        )
    }

    /// An http request with the method PUT, which submits an encodable object
    public static func put<T: Encodable>(
        url urlString: String,
        printResponse: Bool = false,
        headers: [(key: String, value: String)] = [],
        body: T,
        beforeRequest: @escaping () -> Void = {},
        response: @escaping (_ response: (status: ResponseStatus, body: Data)) -> Void,
        afterResponse: @escaping () -> Void = {}
    ) {
        self.request(
            url: urlString,
            httpMethod: HttpMethod.PUT,
            printResponse: printResponse,
            headers: headers,
            body: body,
            beforeRequest: beforeRequest,
            response: response,
            afterResponse: afterResponse
        )
    }

    /// A plain http request with the method PUT
    public static func put(
        url urlString: String,
        printResponse: Bool = false,
        headers: [(key: String, value: String)] = [],
        body: Data,
        beforeRequest: @escaping () -> Void = {},
        response: @escaping (_ response: (status: ResponseStatus, body: Data)) -> Void,
        afterResponse: @escaping () -> Void = {}
    ) {
        self.request(
            url: urlString,
            httpMethod: HttpMethod.PUT,
            printResponse: printResponse,
            headers: headers,
            body: body,
            beforeRequest: beforeRequest,
            response: response,
            afterResponse: afterResponse
        )
    }

    /// An http request with the method DELETE, which submits an encodable object
    public static func delete<T: Encodable>(
        url urlString: String,
        printResponse: Bool = false,
        headers: [(key: String, value: String)] = [],
        body: T,
        beforeRequest: @escaping () -> Void = {},
        response: @escaping (_ response: (status: ResponseStatus, body: Data)) -> Void,
        afterResponse: @escaping () -> Void = {}
    ) {
        self.request(
            url: urlString,
            httpMethod: HttpMethod.DELETE,
            printResponse: printResponse,
            headers: headers,
            body: body,
            beforeRequest: beforeRequest,
            response: response,
            afterResponse: afterResponse
        )
    }

    /// A plain http request with the method DELETE
    public static func delete(
        url urlString: String,
        printResponse: Bool = false,
        headers: [(key: String, value: String)] = [],
        body: Data = Data(),
        beforeRequest: @escaping () -> Void = {},
        response: @escaping (_ response: (status: ResponseStatus, body: Data)) -> Void,
        afterResponse: @escaping () -> Void = {}
    ) {
        self.request(
            url: urlString,
            httpMethod: HttpMethod.DELETE,
            printResponse: printResponse,
            headers: headers,
            body: body,
            beforeRequest: beforeRequest,
            response: response,
            afterResponse: afterResponse
        )
    }

    /// A plain http request with a custom method, which submits an encodable object
    public static func request<T: Encodable>(
        url urlString: String,
        httpMethod: HttpMethod,
        printResponse: Bool = false,
        headers: [(key: String, value: String)] = [],
        body: T,
        beforeRequest: @escaping () -> Void,
        response: @escaping (_ response: (status: ResponseStatus, body: Data)) -> Void,
        afterResponse: @escaping () -> Void
    ) {

        beforeRequest()

        if let url = URL(string: urlString) {

            if let body = try? JSONEncoder().encode(body) {

                var request = self.generateRequest(url: url, httpMethod: httpMethod, headers: headers, body: body)
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                self.executeRequest(
                    request: request,
                    printResponse: printResponse,
                    response: response,
                    afterResponse: afterResponse
                )

            } else {
                print("HttpClient error\nrequest body could not be encoded to json")
                response((ResponseStatus.appError, Data()))
            }

        } else {
            print("HttpClient error\ninvalid url: \(urlString == "" ? "empty string" : urlString)")
            response((ResponseStatus.appError, Data()))
            afterResponse()
        }

    }

    /// A plain http request with a custom method
    public static func request(
        url urlString: String,
        httpMethod: HttpMethod,
        printResponse: Bool = false,
        headers: [(key: String, value: String)] = [],
        body: Data,
        beforeRequest: @escaping () -> Void = {},
        response: @escaping (_ response: (status: ResponseStatus, body: Data)) -> Void,
        afterResponse: @escaping () -> Void = {}
    ) {

        beforeRequest()

        if let url = URL(string: urlString) {

            let request = self.generateRequest(url: url, httpMethod: httpMethod, headers: headers, body: body)
            self.executeRequest(
                request: request,
                printResponse: printResponse,
                response: response,
                afterResponse: afterResponse
            )

        } else {
            print("HttpClient error\ninvalid url: \(urlString == "" ? "empty string" : urlString)")
            response((ResponseStatus.appError, Data()))
            afterResponse()
        }

    }

    private static func generateRequest(
        url: URL,
        httpMethod: HttpMethod,
        headers: [(key: String, value: String)],
        body: Data
    ) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body

        headers.forEach { (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        }

        return request
    }

    internal static func executeRequest(
        request: URLRequest,
        printResponse: Bool,
        response: @escaping (_ response: (status: ResponseStatus, body: Data)) -> Void,
        afterResponse: @escaping () -> Void
    ) {
        URLSession.shared.dataTask(with: request) { responseBody, responseHeader, error in

            DispatchQueue.main.async {

                if let error = error as? URLError, error.errorCode == -1009 {
                    response((ResponseStatus.noInternetConnection, Data()))
                } else if let responseHeader = responseHeader as? HTTPURLResponse, let responseBody = responseBody {
                    response((
                        ResponseStatus(rawValue: responseHeader.statusCode) ?? ResponseStatus.unknownStatusCode,
                        responseBody
                    ))
                } else if let responseBody = responseBody {
                    response((ResponseStatus.untypicalResponseHeader, responseBody))
                } else {
                    response((ResponseStatus.appError, Data()))
                }

                if printResponse {
                    if let responseBody = responseBody, let responseText = String(data: responseBody, encoding: .utf8) {
                        print(responseText)
                    } else {
                        print("HttpClient error\nresponse could not be printed")
                    }
                }

                afterResponse()

            }

        }.resume()
    }
}
