/**
 * Represents a mosaic identifier.
 */
model MosaicId {
  @doc("The namespace id of the mosaic.")
  namespaceId: string;

  @doc("The name of the mosaic within the namespace.")
  name: string;
}

/**
 * Represents an instance of a mosaic.
 */
model Mosaic {
  @doc("The mosaic id.")
  mosaicId: MosaicId;

  @doc("The mosaic quantity in smallest units.")
  quantity: int64;
}

/**
 * The type of a mosaic levy.
 */
enum MosaicLevyType {
  /** An absolute fee. */
  Absolute: 1,
  /** A percentile fee. */
  Percentile: 2,
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
  fee: int64;
}

/**
 * Represents a mosaic property.
 */
model MosaicProperty {
  @doc("The name of the property (e.g., \"divisibility\", \"initialSupply\", \"supplyMutable\", \"transferable\").")
  name: string;

  @doc("The value of the property.")
  value: string;
}

/**
 * Represents a mosaic definition.
 */
model MosaicDefinition {
  @doc("The public key of the mosaic definition creator (hexadecimal string, 64 chars).")
  creator: PublicKey;

  @doc("The description of the mosaic.")
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