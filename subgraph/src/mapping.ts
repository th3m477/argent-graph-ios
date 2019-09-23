import {
  store,
  crypto,
  ByteArray,
  Address,
  EthereumEvent
} from "@graphprotocol/graph-ts"
import {
  GuardianAdditionRequested,
  GuardianRevokationRequested,
  GuardianAdditionCancelled,
  GuardianRevokationCancelled,
  GuardianAdded,
  GuardianRevoked
} from "../generated/Contract/Contract"
import { Guardian, PendingGuardian, GuardianActivity } from "../generated/schema"

function recordActivity(eventName: string, event: EthereumEvent, wallet: Address, guardian: Address): void {
  let id = event.transaction.hash.toHex() + ':' + event.logIndex.toString()
  let activity = new GuardianActivity(id)
  activity.wallet = wallet
  activity.address = guardian
  activity.state = eventName
  activity.date = event.block.timestamp
  activity.save()
}

function guardianId(wallet: Address, guardian: Address): string {
  let id = wallet.toHex().substr(2) + guardian.toHex().substr(2)
  let compoundId = ByteArray.fromHexString(id)
  return crypto.keccak256(compoundId).toHex()
}

export function handleGuardianAdditionRequested(
  event: GuardianAdditionRequested
): void {
  let wallet = event.params.wallet
  let address = event.params.guardian
  let guardian = new PendingGuardian(guardianId(wallet, address))
  guardian.wallet = wallet
  guardian.address = address
  guardian.addAfter = event.params.executeAfter
  guardian.save()

  recordActivity("requestedAddition", event, wallet, address)
}

export function handleGuardianRevokationRequested(
  event: GuardianRevokationRequested
): void {
  let wallet = event.params.wallet
  let address = event.params.guardian
  let guardian = new Guardian(guardianId(wallet, address))
  guardian.removeAfter = event.params.executeAfter
  guardian.save()

  recordActivity("requestedRevocation", event, wallet, address)
}

export function handleGuardianAdditionCancelled(
  event: GuardianAdditionCancelled
): void {
  let wallet = event.params.wallet
  let address = event.params.guardian
  store.remove("PendingGuardian", guardianId(wallet, address))

  recordActivity("canceledAddition", event, wallet, address)
}

export function handleGuardianRevokationCancelled(
  event: GuardianRevokationCancelled
): void {
  let wallet = event.params.wallet
  let address = event.params.guardian
  let guardian = new Guardian(guardianId(wallet, address))
  guardian.removeAfter = null
  guardian.save()

  recordActivity("canceledRevocation", event, wallet, address)
}

export function handleGuardianAdded(event: GuardianAdded): void {
  let wallet = event.params.wallet
  let address = event.params.guardian
  let gId = guardianId(wallet, address)
  let guardian = new Guardian(gId)
  guardian.wallet = event.params.wallet
  guardian.address = event.params.guardian
  guardian.save()

  store.remove("PendingGuardian", gId)

  recordActivity("added", event, wallet, address)
}

export function handleGuardianRevoked(event: GuardianRevoked): void {
  let wallet = event.params.wallet
  let address = event.params.guardian
  store.remove("Guardian", guardianId(wallet, address))

  recordActivity("revoked", event, wallet, address)
}