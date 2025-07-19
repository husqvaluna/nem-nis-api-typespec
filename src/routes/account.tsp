import "@typespec/http";

import "../types/core.tsp";
import "../models";

using Http;

@tag("account")
@route("/account")
namespace Nem.Account {
  @post
  @route("/lock")
  @summary("Locking the account (stops harvesting)")
  @doc("Locks the account, which stops the harvesting process. This operation typically requires the account's private key.")
  op lockAccount(
    @body body: {
      privateKey?: HttpPart<string>;
    },
  ): Body<NemRequestResult>;

  @post
  @route("/unlock")
  @summary("Unlocking the account (enables harvesting)")
  @doc("Unlocks the account, enabling the harvesting process. This operation typically requires the account's private key.")
  op unlockAccount(
    @body body: {
      privateKey?: HttpPart<string>;
    },
  ): Body<NemRequestResult>;

  @post
  @route("/unlocked/info")
  @summary("Retrieving the unlock info")
  @doc("Retrieves information about the unlock status of the account, indicating whether it is currently harvesting.")
  op getAccountUnlockInfo(): Body<NemRequestResult>;

  @get
  @route("/generate")
  @summary("Generating new account data")
  @doc("Generates a new NEM account, returning its private key, public key, and address.")
  op generateAccount(): Body<KeyPairViewModel>;

  @get
  @route("/get")
  @summary("Requesting the account data")
  @doc("Retrieves the account information and its metadata for a given account address.")
  op getAccountInfo(@query(#{ explode: true }) address: Address): AccountMetaDataPair;

  @get
  @route("/get/from-public-key")
  @summary("Requesting the account data (public key variant)")
  @doc("Retrieves the account information and its metadata for a given public key.")
  op getAccountInfoFromPublicKey(@query(#{ explode: true }) publicKey?: PublicKey): AccountMetaDataPair;

  @get
  @route("/get/forwarded")
  @summary("Requesting the original account data for a delegate account")
  @doc("Retrieves the original account data for a delegate account, which is an account that has delegated its importance to another account.")
  op getAccountInfoForwarded(@query(#{ explode: true }) address?: Address): AccountMetaDataPair;

  @get
  @route("/get/forwarded/from-public-key")
  @summary("Requesting the original account data for a delegate account (public key variant)")
  @doc("Retrieves the original account data for a delegate account using its public key.")
  op getAccountInfoForwardedFromPublicKey(@query(#{ explode: true }) PublicKey?: PublicKey): AccountMetaDataPair;

  @get
  @route("/status")
  @summary("Requesting the account status")
  @doc("Retrieves the current status of an account, including its harvesting status and multisig information.")
  op getAccountStatus(@query(#{ explode: true }) address?: Address): AccountMetaData;

  @get
  @route("/transfers/incoming")
  @summary("Incoming transactions")
  @doc("Retrieves a list of incoming transactions for a given account address.")
  op getAccountIncomingTransfers(
    @query(#{ explode: true }) address: Address,
    @query(#{ explode: true }) hash?: string,
  ): Body<TransactionMetaDataPair[]>;

  @get
  @route("/transfers/outgoing")
  @summary("Outgoing transactions")
  @doc("Retrieves a list of outgoing transactions for a given account address.")
  op getAccountOutgoingTransfers(
    @query(#{ explode: true }) address?: Address,
    @query(#{ explode: true }) hash?: string,
  ): {};

  @get
  @route("/transfers/all")
  @summary("All transactions")
  @doc("Retrieves a list of all transactions (incoming and outgoing) for a given account address.")
  op getAccountAllTransfers(
    @query(#{ explode: true }) address?: Address,
    @query(#{ explode: true }) hash?: string,
  ): Body<TransactionMetaDataPair[]>;

  @get
  @route("/unconfirmedTransactions")
  @summary("Unconfirmed transactions")
  @doc("Retrieves a list of unconfirmed transactions for a given account address.")
  op getAccountUnconfirmedTransactions(@query(#{ explode: true }) address?: string): Body<UnconfirmedTransactionMetaDataPair[]>;

  @get
  @route("/harvests")
  @summary("Requesting harvest info data for an account")
  @doc("Retrieves harvest information for a given account, including details about blocks harvested.")
  op getAccountHarvests(
    @query(#{ explode: true }) address?: Address,
    @query(#{ explode: true }) hash?: string,
  ): Body<TransactionMetaDataPair[]>;

  @get
  @route("/importances")
  @summary("Retrieving account importances for accounts")
  @doc("Retrieves a list of account importances for all accounts or a specific account.")
  op getAccountImportances(): Body<AccountImportanceViewModel[]>;

  @get
  @route("/namespace/page")
  @summary("Retrieving namespaces that an account owns")
  op getAccountNamespaces(
    @query(#{ explode: true }) address?: Address,
    @query(#{ explode: true }) parent?: string,
  ): Body<NamespaceMetaDataPair[]>;

  @get
  @route("/mosaic/definition/page")
  @summary("Retrieving mosaic definitions that an account has created")
  op getAccountMosaicDefinitions(
    @query(#{ explode: true }) address?: Address,
    @query(#{ explode: true }) parent?: string,
  ): Body<MosaicDefinitionMetaDataPair[]>;

  @get
  @route("/mosaic/owned")
  @summary("Retrieving mosaics that an account owns")
  op getAccountOwnedMosaics(@query(#{ explode: true }) address?: Address): Body<Mosaic[]>;

  @get
  @route("/historical/get")
  @summary("Retrieving historical account data")
  @doc("Retrieves historical information for an account, including balance and importance data. This feature is optional and depends on the NIS configuration (HISTORICAL_ACCOUNT_DATA).")
  op getAccountHistoricalData(
    @query(#{ explode: true }) address?: Address,
    @query(#{ explode: true }) startHeight?: integer,
    @query(#{ explode: true }) endHeight?: integer,
    @query(#{ explode: true }) increment?: integer,
  ): Body<AccountHistoricalDataViewModel[]>;
}
