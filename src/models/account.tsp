/**
 * Account information structure.
 */
model AccountInfo {
  address: Address;

  @doc("The public key of the account (hexadecimal string, 64 characters). Null if the account has not published any transaction.")
  publicKey?: PublicKey | null;

  @doc("The account balance in micro NEM (integer).")
  balance: int64;

  @doc("The vested part of the balance in micro NEM (integer).")
  vestedBalance: int64;

  @doc("The importance score for the account (decimal number between 0 and 1).")
  @minValue(0)
  @maxValue(1)
  importance: float64;

  @doc("The number of blocks harvested by the account (integer, non-negative).")
  @minValue(0)
  harvestedBlocks: int32;

  @doc("Account label (currently unused, always null in spec).")
  label?: string | null;
}

/**
 * Indicates if a value is available.
 */
enum ValueAvailability {
  /** The value is not available. */
  NotAvailable: 0,
  /** The value is available. */
  Available: 1,
}

/**
 * Represents the importance details of an account.
 */
model AccountImportance {
  @doc("Indicates if the score, ev, and height fields are available (0 or 1).")
  isSet: ValueAvailability;

  @doc("The importance of the account (decimal number between 0 and 1). Available if isSet is 1.")
  @minValue(0)
  @maxValue(1)
  score?: float64;

  @doc("The page rank portion of the importance (decimal number between 0 and 1). Available if isSet is 1.")
  @minValue(0)
  @maxValue(1)
  ev?: float64;

  @doc("The height at which the importance calculation was performed. Available if isSet is 1.")
  @minValue(1)
  height?: int64;
}

/**
 * Represents an account's importance information.
 */
model AccountImportanceViewModel {
  address: Address;

  @doc("Substructure that describes the importance of the account.")
  importance: AccountImportance;
}

/**
 * Represents historical account data at a specific height.
 */
model AccountHistoricalDataViewModel {
  @doc("The height for which the data is valid.")
  @minValue(1)
  height: int64;

  @doc("The address of the account.")
  address: Address;

  @doc("The balance of the account in micro NEM.")
  balance: int64;

  @doc("The vested part of the balance in micro NEM.")
  vestedBalance: int64;

  @doc("The unvested part of the balance in micro NEM.")
  unvestedBalance: int64;

  @doc("The importance of the account (decimal number between 0 and 1).")
  @minValue(0)
  @maxValue(1)
  importance: float64;

  @doc("The page rank part of the importance (decimal number between 0 and 1).")
  @minValue(0)
  @maxValue(1)
  pageRank: float64;
}

/**
 * Represents the meta data of an account, including harvesting status and multisig information.
 */
model AccountMetaData {
  @doc("The harvesting status of the account.")
  status: string;

  @doc("The status of remote harvesting.")
  remoteStatus: string;

  @doc("Array of AccountInfo structures that describe the multisig accounts that this account is cosignatory of.")
  cosignatoryOf: AccountInfo[];
}

/**
 * Represents a pair of account information and its meta data.
 */
model AccountMetaDataPair {
  @doc("Contains the account object.")
  account: AccountInfo;

  @doc("Contains the account meta data object.")
  meta: AccountMetaData;
}

/**
 * Contains information about a new account's key pair and address.
 */
model KeyPairViewModel {
  @doc("The private key of the account as hexadecimal string.")
  privateKey: PrivateKey;

  @doc("The public key of the account as hexadecimal string.")
  publicKey: PublicKey;

  @doc("The address of the account.")
  address: Address;
}