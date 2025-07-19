import "@typespec/http";

import "../types/core.tsp";
import "../models";

using Http;

@tag("transaction")
@route("/transaction")
namespace Nem.Transaction {
  @post
  @route("/prepare-announce")
  @summary("Initiating a transaction")
  @doc("Prepares a transaction for announcement, typically involving the creation of a signed transaction. This is the first step before broadcasting a transaction to the network.")
  op prepareTransactionAnnounce(
    @body body: {
      requestPrepareAnnounce?: HttpPart<string>;
    },
  ): Body<NemAnnounceResult>;

  @post
  @route("/announce")
  @summary("Sending the data to NIS")
  @doc("Announces a transaction to the NEM network via NIS. This broadcasts the prepared transaction for inclusion in a block.")
  op announceTransaction(
    @body body: {
      requestAnnounce?: HttpPart<string>;
    },
  ): Body<NemAnnounceResult>;
}
