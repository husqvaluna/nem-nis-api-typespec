import "@typespec/http";

import "../types/core.tsp";
import "../models";

using Http;

@tag("debug")
@route("/debug")
namespace Nem.Debug {
  @get
  @route("/time-synchronization")
  @summary("Monitoring the network time")
  @doc("Retrieves information about the network time synchronization, including current time offset and changes.")
  op getDebugTimeSynchronization(): Body<TimeSynchronizationResult[]>;

  @get
  @route("/connections/incoming")
  @summary("Monitoring incoming calls")
  @doc("Retrieves information about incoming connections to the NIS node for debugging purposes.")
  op getDebugIncomingConnections(): Body<AuditCollection>;

  @get
  @route("/connections/outgoing")
  @summary("Monitoring outgoing calls")
  @doc("Retrieves information about outgoing connections from the NIS node for debugging purposes.")
  op getDebugOutgoingConnections(): Body<AuditCollection>;

  @get
  @route("/timers")
  @summary("Monitoring timers")
  @doc("Retrieves information about various internal timers within the NIS node for monitoring and debugging.")
  op getDebugTimers(): Body<NemAsyncTimerVisitor[]>;
}
