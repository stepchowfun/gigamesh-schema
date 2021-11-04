import 'core.t'

# This is the request type for the `GetObjectVersion` API.
struct GetObjectVersionRequest {
    # This is the ID of the object version to fetch.
    object_version: core.ObjectVersionId = 0

    # This is the ID of the user doing the fetching.
    user: core.UserId = 1
}

# This is the response type for the `GetObjectVersion` API.
choice GetObjectVersionResponse {
    # The request was successful.
    success: core.ObjectVersion = 0

    # The object version doesn't exist or the user doesn't have read permission
    # for it.
    denied = 1
}
