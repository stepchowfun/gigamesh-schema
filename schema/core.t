# The data described by this schema are persisted to blob storage. Everything
# in this file is considered immutable once persisted except where indicated
# otherwise.
#
# This schema does not describe data which is not stored in blobs: users and
# locks. Those entities will be stored in a separate database with a relatively
# uninteresting schema.

# This is the information needed to identify a user.
struct UserId {
    # A user is identified by 32 bytes chosen uniformly randomly by a
    # cryptographically secure pseudorandom number generator.
    id: Bytes = 0
}

# This is the information needed to identify a version of an object.
struct ObjectVersionId {
    # An object version is identified by 32 bytes chosen uniformly randomly by
    # a cryptographically secure pseudorandom number generator.
    id: Bytes = 0
}

# This is a particular version of an object in the graph.
struct ObjectVersion {
    # This timestamp records when this object version was created. It must be
    # greater than or equal to the timestamps of any object versions referenced
    # by the other fields below.
    updated_at: Timestamp = 0

    # This is the user who created this object version.
    updated_by: UserId = 1

    # This is the identifier of the previous version of the object, if it
    # exists.
    optional previous: ObjectVersionId = 2

    # This is the identifier of the subsequent version of the object, if it
    # exists. This field can undergo up to one mutation: the transition from
    # unset to set.
    optional next: ObjectVersionId = 3

    # Incoming links propagate permissions from other objects to this object.
    incoming_links: [Link] = 4

    # Outgoing links propagate permissions from this object to other objects.
    outgoing_links: [Link] = 5

    # We record a chain for each user who has read permission to this object.
    read_chains: [Chain] = 6

    # We record a write-propagating chain for each user who has write
    # permission to this object version.
    write_chains: [Chain] = 7

    # This is the data stored with the object version.
    payload: ObjectVersionPayload = 8
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

# This is link. The link may be incoming or outgoing, determined from context.
choice Link {
    # The link propagates read permission only.
    propagate_read: ObjectVersionId = 0

    # The link propagates both read and write permission.
    propagate_read_and_write: ObjectVersionId = 1
}

# A chain is a shortest path from a user's home group to an object version.
struct Chain {
    # This is the user associated with the home group.
    user: UserId = 0

    # The chain is represented by an array of object versions, including the
    # object version(s) at the start and end of the chain. The number of object
    # versions in this array is equal to the number of links in the chain plus
    # one. The links themselves are not stored explicitly.
    chain: [ObjectVersionId] = 1
}

# This is the payload stored in an object version. The variants (document,
# directory, etc.) have yet to be defined here.
choice ObjectVersionPayload {
}
