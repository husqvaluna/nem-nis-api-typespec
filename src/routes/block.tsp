import "@typespec/http";

import "../types/core.tsp";
import "../models";

using Http;

@tag("block")
@route("/block")
namespace Nem.Block {
  @get
  @route("/get")
  @summary("Getting a block with a given hash")
  @doc("Retrieves a block from the blockchain using its hash. This operation allows fetching specific block details.")
  op getBlockByHash(@query(#{ explode: true }) blockHash?: string): Body<BlockDTO>;

  @post
  @route("/at/public")
  @summary("Getting a block with a given height")
  @doc("Retrieves a block from the blockchain at a specific height.")
  op getBlockAtHeight(
    @body body: {
      blockHeight?: HttpPart<string>;
    },
  ): Body<BlockDTO>;
}
