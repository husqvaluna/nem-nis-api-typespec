@doc("The network identifier.")
enum NetworkId {
  Testnet: 152,
  Mainnet: 104,
  Mijin: 96,
}

/**
 * The protocol used for node communication.
 */
enum NodeProtocol {
  HTTP: "http",
  HTTPS: "https",
}

/**
 * Represents meta data for a node.
 */
model NodeMetaData {
  @doc("The number of features the node has.")
  @example(1)
  features: int32;

  @doc("The network id (104: mainnet, 96: mijin, 152: testnet).")
  networkId: NetworkId;

  @doc("The name of the application that is running the node.")
  @example("NIS")
  application: string;

  @doc("The version of the application.")
  @example("0.6.100")
  version: string;

  @doc("The underlying platform (OS, java version).")
  @example("Oracle Corporation (1.8.0_25) on Windows 8")
  platform: string;
}

/**
 * Represents the endpoint information for a node.
 */
model NodeEndpoint {
  @doc("The protocol used for communication (HTTP or HTTPS).")
  protocol: NodeProtocol;

  @doc("The port used for communication.")
  @example(7890)
  port: int32;

  @doc("The IP address or hostname of the endpoint.")
  @example("127.0.0.1")
  host: string;
}

/**
 * Represents the identity information for a node.
 */
model NodeIdentity {
  @doc("The name of the node.")
  @example("Alice")
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
  @example(1)
  s: int32;

  @doc("The number of failed communications with the remote node.")
  @example(0)
  f: int32;
}

/**
 * Represents a pair of a node and its communication experience.
 */
model ExtendedNodeExperiencePair {
  @doc("The remote Node object.")
  node: NodeInfo;

  @doc("The number of synchronization attempts the node had with the remote node.")
  @example(3)
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
  @doc("The current network time, i.e. the number of seconds that have elapsed since the creation of the nemesis block.")
  @example(9189086)
  currentTime: int32;

  @doc("The name of the application running on the node.")
  @example("NEM Infrastructure Server")
  application: string;

  @doc("The network time when the application was started.")
  @example(9060202)
  startTime: int32;

  @doc("The application version.")
  @example("0.6.102")
  version: string;

  @doc("The signer of the certificate used by the application.")
  @example("CN=NEM Community,OU=Development Team,O=NEM,L=Internet,ST=web,C=WD")
  signer: string;
}

/**
 * Represents meta data for a boot node request.
 */
model BootNodeMetaData {
  @doc("The application name (e.g., \"NIS\").")
  @example("NIS")
  application: string;
}

/**
 * Represents the endpoint information for a boot node request.
 */
model BootNodeEndpoint {
  @doc("The protocol (e.g., \"http\").")
  protocol: string;

  @doc("The port number.")
  @example(7890)
  port: int32;

  @doc("The host address or name.")
  @example("127.0.0.1")
  host: string;
}

/**
 * Represents the identity information for a boot node request.
 */
model BootNodeIdentity {
  @doc("The private key as hexadecimal string (64 chars).")
  "private-key": PrivateKey;

  @doc("The name of the node.")
  @example("Alice")
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
