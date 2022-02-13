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

# This is the payload stored in an object version. The variants (document,
# directory, etc.) have yet to be defined here.
choice ObjectVersionPayload {
}
