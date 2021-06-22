pragma solidity 0.7.5;

import "@openzeppelin/contracts/utils/Context.sol";
import "./IRelayRecipient.sol";

/**
 * @title BaseRelayRecipient
 * @dev A base contract to be inherited by any contract that want to receive relayed transactions
 * A subclass must use "_msgSender()" instead of "msg.sender"
 */
abstract contract BaseRelayRecipient is IRelayRecipient, Context {
    function trustedForwarder() public view returns (address forwarder) {
        assembly {
            // bytes32(uint256(keccak256('gsn.trustedForwarder')))
            forwarder := sload(0x7f6d43cd94d5a48725c9a80b72b83bbdb80ef2feb98fcf5461b698486de60deb)
        }
    }

    function isTrustedForwarder(address forwarder) public view override returns (bool) {
        return forwarder == trustedForwarder();
    }

    function versionRecipient() external view override returns (string memory) {
        return "1.0.0";
    }

    function _setTrustedForwarder(address _forwarder) internal {
        assembly {
            // bytes32(uint256(keccak256('gsn.trustedForwarder')))
            sstore(0x7f6d43cd94d5a48725c9a80b72b83bbdb80ef2feb98fcf5461b698486de60deb, _forwarder)
        }
    }

    /**
     * return the sender of this call.
     * if the call came through our trusted forwarder, return the original sender.
     * otherwise, return `msg.sender`.
     * should be used in the contract anywhere instead of msg.sender
     */
    function _msgSender() internal view virtual override(Context, IRelayRecipient) returns (address payable ret) {
        if (msg.data.length >= 20 && isTrustedForwarder(msg.sender)) {
            // At this point we know that the sender is a trusted forwarder,
            // so we trust that the last bytes of msg.data are the verified sender address.
            // extract sender address from the end of msg.data
            assembly {
                ret := shr(96, calldataload(sub(calldatasize(), 20)))
            }
        } else {
            return msg.sender;
        }
    }

    /**
     * return the msg.data of this call.
     * if the call came through our trusted forwarder, then the real sender was appended as the last 20 bytes
     * of the msg.data - so this method will strip those 20 bytes off.
     * otherwise, return `msg.data`
     * should be used in the contract instead of msg.data, where the difference matters (e.g. when explicitly
     * signing or hashing the
     */
    function _msgData() internal view virtual override(Context, IRelayRecipient) returns (bytes memory ret) {
        if (msg.data.length >= 24 && isTrustedForwarder(msg.sender)) {
            // At this point we know that the sender is a trusted forwarder,
            // we copy the msg.data , except the last 20 bytes (and update the total length)
            assembly {
                let ptr := mload(0x40)
                // copy only size-20 bytes
                let size := sub(calldatasize(), 20)
                // structure RLP data as <offset> <length> <bytes>
                mstore(ptr, 0x20)
                mstore(add(ptr, 32), size)
                calldatacopy(add(ptr, 64), 0, size)
                return(ptr, add(size, 64))
            }
        } else {
            return msg.data;
        }
    }
}