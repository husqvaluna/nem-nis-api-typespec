/**
 * Represents meta data for a node.
 */
model NodeMetaData {
  @doc("The number of features the node has.")
  features: int32;

  @doc("The network id (104: mainnet, 96: mijin, 152: testnet).")
  networkId: int32;

  @doc("The name of the application that is running the node.")
  application: string;

  @doc("The version of the application.")
  version: string;

  @doc("The underlying platform (OS, java version).")
  platform: string;
}

/**
 * The protocol used for node communication.
 */
enum NodeProtocol {
  HTTP: "http",
  HTTPS: "https",
}

/**
 * Represents the endpoint information for a node.
 */
model NodeEndpoint {
  @doc("The protocol used for communication (HTTP or HTTPS).")
  protocol: NodeProtocol;

  @doc("The port used for communication.")
  port: int32;

  @doc("The IP address or hostname of the endpoint.")
  host: string;
}

/**
 * Represents the identity information for a node.
 */
model NodeIdentity {
  @doc("The name of the node.")
  name: string;

  @doc("The public key used to identify the node (hexadecimal string, 64 chars).")
  "public-key": PublicKey;
}

/**
 * Represents a node in the NEM network.
 */
model NodeInfo {
  @doc("Meta data for the node.")
  metaData: NodeMetaData;

  @doc("Endpoint information for the node.")
  endpoint: NodeEndpoint;

  @doc("Identity information for the node.")
  identity: NodeIdentity;
}

/**
 * Represents the communication experience with a remote node.
 */
model NodeExperience {
  @doc("The number of successful communications with the remote node.")
  s: int32;

  @doc("The number of failed communications with the remote node.")
  f: int32;
}

/**
 * Represents a pair of a node and its communication experience.
 */
model ExtendedNodeExperiencePair {
  @doc("The remote Node object.")
  node: NodeInfo;

  @doc("The number of synchronization attempts the node had with the remote node.")
  syncs: int32;

  @doc("The communication experience with the remote node.")
  experience: NodeExperience;
}

/**
 * Holds arrays of nodes with different statuses.
 */
model NodeCollection {
  @doc("Array of inactive nodes.")
  inactive: NodeInfo[];

  @doc("Array of active nodes.")
  active: NodeInfo[];

  @doc("Array of busy nodes.")
  busy: NodeInfo[];

  @doc("Array of failing nodes.")
  failure: NodeInfo[];
}

/**
 * Provides detailed information about a NIS node.
 */
model NisNodeInfo {
  @doc("Contains the node object.")
  node: NodeInfo;

  @doc("Contains the application meta data substructure.")
  nisInfo: ApplicationMetaData;
}

/**
 * Represents application meta data (e.g., NIS version).
 */
model ApplicationMetaData {
  @doc("The version of the NIS application.")
  version?: string;

  @doc("The build of the NIS application.")
  build?: string;

  @doc("The start time of the NIS application.")
  startTime?: string;

  @doc("The current time of the NIS application.")
  currentTime?: string;
}

/**
 * Represents meta data for a boot node request.
 */
model BootNodeMetaData {
  @doc("The application name (e.g., \"NIS\").")
  application: string;
}

/**
 * Represents the endpoint information for a boot node request.
 */
model BootNodeEndpoint {
  @doc("The protocol (e.g., \"http\").")
  protocol: string;

  @doc("The port number.")
  port: int32;

  @doc("The host address or name.")
  host: string;
}

/**
 * Represents the identity information for a boot node request.
 */
model BootNodeIdentity {
  @doc("The private key as hexadecimal string (64 chars).")
  "private-key": PrivateKey;

  @doc("The name of the node.")
  name: string;
}

/**
 * Represents a request to boot a local node.
 */
model BootNodeRequest {
  @doc("Meta data for the boot node request.")
  metaData: BootNodeMetaData;

  @doc("Endpoint information for the boot node request.")
  endpoint: BootNodeEndpoint;

  @doc("Identity information for the boot node request.")
  identity: BootNodeIdentity;
}