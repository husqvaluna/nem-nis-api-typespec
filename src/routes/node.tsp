import "@typespec/http";

import "../types/core.tsp";
import "../models";

using Http;

@tag("node")
@route("/node")
namespace Nem.Node {
  @get
  @route("/info")
  @summary("Basic node information")
  @doc("Retrieves basic information about the NIS node, including its metadata, endpoint, and identity.")
  op getNodeInfo(): Body<NodeInfo>;

  @get
  @route("/extended-info")
  @summary("Extended node information")
  @doc("Retrieves extended information about the NIS node, including application metadata and detailed node information.")
  op getNodeExtendedInfo(): Body<NisNodeInfo>;

  @get
  @route("/peer-list/all")
  @summary("Complete neighborhood")
  @doc("Retrieves a list of all known peer nodes in the NEM network, categorized by their status (active, inactive, busy, failure).")
  op getAllNodePeers(): Body<NodeCollection>;

  @get
  @route("/peer-list/reachable")
  @summary("Reachable neighborhood")
  @doc("Retrieves a list of reachable peer nodes in the NEM network.")
  op getReachableNodePeers(): Body<NodeCollection>;

  @get
  @route("/peer-list/active")
  @summary("Active neighborhood")
  @doc("Retrieves a list of active peer nodes in the NEM network.")
  op getActiveNodePeers(): Body<NodeCollection>;

  @get
  @route("/active-peers/max-chain-height")
  @summary("Maximum chain height in the active neighborhood")
  @doc("Retrieves the maximum blockchain height reported by active peer nodes.")
  op getActivePeersMaxChainHeight(): Body<BlockHeight>;

  @get
  @route("/experiences")
  @summary("Requesting node experiences")
  @doc("Retrieves information about the communication experiences with various nodes, including success and failure counts.")
  op getNodeExperiences(): Body<ExtendedNodeExperiencePair[]>;

  @post
  @route("/boot")
  @summary("Booting the local node")
  op postNodeBoot(): NemRequestResult;
}
