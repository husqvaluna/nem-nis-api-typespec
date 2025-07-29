@pattern("^[T|N][A-Z0-9]{39}$")
@doc("The account address. Base32 encoded, 40 characters. Starts with 'T' (testnet) or 'N' (mainnet).")
@example("TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS")
scalar Address extends string;

@format("hex")
@maxLength(64)
@doc("The private key as hexadecimal string (64 chars).")
@example("0962c6505d02123c40e858ff8ef21e2b7b5466be12c4770e3bf557aae828390f")
scalar PrivateKey extends string;

@format("hex")
@maxLength(64)
@doc("The public key as hexadecimal string (64 chars). Used to identify an account and verify signatures.")
@example("a1aaca6c17a24252e674d155713cdf55996ad00175be4af02a20c67b59f9fe8a")
scalar PublicKey extends string;

@pattern("^[a-f0-9]{64}$")
@format("hex")
@doc("A 64-character hexadecimal string.")
@example("15c373ad4c3fe6af47d1941379ff262f785bdcfa07c02ac3608bc10da27d5e82")
scalar Hash extends string;

@doc("Fully qualified name (e.g., nem.xem).")
@example("makoto.metal.coins")
scalar Fqn extends string;

@minValue(1)
@doc("Height of the blockchain.")
@example(42799)
scalar Height extends int64;

@pattern("^[a-f0-9]{128}$")
@format("hex")
@doc("A 128-character hexadecimal string representing a signature.")
@example("651a19ccd09c1e0f8b25f6a0aac5825b0a20f158ca4e0d78f2abd904a3966b6e3599a47b9ff199a3a6e1152231116fa4639fec684a56909c22cbf6db66613901")
scalar Signature extends string;

@maxLength(2048)
@format("hex")
@doc("A message payload as a hexadecimal string (max 2048 chars).")
@example("280000005444334b32493543524850595634425a5a5a4c335850454e4")
scalar MessagePayloadString extends string;
