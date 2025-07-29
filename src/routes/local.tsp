import "../types/core.tsp";
import "../models";

using Http;
using OpenAPI;

@tag("local")
@route("/local")
namespace Nem.Local {
  @tag("account")
  @post
  @route("/account/transfers/incoming")
  @summary("Incoming transactions with decoded messages")
  @doc("Retrieves incoming transactions for a local account with decoded messages. This endpoint is typically used when NIS is running locally.")
  @operationId("getDecodedIncomingTransfers")
  op getDecodedIncomingTransfers(
    @body body: {
      page?: HttpPart<string>;
    },
  ): Body<TransactionMetaDataPair[]>;

  @tag("account")
  @post
  @route("/account/transfers/outgoing")
  @summary("Outgoing transactions with decoded messages")
  @doc("Retrieves outgoing transactions for a local account with decoded messages. This endpoint is typically used when NIS is running locally.")
  @operationId("getDecodedOutgoingTransfers")
  op getDecodedOutgoingTransfers(
    @body body: {
      page?: HttpPart<string>;
    },
  ): Body<TransactionMetaDataPair[]>;

  @tag("account")
  @post
  @route("/account/transfers/all")
  @summary("All transactions with decoded messages")
  @doc("Retrieves all transactions (incoming and outgoing) for a local account with decoded messages. This endpoint is typically used when NIS is running locally.")
  @operationId("getDecodedAllTransfers")
  op getDecodedAllTransfers(
    @body body: {
      page?: HttpPart<string>;
    },
  ): Body<TransactionMetaDataPair[]>;


  @tag("block-chain")
  @post
  @route("/chain/blocks-after")
  @summary("Getting part of a chain")
  @doc("Retrieves a portion of the blockchain starting from a specified height. This endpoint is typically used when NIS is running locally.")
  @operationId("getBlocksAfterHeight")
  op getBlocksAfterHeight(
    @body body: {
      blockHeight?: HttpPart<string>;
    },
  ): Body<ExplorerBlockViewModel[]>;
}
