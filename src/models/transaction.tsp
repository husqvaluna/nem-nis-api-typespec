/**
 * The type of a message payload.
 */
enum MessageType {
  @doc("An unencrypted message.")
  Unencrypted: 1,

  @doc("An encrypted message.")
  Encrypted: 2,
}

@doc("The type of a transaction.")
enum TransactionType {
  Transfer: 0x101,
  ImportanceTransfer: 0x801,
  MultisigAggregateModification: 0x1001,
  MultisigSignature: 0x1002,
  Multisig: 0x1003,
  ProvisionNamespace: 0x2001,
  MosaicDefinition: 0x4001,
  MosaicSupplyChange: 0x4002,
}

@doc("The network version of a transaction.")
enum NetworkVersion {
  Mainnet: 1744830465,
  Testnet: -1744830463,
  Mijin: 1610612737,
}

@doc("The mode of an importance transfer.")
enum ImportanceTransferMode {
  Activate: 1,
  Deactivate: 2,
}

@doc("The type of a multisig cosignatory modification.")
enum CosignatoryModificationType {
  Add: 1,
  Delete: 2,
}

/**
 * Transaction meta data structure.
 */
model TransactionMetaData {
  @doc("The height of the block in which the transaction was included.")
  height: Height;

  @doc("The database id of the transaction.")
  @example(71245)
  id: int32;

  @doc("The hash of the transaction.")
  hash: Hash;
}

/**
 * Base model for all transaction types.
 */
model TransactionBase {
  @doc("Number of seconds elapsed since the creation of the nemesis block.")
  @example(9106400)
  timeStamp: int32;

  @doc("Transaction signature (hexadecimal string, 128 chars). Missing if part of a multisig transaction.")
  signature?: Signature;

  @doc("Transaction fee in micro NEM.")
  @example(3000000)
  fee: int64;

  @doc("Transaction type code (integer).")
  type: TransactionType;

  @doc("Deadline in seconds elapsed since the creation of the nemesis block.")
  @example(9149600)
  deadline: int32;

  @doc("Transaction structure version. Network dependent (e.g., mainnet: 0x68000001, testnet: 0x98000001).")
  version: NetworkVersion;

  @doc("Public key of the account that created the transaction (hexadecimal string, 64 chars).")
  signer: PublicKey;
}

/**
 * Represents a version 1 transfer transaction (XEM transfer).
 * Type code: 0x101 (257)
 */
model TransferTransactionV1 extends TransactionBase {
  @doc("Transaction type must be 0x101 (257).")
  type: TransactionType.Transfer;

  @doc("Recipient account address.")
  @example("TBOBBSXX7BESJXDWGLP5Z7FM5HSTKUH5WIMPW562")
  recipient: Address;

  @doc("Amount transferred in micro NEM.")
  @example(1000000000)
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
  type: TransactionType.Transfer;

  @doc("Recipient account address.")
  @example("TBOBBSXX7BESJXDWGLP5Z7FM5HSTKUH5WIMPW562")
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
  type: TransactionType.ImportanceTransfer;

  @doc("The mode of the importance transfer (1: Activate, 2: Deactivate).")
  mode: ImportanceTransferMode;

  @doc("The public key of the remote account (hexadecimal string, 64 chars).")
  remoteAccount: PublicKey;
}

/**
 * Represents a modification to a multisig account's cosignatories.
 */
model MultisigCosignatoryModification {
  @doc("The type of modification (1: Add, 2: Delete).")
  modificationType: CosignatoryModificationType;

  @doc("The public key of the cosignatory account (hexadecimal string, 64 chars).")
  cosignatoryAccount: PublicKey;
}

/**
 * Represents a modification to the minimum number of cosignatories required for a multisig account.
 */
model MultisigMinimumCosignatoriesModification {
  @doc("Value indicating the relative change of the minimum cosignatories.")
  @example(2)
  relativeChange: int32;
}

/**
 * Represents a multisig aggregate modification transaction.
 * Type code: 0x1001 (4097)
 */
model MultisigAggregateModificationTransaction extends TransactionBase {
  @doc("Transaction type must be 0x1001 (4097).")
  type: TransactionType.MultisigAggregateModification;

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
  type: TransactionType.MultisigSignature;

  @doc("The hash of the inner transaction of the corresponding multisig transaction.")
  otherHash: Hash;

  @doc("The address of the corresponding multisig account.")
  otherAccount: Address;
}

/**
 * Represents a multisig transaction.
 * Type code: 0x1003 (4099)
 */
model MultisigTransaction extends TransactionBase {
  @doc("Transaction type must be 0x1003 (4099).")
  type: TransactionType.Multisig;

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
  @example(12345)
  id: int32;

  @doc("The hash of the transaction.")
  hash: Hash;
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
 * Represents the message payload within a transaction.
 */
model MessagePayload {
  @doc("Message type (1: unencrypted, 2: encrypted).")
  type: MessageType;

  @doc("The message content (hexadecimal string). Max 1024 bytes (2048 hex chars).")
  @maxLength(2048)
  @format("hex")
  @example("474F4F44204C55434B21")
  payload: string;
}

/**
 * Request object for preparing and announcing a transaction.
 */
model RequestPrepareAnnounce {
  @doc("The transaction object to be announced. Contains transaction data without signature.")
  transaction: TransferTransaction | ImportanceTransferTransaction | MultisigAggregateModificationTransaction | MultisigSignatureTransaction | MultisigTransaction | ProvisionNamespaceTransaction | unknown;
}

/**
 * Request object for announcing an already signed transaction.
 */
model RequestAnnounce {
  @doc("The transaction data as hexadecimal string.")
  @format("hex")
  data: string;

  @doc("The signature of the transaction as hexadecimal string.")
  signature: Signature;
}
