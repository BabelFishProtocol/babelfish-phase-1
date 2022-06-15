pragma solidity ^0.5.0;

/**
 * A base contract to be inherited by any contract that want to receive relayed transactions
 * A subclass must use "msgSender()" instead of "msg.sender"
 */
contract BaseRelayRecipient {
    /*
     * Forwarder singleton we accept calls from
     */
    address internal _trustedForwarder;

    function isTrustedForwarder(address forwarder) public view returns (bool) {
        return forwarder == _trustedForwarder;
    }

    /**
     * return the sender of this call.
     * if the call came through our trusted forwarder, return the original sender.
     * otherwise, return `msg.sender`.
     * should be used in the contract anywhere instead of msg.sender
     */
    function _msgSender() internal view returns (address payable ret) {
        if (msg.data.length >= 20 && isTrustedForwarder(msg.sender)) {
            // At this point we know that the sender is a trusted forwarder,
            // so we trust that the last bytes of msg.data are the verified sender address.
            // extract sender address from the end of msg.data
            assembly {
                ret := shr(96, calldataload(sub(calldatasize(), 20)))
            }
        } else {
            ret = msg.sender;
        }
    }

    function versionRecipient() external pure returns (string memory) {
        return "2.2.3+opengsn.bsc.irelayrecipient";
    }
}