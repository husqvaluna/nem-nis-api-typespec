@doc("The type of a NEM request result.")
enum NemRequestResultType {
  @doc("Validation result.")
  validation: 1,

  @doc("Heartbeat result.")
  heartbeat: 2,

  @doc("Status result.")
  status: 4,
}

@doc("The result code of a request.")
enum NemRequestResultCode {
  @doc("Unknown status.")
  "unknown": 0,

  @doc("NIS is stopped.")
  stopped: 1,

  @doc("NIS is starting.")
  starting: 2,

  @doc("NIS is running.")
  running: 3,

  @doc("NIS is booting the local node (implies NIS is running).")
  booting: 4,

  @doc("The local node is booted (implies NIS is running).")
  booted: 5,

  @doc("The local node is synchronized (implies NIS is running and the local node is booted).")
  synchronized: 6,

  @doc("NIS local node does not see any remote NIS node (implies running and booted).")
  doesntSeeAnyRemote: 7,

  @doc("NIS is currently loading the block chain from the database. In this state NIS cannot serve any requests.")
  loading: 8,
}

/**
 * Represents an error object returned by NIS.
 */
model ErrorObject {
  @doc("The number of seconds elapsed since the creation of the nemesis block.")
  @example(9111526)
  timeStamp: int32;

  @doc("The general description of the error.")
  @example("Bad Request")
  error: string;

  @doc("The detailed error message.")
  @example("FAILURE_SERVER_LIMIT_EXCEEDED_EXCEPTION")
  message: string;

  @doc("The HTTP status code.")
  @example(400)
  status: int32;
}

/**
 * Represents the result of a NEM request, typically used for validation or status.
 */
model NemRequestResult {
  @doc("The type of the result (1: validation, 2: heart beat, 4: status).")
  @example(NemRequestResultType.heartbeat)
  type: NemRequestResultType;

  @doc("The code of the result. Interpretation depends on the type.")
  @example(NemRequestResultCode.stopped)
  code: NemRequestResultCode;

  @doc("A human-readable message describing the result.")
  @example("ok")
  message: string;
}

/**
 * Represents the result of announcing a transaction.
 * Extends NemRequestResult with transaction hash information.
 */
model NemAnnounceResult extends NemRequestResult {
  @doc("The hash object of the transaction.")
  transactionHash: Hash;

  @doc("The hash object of the inner transaction or null if the transaction is not a multisig transaction.")
  innerTransactionHash?: Hash | null;
}

/**
 * Contains information about network time stamps for communication.
 */
model CommunicationTimeStamps {
  @doc("The network time at the moment the reply was sent (seconds elapsed since nemesis block).")
  @example(328516712375)
  sendTimeStamp: int64;

  @doc("The network time at the moment the request was received (seconds elapsed since nemesis block).")
  @example(328516712375)
  receiveTimeStamp: int64;
}

/**
 * Represents information about an audited request.
 */
model AuditInfo {
  @doc("The relative URL path of the request.")
  @example("/account/get")
  path: string;

  @doc("The number of seconds elapsed since the creation of the nemesis block when the request was received.")
  @example(9111526)
  startTime: int32;

  @doc("The host which initiated the request.")
  @example("127.0.0.1")
  host: string;

  @doc("The time in seconds that has elapsed since the request was received.")
  @example(10)
  elapsedTime: int32;

  @doc("The unique id of the request.")
  @example(12345)
  id: int32;
}

/**
 * Represents a collection of audited requests for debug purposes.
 */
model AuditCollection {
  @doc("Array containing information about outstanding (not yet processed) requests.")
  outstanding: AuditInfo[];

  @doc("Array containing information about the most recent requests.")
  "most-recent": AuditInfo[];
}

/**
 * Contains information about a periodic task timer for monitoring.
 */
model NemAsyncTimerVisitor {
  @doc("The number of milliseconds since the last execution of the timer.")
  "last-delay-time": int64;

  @doc("The number of times the task was executed.")
  executions: int32;

  @doc("The number times the task failed.")
  failures: int32;

  @doc("The number times the task was successful.")
  successes: int32;

  @doc("The time at which the task started last time (seconds elapsed since nemesis block).")
  "last-operation-start-time": int64;

  @doc("True if the task is executing, false otherwise.")
  "is-executing": boolean;

  @doc("The name of the task.")
  name: string;

  @doc("The number of seconds the task needed on average.")
  "average-operation-time": float64;

  @doc("The number of seconds the task needed the last time.")
  "last-operation-time": float64;
}

/**
 * Represents the result of a network time synchronization.
 */
model TimeSynchronizationResult {
  @doc("The date and time when the synchronization was performed (string format).")
  @example("2018-01-15T15:37:00.000Z")
  dateTime: string;

  @doc("The current offset to the local computer clock in milliseconds.")
  @example(0)
  currentTimeOffset: int64;

  @doc("The change in milliseconds compared to the last synchronization.")
  @example(0)
  change: int32;
}

/**
 * Contains data needed to retrieve a set of transactions using a private key.
 * Use only when NIS is running locally.
 */
model AccountPrivateKeyTransactionsPage {
  @doc("The private key as hexadecimal string (64 chars).")
  value: PrivateKey;

  @doc("The optional hash value (hexadecimal string, 64 chars).")
  hash?: Hash;

  @doc("The optional transaction id.")
  id?: string;
}

