import "../types/core.tsp";
import "../models";

using Http;
using OpenAPI;

@tag("nis-status")
namespace Nem.Status {
  @get
  @route("/heartbeat")
  @summary("Heart beat request")
  @doc("Checks the status of the NIS API to ensure it is running and responsive.")
  @operationId("getHeartbeat")
  op getHeartbeat(): NemRequestResult;

  @get
  @route("/status")
  @summary("Status")
  @doc("Retrieves the overall status of the NIS API, providing information about its health and operational state.")
  @operationId("getStatus")
  op getStatus(): NemRequestResult;
}
