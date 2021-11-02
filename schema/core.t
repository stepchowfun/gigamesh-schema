# The data described by this schema are persisted to blob storage. Every field
# in this file is considered immutable once persisted except where indicated
# otherwise.

# This is the information needed to identify a user.
struct UserId {
    # A user is identified by 32 bytes chosen uniformly randomly by a
    # cryptographically secure pseudorandom number generator.
    id: Bytes = 0
}

# This is the information needed to identify an object.
struct ObjectId {
    # An object is identified by 32 bytes chosen uniformly randomly by a
    # cryptographically secure pseudorandom number generator.
    id: Bytes = 0
}

# This is a node in the graph.
struct Object {
    # This timestamp represents when this version of the object was created. If
    # the `previous` field below is present, then this timestamp must be greater
    # than or equal to the timestamp of the previous version.
    updated_at: Timestamp = 0

    # This is the user who created this version of the object.
    updated_by: UserId = 1

    # This is the identifier of the previous version of this object, if it
    # exists. Otherwise, this is the first version of the object.
    optional previous: ObjectId = 2

    # This is the identifier of the subsequent version of this object, if it
    # exists. Otherwise, this is the latest version of the object. This field
    # can undergo up to one mutation: the transition from unset to set.
    optional next: ObjectId = 3

    # These are the incoming and outgoing links. Links propagate permissions.
    links: [Link] = 4

    # This is the data stored with the object.
    payload: ObjectPayload = 5
}

# This is a point in time.
struct Timestamp {
    # Number of seconds since the UNIX Epoch, rounded down to the nearest
    # second.
    seconds: U64 = 0

    # The fractions of a second at nanosecond resolution.
    nanoseconds: U64 = 1
}

# This is an incoming or outgoing link which propagates read or read and write
# permission.
choice Link {
    # This is a link from another object to this one that propagates read
    # permission.
    incoming_read_only: ObjectId = 0

    # This is a link from another object to this one that propagates read and
    # write permission.
    incoming_read_and_write: ObjectId = 1

    # This is a link from this object to another one that propagates read
    # permission.
    outgoing_read_only: ObjectId = 2

    # This is a link from this object to another one that propagates read and
    # write permission.
    outgoing_read_and_write: ObjectId = 3
}

# This is the data stored in an object.
choice ObjectPayload {
    # The variants (document, directory, etc.) have yet to be defined here.
}
