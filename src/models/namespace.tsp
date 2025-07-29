/**
 * Represents a NEM namespace.
 */
model NamespaceDTO {
  @doc("The fully qualified name of the namespace (namespace id).")
  fqn: Fqn;

  @doc("The owner account address of the namespace.")
  owner: Address;

  @doc("The height at which the ownership begins.")
  @example(13465)
  height: Height;
}

/**
 * Represents meta data for a namespace.
 */
model NamespaceMetaData {
  @doc("The database id for the namespace object.")
  @example(26264)
  id: int32;
}

/**
 * Represents a pair of namespace and its meta data.
 */
model NamespaceMetaDataPair {
  @doc("Contains the namespace meta data object.")
  meta: NamespaceMetaData;

  @doc("Contains the namespace object.")
  namespaceInfo: NamespaceDTO;
}

/**
 * Represents a provision namespace transaction.
 * Type code: 0x2001 (8193)
 */
model ProvisionNamespaceTransaction extends TransactionBase {
  @doc("Transaction type must be 0x2001 (8193).")
  type: TransactionType.ProvisionNamespace;

  @doc("The public key of the account to which the rental fee is transferred (hexadecimal string, 64 chars).")
  rentalFeeSink: PublicKey;

  @doc("The fee for renting the namespace in micro NEM.")
  @example(100000000)
  rentalFee: int64;

  @doc("The new part which is concatenated to the parent with a '.' as separator.")
  @example("vouchers")
  newPart: string;

  @doc("The parent namespace. This can be null if the transaction rents a root namespace.")
  @example("alice")
  parent?: string | null;
}
