import "@typespec/http";

import "../types/core.tsp";
import "../models";

using Http;

@tag("chain")
@route("/chain")
namespace Nem.Chain {
  @get
  @route("/height")
  @summary("Block chain height")
  @doc("Retrieves the current height of the blockchain.")
  op getChainInfo(): BlockHeight;

  @get
  @route("/score")
  @summary("Block chain score")
  op getChainScore(): Body<BlockChainScore>;

  @get
  @route("/last-block")
  @summary("Last block of the block chain score")
  @doc("Retrieves the current last block of the blockchain, providing details about the most recently added block.")
  op getChainLastBlock(): Body<BlockDTO>;
}
