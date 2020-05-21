import { BigInt } from "@graphprotocol/graph-ts"
import { log } from '@graphprotocol/graph-ts'
import {
  AddedToWhitelist,
  RemovedFromWhitelist
} from "../generated/TransferManager/TransferManager"
import { Wallet, WhitelistedAddress } from "../generated/schema"

export function handleAddedToWhitelist(event: AddedToWhitelist): void {
  let entityId = event.params.wallet.toHex() + ':' + event.params.target.toHex()
  let entity = new WhitelistedAddress(entityId)

  entity.address = event.params.target
  entity.activeAfter = event.params.whitelistAfter;
  log.debug('WhitelistedAddress entity wallet, address, activeAfter', [entity.wallet, entity.address.toHexString(), entity.activeAfter.toString()]);

  let walletId = event.params.wallet.toHex()
  let wallet = Wallet.load(walletId)
  if (wallet == null) {
    wallet = new Wallet(walletId)
  }

  log.debug('Wallet entity', [wallet.id])

  let walletWhitelist = wallet.whitelist || []
  walletWhitelist.push(entityId)
  wallet.whitelist = walletWhitelist

  entity.save()
  wallet.save()


  // Note: If a handler doesn't require existing field values, it is faster
  // _not_ to load the entity from the store. Instead, create it fresh with
  // `new Entity(...)`, set the fields that should be updated and save the
  // entity back to the store. Fields that were not set or unset remain
  // unchanged, allowing for partial updates to be applied.

  // It is also possible to access smart contracts from mappings. For
  // example, the contract that has emitted the event can be connected to
  // with:
  //
  // let contract = Contract.bind(event.address)
  //
  // The following functions can then be called on this contract to access
  // state variables and other data:
  //
  // - contract.securityWindow(...)
  // - contract.isValidSignature(...)
  // - contract.isValidSignature(...)
  // - contract.getNonce(...)
  // - contract.getCurrentLimit(...)
  // - contract.getDailyUnspent(...)
  // - contract.securityPeriod(...)
  // - contract.oldLimitManager(...)
  // - contract.transferStorage(...)
  // - contract.getPendingLimit(...)
  // - contract.execute(...)
  // - contract.isWhitelisted(...)
  // - contract.priceProvider(...)
  // - contract.relayer(...)
  // - contract.isOnlyOwnerModule(...)
  // - contract.getPendingTransfer(...)
  // - contract.defaultLimit(...)
  // - contract.isLimitDisabled(...)
}

export function handleRemovedFromWhitelist(event: RemovedFromWhitelist): void {}
