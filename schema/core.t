# The data described by this schema are persisted to blob storage. Everything
# in this file is considered immutable once persisted except where indicated
# otherwise.

# This schema does not describe data which is not stored in blobs: users and
# locks. Those entities will be stored in a separate database with a relatively
# uninteresting schema.

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
    # This represents when this version of the object was created.
    # This timestamp must be greater than or equal to the timestamps of any
    # objects referred to by the `previous`, `links`, `shortest_read_paths`,
    # and `shortest_write_paths` fields.
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

    # For each user which has read permission to this object, we keep track of a
    # shortest path from that user's home group to this object. Note that all
    # paths propagate read permission.
    shortest_read_paths: [Path] = 5

    # For each user which has write permission to this object, we keep track of
    # a shortest write-propagating path from that user's home group to this
    # object. Note that not all paths propagate write permission.
    shortest_write_paths: [Path] = 6

    # This is the data stored with the object.
    payload: ObjectPayload = 7
}

# This is a point in time.
struct Timestamp {
    # Number of seconds since the UNIX Epoch, rounded down to the nearest
    # second.
    seconds: U64 = 0

    # The fractions of a second at nanosecond resolution. The valid range is
    # given by the half-open interval [0, 10^9).
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

# This is a path to an object from a user's home group.
struct Path {
    # This is the user associated with the home group.
    user: UserId = 0

    # The path is an array of objects, including the object(s) at the start and
    # end of the path. The number of objects in this array is equal to the
    # number of links in the path plus one.
    path: [ObjectId] = 1
}

# This is the data stored in an object.
choice ObjectPayload {
    # The variants (document, directory, etc.) have yet to be defined here.
}
