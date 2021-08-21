# HTTP Client Module
[![build](https://github.com/swiftui-packages/http-client-module/actions/workflows/build.yml/badge.svg)](https://github.com/swiftui-packages/http-client-module/actions/workflows/build.yml)
[![test](https://github.com/swiftui-packages/http-client-module/actions/workflows/test.yml/badge.svg)](https://github.com/swiftui-packages/http-client-module/actions/workflows/test.yml)
[![swiftlint](https://github.com/swiftui-packages/http-client-module/actions/workflows/swiftlint.yml/badge.svg)](https://github.com/swiftui-packages/http-client-module/actions/workflows/swiftlint.yml)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/8692b3264bf149e1a4982d19e2cc7f3f)](https://www.codacy.com/gh/swiftui-packages/http-client-module/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=swiftui-packages/http-client-module&amp;utm_campaign=Badge_Grade)
[![swiftpackageindex swift versions](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fswiftui-packages%2Fhttp-client-module%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/swiftui-packages/http-client-module)
[![swiftpackageindex platforms](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fswiftui-packages%2Fhttp-client-module%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/swiftui-packages/http-client-module)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

In order to be able to perform HTTP requests, Swift provides the [URLSession class](https://developer.apple.com/documentation/foundation/urlsession) with the Foundation Framework. This is traditionally implemented in an object-oriented style with a singleton instance and according to today's standards is no longer really intuitive to use. Instead of receiving all request-related attributes in a constructor, it is necessary to create an object, set its attributes and then execute the _resume()_ function on it. If you want to use the response of a request in your app, which seems obvious, a main thread dispatch is also required. All of this boiler plate means that code quality decreases and with it its readability and maintainability.

This package is supposed to make it possible to send HTTP requests in a highly intuitive way. In contrast to, for example [Alamofire](https://github.com/Alamofire/Alamofire), it shall also appear as minimalistic as possible.

<br>

## Usage

Since it is often required to for example start a loading indicator with a http request and end it with its response, this module comes with Lifecycle hooks:
-   beforeRequest
-   response
-   afterResponse

The response object is a tuple consisting of the response status and the response body. It can be destructured at the beginning of the closure or be passed as a object:

```swift
HTTPClient.get(url: "www.abc.com") { responseStatus, responseBody in

}
```

```swift
HTTPClient.get(url: "www.abc.com") { response in
    response.body // Data
    response.status // HTTPClient.ResponseStatus
    response.status.code // Int
}
```

To further reduce complexity in your project the response body parameter accepts decodable object, which it automatically converts to json Strings and adds the corresponding content type as http header. 

<br>

## Integration
1.  Copy the resource url:
```
https://github.com/swiftui-packages/http-client-module.git
```

2.  Open your Xcode project

3.  Two options a and b for step 3<br>
    a) &nbsp; At the menu bar navigate to _File_ / _Swift Packages_ / _Add Package Dependency_<br>
    b1)  Select the project's root folder<br>
    b2)  select your app name under _PROJECT_<br>
    b3)  Open _Swift Packages_ tab on the right side of _Info_ and _Build Settings_<br>
    b4)  Hit the _+_ button at the bottom of the list<br>

4.  Here you should be prompted to "_Choose Package Repository:_"

5.  Paste the resource url

6.  Select _Next_ to go with the latest version or select a specific version or branch

7.  After a short loading period of package resolution you get prompted to _Choose package products and targets_ (the default should be fine)

8.  The complete hit the _Finish_ button

9.  Import HTTPClientModule into the files where you want to use it

<br>

## Can also be found here
-   [Swift Package Registry](https://swiftpackageregistry.com/swiftui-packages/http-client-module)
-   [Swift Package Index](https://swiftpackageindex.com/swiftui-packages/http-client-module)
-   [Swift Pack](https://swiftpack.co/package/swiftui-packages/http-client-module)

<br>

## ToDos
-   maintaining README.md file
    -   GIF of importing Swift Package Manager Packages into Xcode Projects
    -   phrasing an introduction text
    -   writing usage instructions with code examples

-   feature: response encoding with type.self as parameter

-   further research about http for file upload and [form data](https://datatracker.ietf.org/doc/html/rfc7578)
