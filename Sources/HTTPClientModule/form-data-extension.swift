//
//  form-data-extension.swift
//  HTTPClientModule
//
//  Created by Cem Yilmaz on 20.08.21.
//

import Foundation

extension HTTPClient {
    /// An extension to enable form data requests
    public class FormData {

        /// A selection of mime types
        public enum MIMEType: String {
            case applicationJson = "application/json"
            case imagePng = "image/png"
            case imageJpeg = "image/jpeg"
            case imageSvgXml = "image/svg+xml"
        }

        public static func request(
            url urlString: String,
            httpMethod: HttpMethod,
            printResponse: Bool = false,
            headers: [(key: String, value: String)] = [],
            textValues: [(key: String, value: String)] = [],
            dataTextValues: [(key: String, value: Data)] = [],
            fileValues: [(key: String, value: Data, fileName: String, mimeType: MIMEType)] = [],
            beforeRequest: @escaping() -> Void = {},
            response: @escaping (_ response: (status: ResponseStatus, body: Data)) -> Void,
            afterResponse: @escaping () -> Void = {}
        ) {

            beforeRequest()

            if let url = URL(string: urlString) {

                let request = self.generateRequest(
                    url: url,
                    headers: headers,
                    textValues: textValues,
                    dataTextValues: dataTextValues,
                    fileValues: fileValues,
                    httpMethod: httpMethod
                )
                HTTPClient.executeRequest(
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

        public static func post(
            url urlString: String,
            printResponse: Bool = false,
            headers: [(key: String, value: String)] = [],
            textValues: [(key: String, value: String)] = [],
            dataTextValues: [(key: String, value: Data)] = [],
            fileValues: [(key: String, value: Data, fileName: String, mimeType: MIMEType)] = [],
            beforeRequest: @escaping () -> Void = {},
            response: @escaping (_ response: (status: ResponseStatus, body: Data)) -> Void,
            afterResponse: @escaping () -> Void = {}
        ) {
            self.request(
                url: urlString,
                httpMethod: HTTPClient.HttpMethod.POST,
                printResponse: printResponse,
                headers: headers,
                textValues: textValues,
                dataTextValues: dataTextValues,
                fileValues: fileValues,
                beforeRequest: beforeRequest,
                response: response,
                afterResponse: afterResponse
            )
        }

        public static func patch(
            url urlString: String,
            printResponse: Bool = false,
            headers: [(key: String, value: String)] = [],
            textValues: [(key: String, value: String)] = [],
            dataTextValues: [(key: String, value: Data)] = [],
            fileValues: [(key: String, value: Data, fileName: String, mimeType: MIMEType)] = [],
            beforeRequest: @escaping () -> Void = {},
            response: @escaping (_ response: (status: ResponseStatus, body: Data)) -> Void,
            afterResponse: @escaping () -> Void = {}
        ) {
            self.request(
                url: urlString,
                httpMethod: HTTPClient.HttpMethod.PATCH,
                printResponse: printResponse,
                headers: headers,
                textValues: textValues,
                dataTextValues: dataTextValues,
                fileValues: fileValues,
                beforeRequest: beforeRequest,
                response: response,
                afterResponse: afterResponse
            )
        }

        public static func put(
            url urlString: String,
            printResponse: Bool = false,
            headers: [(key: String, value: String)] = [],
            textValues: [(key: String, value: String)] = [],
            dataTextValues: [(key: String, value: Data)] = [],
            fileValues: [(key: String, value: Data, fileName: String, mimeType: MIMEType)] = [],
            beforeRequest: @escaping () -> Void = {},
            response: @escaping (_ response: (status: ResponseStatus, body: Data)) -> Void,
            afterResponse: @escaping () -> Void = {}
        ) {
            self.request(
                url: urlString,
                httpMethod: HTTPClient.HttpMethod.PUT,
                printResponse: printResponse,
                headers: headers,
                textValues: textValues,
                dataTextValues: dataTextValues,
                fileValues: fileValues,
                beforeRequest: beforeRequest,
                response: response,
                afterResponse: afterResponse
            )
        }

        private static func generateRequest(
            url: URL,
            headers: [(key: String, value: String)],
            textValues: [(key: String, value: String)],
            dataTextValues: [(key: String, value: Data)] = [],
            fileValues: [(key: String, value: Data, fileName: String, mimeType: MIMEType)],
            httpMethod: HttpMethod
        ) -> URLRequest {

            var request = URLRequest(url: url)
            request.httpMethod = httpMethod.rawValue

            headers.forEach { (key, value) in
                request.setValue(value, forHTTPHeaderField: key)
            }

            let boundary = "Boundary-\(UUID().uuidString)"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.httpBody = Data()

            textValues.forEach { (key, value) in
                let string = "--\(boundary)\r\nContent-Disposition:form-data; name=\"\(key)\"\r\n\r\n\(value)\r\n"
                request.httpBody!.append(string.data(using: String.Encoding.utf8)!)
            }

            dataTextValues.forEach { (key, value) in
                request.httpBody!.append(
                    "--\(boundary)\r\n".data(using: String.Encoding.utf8)! +
                    "Content-Disposition:form-data; name=\"\(key)\"".data(using: String.Encoding.utf8)! +
                    "\r\n\r\n".data(using: String.Encoding.utf8)! +
                    value +
                    "\r\n".data(using: String.Encoding.utf8)!
                )
            }

            fileValues.forEach { (key, value, fileName, mimeType) in
                request.httpBody!.append(
                    "--\(boundary)\r\n".data(using: String.Encoding.utf8)! +
                    "Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(fileName)\"\r\nContent-Type: \(mimeType.rawValue)"
                        .data(using: String.Encoding.utf8)! +
                    "\r\n\r\n".data(using: String.Encoding.utf8)! +
                    value +
                    "\r\n".data(using: String.Encoding.utf8)!
                )
            }

            request.httpBody!.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)

            return request
        }
    }
}
