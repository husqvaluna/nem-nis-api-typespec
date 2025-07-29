/**
 * The type of a mosaic levy.
 */
enum MosaicLevyType {
  @doc("An absolute fee.")
  Absolute: 1,

  @doc("A percentile fee.")
  Percentile: 2,
}

/**
 * Represents a mosaic identifier.
 */
model MosaicId {
  @doc("The namespace id of the mosaic.")
  @example("alice.drinks")
  namespaceId: Fqn;

  @doc("The name of the mosaic within the namespace.")
  @example("orange juice")
  name: string;
}

/**
 * Represents an instance of a mosaic.
 */
model Mosaic {
  @doc("The mosaic id.")
  mosaicId: MosaicId;

  @doc("The mosaic quantity in smallest units.")
  @example(123)
  quantity: int64;
}

/**
 * Represents a mosaic levy (additional fee on transfer).
 */
model MosaicLevy {
  @doc("The levy type (1: absolute fee, 2: percentile fee).")
  type: MosaicLevyType;

  @doc("The recipient account address of the levy.")
  recipient: Address;

  @doc("The mosaic in which the levy is paid.")
  mosaicId: MosaicId;

  @doc("The fee quantity. Interpretation depends on the levy type.")
  @example(10)
  fee: int64;
}

/**
 * Represents a mosaic property.
 */
model MosaicProperty {
  @doc("The name of the property (e.g., `divisibility`, `initialSupply`, `supplyMutable`, `transferable`).")
  @example("divisibility")
  name: string;

  @doc("The value of the property.")
  @example("0")
  value: string;
}

/**
 * Represents a mosaic definition.
 */
model MosaicDefinition {
  @doc("The public key of the mosaic definition creator (hexadecimal string, 64 chars).")
  creator: PublicKey;

  @doc("The description of the mosaic.")
  @example("silver coin")
  description: string;

  @doc("The identifier of the mosaic.")
  id: MosaicId;

  @doc("Array of mosaic properties.")
  properties: MosaicProperty[];

  @doc("The optional levy for the mosaic.")
  levy?: MosaicLevy;
}

/**
 * Represents meta data for a mosaic definition.
 */
model MosaicDefinitionMetaData {
  @doc("The id for the mosaic definition object.")
  @example(3541)
  id: int32;
}

/**
 * Represents a pair of mosaic definition and its meta data.
 */
model MosaicDefinitionMetaDataPair {
  @doc("Contains the mosaic definition meta data object.")
  meta: MosaicDefinitionMetaData;

  @doc("Contains the mosaic definition object.")
  mosaic: MosaicDefinition;
}

/**
 * Represents a mosaic definition creation transaction.
 * Type code: 0x4001 (16385)
 */
model MosaicDefinitionCreationTransaction extends TransactionBase {
  @doc("Transaction type must be 0x4001 (16385).")
  type: TransactionType.MosaicDefinition;

  @doc("The public key of the account to which the creation fee is transferred (hexadecimal string, 64 chars).")
  creationFeeSink: PublicKey;

  @doc("The fee for creating the mosaic definition in micro NEM.")
  @example(500000000)
  creationFee: int64;

  @doc("The mosaic definition object to be created.")
  mosaicDefinition: MosaicDefinition;
}

/**
 * Represents a mosaic supply change transaction.
 * Type code: 0x4002 (16386)
 */
model MosaicSupplyChangeTransaction extends TransactionBase {
  @doc("Transaction type must be 0x4002 (16386).")
  type: TransactionType.MosaicSupplyChange;

  @doc("The mosaic identifier of the mosaic to modify.")
  mosaicId: MosaicId;

  @doc("The type of supply change (1: increase supply, 2: decrease supply).")
  @example(1)
  supplyType: int32;

  @doc("The amount by which to change the supply in micro mosaic units.")
  @example(1234)
  delta: int64;
}
