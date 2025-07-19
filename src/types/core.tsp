@doc("The account address. Base32 encoded, 40 characters. Starts with 'T' (testnet) or 'N' (mainnet).")
@pattern("^[T|N][A-Z0-9]{39}$")
scalar Address extends string;

@doc("The private key as hexadecimal string (64 chars).")
@format("hex")
@maxLength(64)
scalar PrivateKey extends string;

@format("hex")
@maxLength(64)
@doc("The public key as hexadecimal string (64 chars). Used to identify an account and verify signatures.")
scalar PublicKey extends string;

@doc("A 64-character hexadecimal string.")
@pattern("^[a-f0-9]{64}$")
@format("hex")
scalar HexHash64 extends string;

@doc("A 128-character hexadecimal string representing a signature.")
@pattern("^[a-f0-9]{128}$")
@format("hex")
scalar Signature extends string;

@doc("A message payload as a hexadecimal string (max 2048 chars).")
@maxLength(2048)
@format("hex")
scalar MessagePayloadString extends string;
