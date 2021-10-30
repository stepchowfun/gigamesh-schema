# The data described by this schema are persisted to blob storage. Every field
# in this file is considered immutable once persisted except where indicated
# otherwise.

# This type represents the information needed to identify a user.
struct UserId {
    # A user is identified by 32 bytes chosen uniformly randomly by a
    # cryptographically secure pseudorandom number generator.
    id: Bytes = 0
}

# This type represents the information needed to identify an object.
struct ObjectId {
    # An object is identified by 32 bytes chosen uniformly randomly by a
    # cryptographically secure pseudorandom number generator.
    id: Bytes = 0
}

# This type represents an entity in the graph.
struct Object {
    # This timestamp represents when this version of the object was created. If
    # the `previous` field below is present, then this timestamp must be greater
    # than or equal to the timestamp of the previous version.
    updated_at: Timestamp = 0

    # This represents the user who created this version of the object.
    updated_by: UserId = 1

    # This is the identifier of the previous version of this object, if it
    # exists. Otherwise, this is the first version of the object.
    optional previous: ObjectId = 2

    # This is the identifier of the subsequent version of this object, if it
    # exists. Otherwise, this is the latest version of the object. This field
    # can undergo up to one mutation: the transition from unset to set.
    optional next: ObjectId = 3

    # The egress of an object is the set of references it holds to other
    # objects.
    egress: [ObjectId] = 4

    # The ingress of an object is the set of references other objects hold to
    # it.
    ingress: [ObjectId] = 5

    # This field grants permissions for this object and all objects directly
    # or transitively referenced by it.
    permission_grants: [PermissionGrant] = 6

    # This is the data stored with the object.
    payload: ObjectPayload = 7
}

# This type represents a point in time.
struct Timestamp {
    # Number of seconds since the UNIX Epoch, rounded down to the nearest
    # second.
    seconds: U64 = 0

    # The fractions of a second at nanosecond resolution.
    nanoseconds: U64 = 1
}

# This type represents a single permission grant.
choice PermissionGrant {
    # Grant read permission to the public.
    public_read = 0

    # Grant read permission to a specific user.
    user_read: UserId = 1

    # Grant read and write permission to a specific user.
    user_read_and_write: UserId = 2
}

# This type represents the data stored in an object.
choice ObjectPayload {
    # The variants (notes, directories, etc.) have yet to be defined here.
}
