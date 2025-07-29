import "../types/core.tsp";
import "../models";

using Http;
using OpenAPI;

@tag("block")
@route("/block")
namespace Nem.Block {
  @get
  @route("/get")
  @summary("Getting a block with a given hash")
  @doc("Retrieves a block from the blockchain using its hash. This operation allows fetching specific block details.")
  @operationId("getBlockByHash")
  op getBlockByHash(@query(#{ explode: true }) blockHash?: string): BlockDTO;

  @post
  @route("/at/public")
  @summary("Getting a block with a given height")
  @doc("Retrieves a block from the blockchain at a specific height.")
  @operationId("getBlockAtHeight")
  op getBlockAtHeight(
    @body body: {
      blockHeight?: HttpPart<string>;
    },
  ): BlockDTO;
}
