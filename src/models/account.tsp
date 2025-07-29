@doc("The harvesting status of an account.")
enum AccountStatus {
  LOCKED,
  UNLOCKED,
}

@doc("The remote harvesting status of an account.")
enum RemoteAccountStatus {
  ACTIVE,
  INACTIVE,
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
 * Account information structure.
 */
model AccountInfo {
  address: Address;

  @doc("The public key of the account (hexadecimal string, 64 characters). Null if the account has not published any transaction.")
  publicKey?: PublicKey | null;

  @doc("The account balance in micro NEM (integer).")
  @example(124446551689680)
  balance: int64;

  @doc("The vested part of the balance in micro NEM (integer).")
  @example(104443451691625)
  vestedBalance: int64;

  @doc("The importance score for the account (decimal number between 0 and 1).")
  @minValue(0)
  @maxValue(1)
  @example(0.010263666447108395)
  importance: float64;

  @doc("The number of blocks harvested by the account (integer, non-negative).")
  @minValue(0)
  @example(645)
  harvestedBlocks: int32;

  @doc("Account label (currently unused, always null in spec).")
  @example(null)
  label?: string | null;

  @doc("JSON object containing multisig information. Empty for non-multisig accounts.")
  multisigInfo: Record<unknown>;
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
  @example(0.001222376902598832)
  score?: float64;

  @doc("The page rank portion of the importance (decimal number between 0 and 1). Available if isSet is 1.")
  @minValue(0)
  @maxValue(1)
  @example(0.004252356221747241)
  ev?: float64;

  @doc("The height at which the importance calculation was performed. Available if isSet is 1.")
  @minValue(1)
  height?: Height;
}

/**
 * Represents an account's importance information.
 */
model AccountImportanceViewModel {
  @example("TD3RXTHBLK6J3UD2BH2PXSOFLPWZOTR34WCG4HXH")
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
  height: Height;

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
  @example(0.00008857563463531297)
  importance: float64;

  @doc("The page rank part of the importance (decimal number between 0 and 1).")
  @minValue(0)
  @maxValue(1)
  @example(0.0007605047835049349)
  pageRank: float64;
}

/**
 * Represents the meta data of an account, including harvesting status and multisig information.
 */
model AccountMetaData {
  @doc("""
The harvesting status of a queried account. The harvesting status can be one of the following values:
  "UNKNOWN": The harvesting status of the account is not known.
  "LOCKED": The account is not harvesting.
  "UNLOCKED": The account is harves
""")
  @example(AccountStatus.LOCKED)
  status: AccountStatus;

  @doc("""
The status of remote harvesting of a queried account. The remote harvesting status can be one of the following values:
  "REMOTE": The account is a remote account and therefore remoteStatus is not applicable for it.
  "ACTIVATING": The account has activated remote harvesting but it is not yet active.
  "ACTIVE": The account has activated remote harvesting and remote harvesting is active.
  "DEACTIVATING": The account has deactivated remote harvesting but remote harvesting is still active.
  "INACTIVE": The account has inactive remote harvesting, or it has deactivated remote harvesting and deactivation is operational.
""")
  @example(RemoteAccountStatus.ACTIVE)
  remoteStatus: RemoteAccountStatus;

  @doc("JSON array of AccountInfo structures. The account is cosignatory for each of the accounts in the array.")
  cosignatoryOf: AccountInfo[];

  @doc("JSON array of AccountInfo structures. The array holds all accounts that are a cosignatory for this account.")
  cosignatories: AccountInfo[];
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
  @example("0962c6505d02123c40e858ff8ef21e2b7b5466be12c4770e3bf557aae828390f")
  privateKey: PrivateKey;

  @doc("The public key of the account as hexadecimal string.")
  @example("c2e19751291d01140e62ece9ee3923120766c6302e1099b04014fe1009bc89d3")
  publicKey: PublicKey;

  @doc("The address of the account.")
  @example("NCKMNCU3STBWBR7E3XD2LR7WSIXF5IVJIDBHBZQT")
  address: Address;
}

