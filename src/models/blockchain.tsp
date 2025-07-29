/**
 * Represents the score of the blockchain.
 */
model BlockChainScore {
  @doc("The score of the blockchain as a hexadecimal string.")
  @example("18722d5a7d590deb")
  score: Hash;
}

/**
 * Represents the height of a block in the blockchain.
 */
model BlockHeight {
  @doc("The height of the block.")
  @minValue(1)
  @example(1)
  height: Height;
}

/**
 * Contains information about a block that an account harvested.
 */
model HarvestInfo {
  @doc("The number of seconds elapsed since the creation of the nemesis block.")
  @example(8879051)
  timeStamp: int32;

  @doc("The database id for the harvested block.")
  @example(1262068)
  id: int32;

  @doc("The block difficulty.")
  @example(26453656336676)
  difficulty: int64;

  @doc("The total fee collected by harvesting the block in micro NEM.")
  @example(102585065)
  totalFee: int64;

  @doc("The height of the harvested block.")
  @minValue(1)
  @example(1)
  height: Height;
}

/**
 * Represents a block in the NEM blockchain.
 */
model BlockDTO {
  @doc("Number of seconds elapsed since the creation of the nemesis block when the block was created.")
  @example(9232968)
  timeStamp: int32;

  @doc("The signature of the block (hexadecimal string, 128 chars).")
  signature: Signature;

  @doc("The hash of the previous block.")
  prevBlockHash: Hash;

  @doc("The array of transactions included in the block.")
  transactions: (TransferTransaction | ImportanceTransferTransaction | MultisigAggregateModificationTransaction | MultisigSignatureTransaction | unknown)[];

  @doc("The version of the block structure.")
  version: int32;

  @doc("The hash of the block.")
  hash: Hash;

  @doc("The height of the block.")
  height: Height;

  @doc("The block difficulty.")
  @example(23456789012345)
  difficulty: int64;

  @doc("The total fee collected by harvesting the block in micro NEM.")
  @example(150000)
  totalFee: int64;

  @doc("The type of the block (usually 1 for a normal block).")
  type: int32;

  @doc("The payload of the block (usually empty).")
  payload?: string;

  @doc("The public key of the account that generated (harvested) the block (hexadecimal string, 64 chars).")
  generatorPublicKey: PublicKey;

  @doc("The block reward in micro NEM.")
  blockReward: int64;
}

/**
 * Represents a block view model used by the blockchain explorer.
 */
model ExplorerBlockViewModel {
  @doc("Array containing the transactions of the block.")
  txes: ExplorerTransferViewModel[];

  @doc("The block object.")
  block: BlockDTO;

  @doc("The hash of the block (hexadecimal string, 64 chars).")
  hash: Hash;

  @doc("The difficulty of the block.")
  @example(23456789012345)
  difficulty: int64;
}

/**
 * Represents a transaction view model used by the blockchain explorer.
 */
model ExplorerTransferViewModel {
  @doc("The transaction object. The specific type depends on the transaction type field within.")
  tx: TransferTransaction | ImportanceTransferTransaction | MultisigAggregateModificationTransaction | MultisigSignatureTransaction | unknown;

  @doc("The hash of the transaction.")
  hash: Hash;

  @doc("The hash of the inner transaction. Only available for multisig transactions.")
  innerHash?: Hash;
}
