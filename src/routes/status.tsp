import "@typespec/http";

import "../types/core.tsp";
import "../models";

using Http;

@tag("nis-status")
namespace Nem.Status {
  @get
  @route("/heartbeat")
  @summary("Heart beat request")
  @doc("Checks the status of the NIS API to ensure it is running and responsive.")
  op getHeartbeat(): NemRequestResult;

  @get
  @route("/status")
  @summary("Status")
  @doc("Retrieves the overall status of the NIS API, providing information about its health and operational state.")
  op getStatus(): NemRequestResult;
}
