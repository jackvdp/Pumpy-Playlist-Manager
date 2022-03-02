// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class LoginMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation Login($email: String!, $password: String!) {
      loginUser(input: {email: $email, password: $password}) {
        __typename
        token
        refreshToken
      }
    }
    """

  public let operationName: String = "Login"

  public var email: String
  public var password: String

  public init(email: String, password: String) {
    self.email = email
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["email": email, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("loginUser", arguments: ["input": ["email": GraphQLVariable("email"), "password": GraphQLVariable("password")]], type: .object(LoginUser.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(loginUser: LoginUser? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "loginUser": loginUser.flatMap { (value: LoginUser) -> ResultMap in value.resultMap }])
    }

    public var loginUser: LoginUser? {
      get {
        return (resultMap["loginUser"] as? ResultMap).flatMap { LoginUser(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "loginUser")
      }
    }

    public struct LoginUser: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["LoginUserPayload"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("token", type: .nonNull(.scalar(String.self))),
          GraphQLField("refreshToken", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(token: String, refreshToken: String) {
        self.init(unsafeResultMap: ["__typename": "LoginUserPayload", "token": token, "refreshToken": refreshToken])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var token: String {
        get {
          return resultMap["token"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "token")
        }
      }

      public var refreshToken: String {
        get {
          return resultMap["refreshToken"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "refreshToken")
        }
      }
    }
  }
}

public final class GetPlaylistQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetPlaylist($playlistID: ID!) {
      playlist(id: $playlistID) {
        __typename
        name
        display {
          __typename
          image {
            __typename
            placeholder
          }
        }
        description
        shortDescription
        tracks(first: 1000, market: GB) {
          __typename
          edges {
            __typename
            node {
              __typename
              title
              artists {
                __typename
                name
              }
              album {
                __typename
                title
              }
              id
              isrc
              previewUrl
              recognizability
              display {
                __typename
                image {
                  __typename
                  placeholder
                }
              }
              shareUrl
            }
          }
        }
      }
    }
    """

  public let operationName: String = "GetPlaylist"

  public var playlistID: GraphQLID

  public init(playlistID: GraphQLID) {
    self.playlistID = playlistID
  }

  public var variables: GraphQLMap? {
    return ["playlistID": playlistID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("playlist", arguments: ["id": GraphQLVariable("playlistID")], type: .object(Playlist.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(playlist: Playlist? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "playlist": playlist.flatMap { (value: Playlist) -> ResultMap in value.resultMap }])
    }

    public var playlist: Playlist? {
      get {
        return (resultMap["playlist"] as? ResultMap).flatMap { Playlist(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "playlist")
      }
    }

    public struct Playlist: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Playlist"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("display", type: .object(Display.selections)),
          GraphQLField("description", type: .scalar(String.self)),
          GraphQLField("shortDescription", type: .scalar(String.self)),
          GraphQLField("tracks", arguments: ["first": 1000, "market": "GB"], type: .object(Track.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String, display: Display? = nil, description: String? = nil, shortDescription: String? = nil, tracks: Track? = nil) {
        self.init(unsafeResultMap: ["__typename": "Playlist", "name": name, "display": display.flatMap { (value: Display) -> ResultMap in value.resultMap }, "description": description, "shortDescription": shortDescription, "tracks": tracks.flatMap { (value: Track) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var display: Display? {
        get {
          return (resultMap["display"] as? ResultMap).flatMap { Display(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "display")
        }
      }

      public var description: String? {
        get {
          return resultMap["description"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      public var shortDescription: String? {
        get {
          return resultMap["shortDescription"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "shortDescription")
        }
      }

      public var tracks: Track? {
        get {
          return (resultMap["tracks"] as? ResultMap).flatMap { Track(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "tracks")
        }
      }

      public struct Display: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Display"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("image", type: .object(Image.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(image: Image? = nil) {
          self.init(unsafeResultMap: ["__typename": "Display", "image": image.flatMap { (value: Image) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var image: Image? {
          get {
            return (resultMap["image"] as? ResultMap).flatMap { Image(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "image")
          }
        }

        public struct Image: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Image"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("placeholder", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(placeholder: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Image", "placeholder": placeholder])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var placeholder: String? {
            get {
              return resultMap["placeholder"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "placeholder")
            }
          }
        }
      }

      public struct Track: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["PlaylistTracksConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("edges", type: .nonNull(.list(.nonNull(.object(Edge.selections))))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(edges: [Edge]) {
          self.init(unsafeResultMap: ["__typename": "PlaylistTracksConnection", "edges": edges.map { (value: Edge) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var edges: [Edge] {
          get {
            return (resultMap["edges"] as! [ResultMap]).map { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) }
          }
          set {
            resultMap.updateValue(newValue.map { (value: Edge) -> ResultMap in value.resultMap }, forKey: "edges")
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["PlaylistTracksEdge"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("node", type: .nonNull(.object(Node.selections))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(node: Node) {
            self.init(unsafeResultMap: ["__typename": "PlaylistTracksEdge", "node": node.resultMap])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var node: Node {
            get {
              return Node(unsafeResultMap: resultMap["node"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "node")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Track"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("title", type: .nonNull(.scalar(String.self))),
                GraphQLField("artists", type: .list(.nonNull(.object(Artist.selections)))),
                GraphQLField("album", type: .object(Album.selections)),
                GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                GraphQLField("isrc", type: .scalar(String.self)),
                GraphQLField("previewUrl", type: .scalar(String.self)),
                GraphQLField("recognizability", type: .scalar(Int.self)),
                GraphQLField("display", type: .object(Display.selections)),
                GraphQLField("shareUrl", type: .scalar(String.self)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(title: String, artists: [Artist]? = nil, album: Album? = nil, id: GraphQLID, isrc: String? = nil, previewUrl: String? = nil, recognizability: Int? = nil, display: Display? = nil, shareUrl: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "Track", "title": title, "artists": artists.flatMap { (value: [Artist]) -> [ResultMap] in value.map { (value: Artist) -> ResultMap in value.resultMap } }, "album": album.flatMap { (value: Album) -> ResultMap in value.resultMap }, "id": id, "isrc": isrc, "previewUrl": previewUrl, "recognizability": recognizability, "display": display.flatMap { (value: Display) -> ResultMap in value.resultMap }, "shareUrl": shareUrl])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var title: String {
              get {
                return resultMap["title"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "title")
              }
            }

            public var artists: [Artist]? {
              get {
                return (resultMap["artists"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Artist] in value.map { (value: ResultMap) -> Artist in Artist(unsafeResultMap: value) } }
              }
              set {
                resultMap.updateValue(newValue.flatMap { (value: [Artist]) -> [ResultMap] in value.map { (value: Artist) -> ResultMap in value.resultMap } }, forKey: "artists")
              }
            }

            public var album: Album? {
              get {
                return (resultMap["album"] as? ResultMap).flatMap { Album(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "album")
              }
            }

            public var id: GraphQLID {
              get {
                return resultMap["id"]! as! GraphQLID
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            /// A globally unique ID to identify this recording
            public var isrc: String? {
              get {
                return resultMap["isrc"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "isrc")
              }
            }

            /// A 30 second preview of the track. Not available for all tracks
            public var previewUrl: String? {
              get {
                return resultMap["previewUrl"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "previewUrl")
              }
            }

            /// The recognizability of this track (0-100)
            public var recognizability: Int? {
              get {
                return resultMap["recognizability"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "recognizability")
              }
            }

            public var display: Display? {
              get {
                return (resultMap["display"] as? ResultMap).flatMap { Display(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "display")
              }
            }

            /// A URL that can be used to share the track with users. Does not necessarily always point to the same provider (e.g. Spotify)
            @available(*, deprecated, message: "Will be removed in a future version.")
            public var shareUrl: String? {
              get {
                return resultMap["shareUrl"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "shareUrl")
              }
            }

            public struct Artist: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["Artist"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("name", type: .nonNull(.scalar(String.self))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(name: String) {
                self.init(unsafeResultMap: ["__typename": "Artist", "name": name])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var name: String {
                get {
                  return resultMap["name"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "name")
                }
              }
            }

            public struct Album: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["Album"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("title", type: .nonNull(.scalar(String.self))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(title: String) {
                self.init(unsafeResultMap: ["__typename": "Album", "title": title])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var title: String {
                get {
                  return resultMap["title"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "title")
                }
              }
            }

            public struct Display: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["Display"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("image", type: .object(Image.selections)),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(image: Image? = nil) {
                self.init(unsafeResultMap: ["__typename": "Display", "image": image.flatMap { (value: Image) -> ResultMap in value.resultMap }])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var image: Image? {
                get {
                  return (resultMap["image"] as? ResultMap).flatMap { Image(unsafeResultMap: $0) }
                }
                set {
                  resultMap.updateValue(newValue?.resultMap, forKey: "image")
                }
              }

              public struct Image: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["Image"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("placeholder", type: .scalar(String.self)),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(placeholder: String? = nil) {
                  self.init(unsafeResultMap: ["__typename": "Image", "placeholder": placeholder])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var placeholder: String? {
                  get {
                    return resultMap["placeholder"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "placeholder")
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
