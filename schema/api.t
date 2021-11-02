import 'core.t'

# This is the request type for the `GetObject` API.
struct GetObjectRequest {
    # This is the ID of the object to fetch.
    object: core.ObjectId = 0

    # This is the ID of the user doing the fetching.
    user: core.UserId = 1
}

# This is the response type for the `GetObject` API.
choice GetObjectResponse {
    # The request was successful.
    success: core.Object = 0

    # The object doesn't exist or the user doesn't have read permission for it.
    denied = 1
}
