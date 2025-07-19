/**
 * Represents an error object returned by NIS.
 */
model ErrorObject {
  @doc("The number of seconds elapsed since the creation of the nemesis block.")
  timeStamp: int32;

  @doc("The general description of the error.")
  error: string;

  @doc("The detailed error message.")
  message: string;

  @doc("The HTTP status code.")
  status: int32;
}

/**
 * The type of a NEM request result.
 */
enum NemRequestResultType {
  /** Validation result. */
  Validation: 1,
  /** Heartbeat result. */
  Heartbeat: 2,
  /** Status result. */
  Status: 4,
}

/**
 * Represents the result of a NEM request, typically used for validation or status.
 */
model NemRequestResult {
  @doc("The type of the result (1: validation, 2: heart beat, 4: status).")
  type: NemRequestResultType;

  @doc("The code of the result. Interpretation depends on the type.")
  code: int32;

  @doc("A human-readable message describing the result.")
  message: string;
}

/**
 * Represents the result of announcing a transaction.
 * Extends NemRequestResult with transaction hash information.
 */
model NemAnnounceResult extends NemRequestResult {
  @doc("The hash object of the transaction.")
  transactionHash: TransactionHash;

  @doc("The hash object of the inner transaction or null if the transaction is not a multisig transaction.")
  innerTransactionHash?: TransactionHash | null;
}

/**
 * Contains information about network time stamps for communication.
 */
model CommunicationTimeStamps {
  @doc("The network time at the moment the reply was sent (seconds elapsed since nemesis block).")
  sendTimeStamp: int64;

  @doc("The network time at the moment the request was received (seconds elapsed since nemesis block).")
  receiveTimeStamp: int64;
}

/**
 * Represents information about an audited request.
 */
model AuditInfo {
  @doc("The relative URL path of the request.")
  path: string;

  @doc("The number of seconds elapsed since the creation of the nemesis block when the request was received.")
  startTime: int32;

  @doc("The host which initiated the request.")
  host: string;

  @doc("The time in seconds that has elapsed since the request was received.")
  elapsedTime: int32;

  @doc("The unique id of the request.")
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
  dateTime: string;

  @doc("The current offset to the local computer clock in milliseconds.")
  currentTimeOffset: int64;

  @doc("The change in milliseconds compared to the last synchronization.")
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
  hash?: HexHash64;

  @doc("The optional transaction id.")
  id?: string;
}