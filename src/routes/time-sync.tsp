import "../types/core.tsp";
import "../models";

using Http;

@tag("time-sync")
@route("/time-sync")
namespace Nem.TimeSync {
  @get
  @route("/network-time")
  @summary("Gets network time.")
  @doc("Gets the communication time stamps (receive/send network time).")
  op getNetworkTime(): CommunicationTimeStamps;
}
