// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract CrossBorderEscrow is ReentrancyGuard {
    enum State { Created, Funded, Disbursed, Disputed, Refunded }

    struct EscrowTransaction {
        address buyer;
        address seller;
        IERC20 token;
        uint256 amount;
        State state;
    }

    mapping(bytes32 => EscrowTransaction) public escrows;

    event EscrowCreated(bytes32 indexed escrowId, address buyer, address seller, uint256 amount);
    event EscrowFunded(bytes32 indexed escrowId);
    event EscrowReleased(bytes32 indexed escrowId);

    function createAndFundEscrow(
        bytes32 escrowId,
        address seller,
        IERC20 token,
        uint256 amount
    ) external nonReentrant {
        require(escrows[escrowId].buyer == address(0), "Escrow exists");
        require(amount > 0, "Amount must be > 0");

        escrows[escrowId] = EscrowTransaction({
            buyer: msg.sender,
            seller: seller,
            token: token,
            amount: amount,
            state: State.Funded
        });

        // Pull tokens from buyer into contract vault
        require(token.transferFrom(msg.sender, address(this), amount), "Transfer failed");

        emit EscrowCreated(escrowId, msg.sender, seller, amount);
        emit EscrowFunded(escrowId);
    }

    function releaseFunds(bytes32 escrowId) external nonReentrant {
        EscrowTransaction storage escrow = escrows[escrowId];
        require(msg.sender == escrow.buyer, "Only buyer can release funds");
        require(escrow.state == State.Funded, "Invalid state");

        escrow.state = State.Disbursed;
        require(escrow.token.transfer(escrow.seller, escrow.amount), "Payout failed");

        emit EscrowReleased(escrowId);
    }
}