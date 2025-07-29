import "../types/core.tsp";
import "../models";

using Http;
using OpenAPI;

@tag("node")
@route("/node")
namespace Nem.Node {
  @get
  @route("/info")
  @summary("Basic node information")
  @doc("Retrieves basic information about the NIS node, including its metadata, endpoint, and identity.")
  @operationId("getNodeInfo")
  op getNodeInfo(): NodeInfo;

  @get
  @route("/extended-info")
  @summary("Extended node information")
  @doc("Retrieves extended information about the NIS node, including application metadata and detailed node information.")
  @operationId("getNodeExtendedInfo")
  op getNodeExtendedInfo(): NisNodeInfo;

  @get
  @route("/peer-list/all")
  @summary("Complete neighborhood")
  @doc("Retrieves a list of all known peer nodes in the NEM network, categorized by their status (active, inactive, busy, failure).")
  @operationId("getAllNodePeers")
  op getAllNodePeers(): NodeCollection;

  @get
  @route("/peer-list/reachable")
  @summary("Reachable neighborhood")
  @doc("Retrieves a list of reachable peer nodes in the NEM network.")
  @operationId("getReachableNodePeers")
  op getReachableNodePeers(): NodeCollection;

  @get
  @route("/peer-list/active")
  @summary("Active neighborhood")
  @doc("Retrieves a list of active peer nodes in the NEM network.")
  @operationId("getActiveNodePeers")
  op getActiveNodePeers(): NodeCollection;

  @get
  @route("/active-peers/max-chain-height")
  @summary("Maximum chain height in the active neighborhood")
  @doc("Retrieves the maximum blockchain height reported by active peer nodes.")
  @operationId("getActivePeersMaxChainHeight")
  op getActivePeersMaxChainHeight():BlockHeight;

  @get
  @route("/experiences")
  @summary("Requesting node experiences")
  @doc("Retrieves information about the communication experiences with various nodes, including success and failure counts.")
  @operationId("getNodeExperiences")
  op getNodeExperiences(): ExtendedNodeExperiencePair[];

  @post
  @route("/boot")
  @summary("Booting the local node")
  @operationId("postNodeBoot")
  op postNodeBoot(): NemRequestResult;
}
