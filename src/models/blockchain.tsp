/**
 * Represents the score of the blockchain.
 */
model BlockChainScore {
  @doc("The score of the blockchain as a hexadecimal string.")
  score: string;
}

/**
 * Represents the height of a block in the blockchain.
 */
model BlockHeight {
  @doc("The height of the block.")
  @minValue(1)
  height: int64;
}

/**
 * Contains information about a block that an account harvested.
 */
model HarvestInfo {
  @doc("The number of seconds elapsed since the creation of the nemesis block.")
  timeStamp: int32;

  @doc("The database id for the harvested block.")
  id: int32;

  @doc("The block difficulty.")
  difficulty: int64;

  @doc("The total fee collected by harvesting the block in micro NEM.")
  totalFee: int64;

  @doc("The height of the harvested block.")
  @minValue(1)
  height: int64;
}

/**
 * Represents a block in the NEM blockchain.
 */
model BlockDTO {
  @doc("Number of seconds elapsed since the creation of the nemesis block when the block was created.")
  timeStamp: int32;

  @doc("The signature of the block (hexadecimal string, 128 chars).")
  @pattern("^[a-f0-9]{128}$")
  signature: string;

  @doc("The hash of the previous block.")
  prevBlockHash: TransactionHash;

  @doc("The array of transactions included in the block.")
  transactions: (TransferTransaction | ImportanceTransferTransaction | MultisigAggregateModificationTransaction | MultisigSignatureTransaction | unknown)[];

  @doc("The version of the block structure.")
  version: int32;

  @doc("The hash of the block.")
  hash: TransactionHash;

  @doc("The height of the block.")
  @minValue(1)
  height: int64;

  @doc("The block difficulty.")
  difficulty: int64;

  @doc("The total fee collected by harvesting the block in micro NEM.")
  totalFee: int64;

  @doc("The type of the block (usually 1 for a normal block).")
  type: int32;

  @doc("The payload of the block (usually empty).")
  payload?: string;

  @doc("The public key of the account that generated (harvested) the block (hexadecimal string, 64 chars).")
  @pattern("^[a-f0-9]{64}$")
  generatorPublicKey: string;

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
  hash: HexHash64;

  @doc("The difficulty of the block.")
  difficulty: int64;
}

/**
 * Represents a transaction view model used by the blockchain explorer.
 */
model ExplorerTransferViewModel {
  @doc("The transaction object. The specific type depends on the transaction type field within.")
  tx: TransferTransaction | ImportanceTransferTransaction | MultisigAggregateModificationTransaction | MultisigSignatureTransaction | unknown;

  @doc("The hash of the transaction.")
  hash: TransactionHash;

  @doc("The hash of the inner transaction. Only available for multisig transactions.")
  innerHash?: TransactionHash;
}