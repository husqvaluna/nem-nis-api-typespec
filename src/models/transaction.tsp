/**
 * Represents the hash of a transaction.
 */
model TransactionHash {
  @doc("The transaction hash data as a hexadecimal string.")
  @format("hex")
  data: string;
}

/**
 * Transaction meta data structure.
 */
model TransactionMetaData {
  @doc("The height of the block in which the transaction was included.")
  @minValue(1)
  height: int64;

  @doc("The database id of the transaction.")
  id: int32;

  @doc("The hash of the transaction.")
  hash: TransactionHash;
}

/**
 * Base model for all transaction types.
 */
model TransactionBase {
  @doc("Number of seconds elapsed since the creation of the nemesis block.")
  timeStamp: int32;

  @doc("Transaction signature (hexadecimal string, 128 chars). Missing if part of a multisig transaction.")
  @pattern("^[a-f0-9]{128}$")
  @format("hex")
  signature?: string;

  @doc("Transaction fee in micro NEM.")
  fee: int64;

  @doc("Transaction type code (integer).")
  type: int32;

  @doc("Deadline in seconds elapsed since the creation of the nemesis block.")
  deadline: int32;

  @doc("Transaction structure version. Network dependent (e.g., mainnet: 0x68000001, testnet: 0x98000001).")
  version: int32;

  @doc("Public key of the account that created the transaction (hexadecimal string, 64 chars).")
  @pattern("^[a-f0-9]{64}$")
  @format("hex")
  signer: string;
}

/**
 * Represents a version 1 transfer transaction (XEM transfer).
 * Type code: 0x101 (257)
 */
model TransferTransactionV1 extends TransactionBase {
  @doc("Transaction type must be 0x101 (257).")
  type: 257;

  @doc("Recipient account address.")
  recipient: Address;

  @doc("Amount transferred in micro NEM.")
  amount: int64;

  @doc("Optional message payload.")
  message?: MessagePayload;
}

/**
 * Represents a version 2 transfer transaction (Mosaic transfer).
 * Type code: 0x101 (257)
 */
model TransferTransactionV2 extends TransactionBase {
  @doc("Transaction type must be 0x101 (257).")
  type: 257;

  @doc("Recipient account address.")
  recipient: Address;

  @doc("Optional message payload.")
  message?: MessagePayload;

  @doc("Array of mosaics being transferred.")
  mosaics: Mosaic[];
}

/**
 * Union type representing either V1 or V2 Transfer Transaction.
 */
union TransferTransaction {
  v1: TransferTransactionV1,
  v2: TransferTransactionV2,
}

/**
 * Represents an importance transfer transaction.
 * Type code: 0x801 (2049)
 */
model ImportanceTransferTransaction extends TransactionBase {
  @doc("Transaction type must be 0x801 (2049).")
  type: 2049;

  @doc("The mode of the importance transfer (1: Activate, 2: Deactivate).")
  mode: 1 | 2;

  @doc("The public key of the remote account (hexadecimal string, 64 chars).")
  remoteAccount: PublicKey;
}

/**
 * Represents a modification to a multisig account's cosignatories.
 */
model MultisigCosignatoryModification {
  @doc("The type of modification (1: Add, 2: Delete).")
  modificationType: 1 | 2;

  @doc("The public key of the cosignatory account (hexadecimal string, 64 chars).")
  cosignatoryAccount: PublicKey;
}

/**
 * Represents a modification to the minimum number of cosignatories required for a multisig account.
 */
model MultisigMinimumCosignatoriesModification {
  @doc("Value indicating the relative change of the minimum cosignatories.")
  relativeChange: int32;
}

/**
 * Represents a multisig aggregate modification transaction.
 * Type code: 0x1001 (4097)
 */
model MultisigAggregateModificationTransaction extends TransactionBase {
  @doc("Transaction type must be 0x1001 (4097).")
  type: 4097;

  @doc("Array of multisig cosignatory modifications.")
  modifications: MultisigCosignatoryModification[];

  @doc("JSON object that holds the minimum cosignatories modification.")
  minCosignatories?: MultisigMinimumCosignatoriesModification;
}

/**
 * Represents a multisig signature transaction.
 * Type code: 0x1002 (4098)
 */
model MultisigSignatureTransaction extends TransactionBase {
  @doc("Transaction type must be 0x1002 (4098).")
  type: 4098;

  @doc("The hash of the inner transaction of the corresponding multisig transaction.")
  otherHash: TransactionHash;

  @doc("The address of the corresponding multisig account.")
  otherAccount: Address;
}

/**
 * Represents a multisig transaction.
 * Type code: 0x1003 (4099)
 */
model MultisigTransaction extends TransactionBase {
  @doc("Transaction type must be 0x1003 (4099).")
  type: 4099;

  @doc("The inner transaction. Can be a TransferTransaction, ImportanceTransferTransaction, or MultisigAggregateModificationTransaction. The inner transaction does not have a valid signature.")
  otherTrans: TransferTransaction | ImportanceTransferTransaction | MultisigAggregateModificationTransaction | unknown;

  @doc("The JSON array of MultisigSignatureTransaction objects.")
  signatures: MultisigSignatureTransaction[];
}

/**
 * Structure containing transaction data and its meta data.
 */
model TransactionMetaDataPair {
  @doc("The meta data of the transaction.")
  meta: TransactionMetaData;

  @doc("The actual transaction object. The specific type depends on the transaction type field within.")
  transaction: TransferTransaction | ImportanceTransferTransaction | MultisigAggregateModificationTransaction | MultisigSignatureTransaction | MultisigTransaction | unknown;
}

/**
 * Represents meta data for an unconfirmed transaction.
 */
model UnconfirmedTransactionMetaData {
  @doc("The database id of the transaction.")
  id: int32;

  @doc("The hash of the transaction.")
  hash: TransactionHash;
}

/**
 * Represents a pair of unconfirmed transaction and its meta data.
 */
model UnconfirmedTransactionMetaDataPair {
  @doc("Contains the unconfirmed transaction meta data object.")
  meta: UnconfirmedTransactionMetaData;

  @doc("Contains the transaction object. The specific type depends on the transaction type field within.")
  transaction: TransferTransaction | ImportanceTransferTransaction | MultisigAggregateModificationTransaction | MultisigSignatureTransaction | MultisigTransaction | unknown;
}

/**
 * The type of a message payload.
 */
enum MessageType {
  /** An unencrypted message. */
  Unencrypted: 1,
  /** An encrypted message. */
  Encrypted: 2,
}

/**
 * Represents the message payload within a transaction.
 */
model MessagePayload {
  @doc("Message type (1: unencrypted, 2: encrypted).")
  type: MessageType;

  @doc("The message content (hexadecimal string). Max 1024 bytes (2048 hex chars).")
  @maxLength(2048)
  @format("hex")
  payload: string;
}