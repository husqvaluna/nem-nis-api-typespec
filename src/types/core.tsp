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
@example("c2e19751291d01140e62ece9ee3923120766c6302e1099b04014fe1009bc89d3")
scalar PublicKey extends string;

@pattern("^[a-f0-9]{64}$")
@format("hex")
@doc("A 64-character hexadecimal string.")
@example("949583a20ebdfdcb58277eb42fef3e66e9e6bbfc47304d8741a82c68f7c53a22")
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
@example("449cd76ea8bda2220b3d6ad6f8db5f81d4e68ad3d4b0c3db9a3c267355657639eabed3dbcef8e0cc22953ae2b36a22ee7dc6327484c9649cccd686a511eca105")
scalar Signature extends string;

@maxLength(2048)
@format("hex")
@doc("A message payload as a hexadecimal string (max 2048 chars).")
@example("280000005444334b32493543524850595634425a5a5a4c335850454e4")
scalar MessagePayloadString extends string;
