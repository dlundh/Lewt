pragma solidity ^0.4.2;

contract token { 
    function transfer(address receiver, uint amount); 
    function mintToken(address target, uint mintedAmount);
    function transferAdmin(address newAdmin);
}

contract LewtCrowdsale {
    address public creator;
    address public beneficiary;
    uint public beginsAt;
    uint public tokenCostOfEachEther;
    uint public tokensMinted;
    uint public minContributionAmount;
    uint public amountRaised;
    uint public currentBalance;
    uint public deadline; 
    uint public priceInWei;
    token public tokenReward;
    event FundTransfer(address backer, uint amount, bool isContribution);

    modifier isActive() { 
        if (!(now >= beginsAt && now <= deadline)) throw;
        _; 
    }

    modifier isCreator() {
        if (msg.sender != creator) throw;
        _;
    }

    modifier atEndOfLifecycle() {
        if (now <= deadline) throw;
        _;
    }

    modifier isMinimum() {
        if (msg.value < minContributionAmount) throw;
        _;
    }

    function LewtCrowdsale(
        address beneficiaryAddress,
        uint startDays,
        uint startHours,
        uint startMinutes,
        token addressOfTokenUsedAsReward)
    {
        creator = msg.sender;        
        tokensMinted = 0;
        currentBalance = 0;
        amountRaised = 0;
        minContributionAmount = 0.1 * 1 ether;
        beneficiary = beneficiaryAddress;
        beginsAt = now + (startDays * 1 days) + (startHours * 1 hours) + (startMinutes * 1 minutes);
        deadline = beginsAt + 4 weeks;
        priceInWei =  0.000005 * 1 ether; // 1 ETH = 2000 LEC
        tokenReward = token(addressOfTokenUsedAsReward);
    }
    
    function contribute() 
    payable 
    isActive() 
    isMinimum()
    {        
        uint256 amountInWei = msg.value;
        amountRaised += msg.value;
        currentBalance += msg.value;
        tokenReward.mintToken(msg.sender, amountInWei / priceInWei);
        tokensMinted += amountInWei / priceInWei;
        FundTransfer(msg.sender, msg.value, true);        
    }

    function checkIsActive() 
    public
    returns (bool) 
    {
        payOut();
        if (now >= beginsAt && now <= deadline){
            return true;
        } else {
            return false;
        }
    }

    function payOut()
    public
    {
        if (currentBalance > 0 && beneficiary.send(currentBalance)) {
            FundTransfer(beneficiary, currentBalance, false);
            currentBalance = 0;
        }
    }

    function removeContract()
    public
    isCreator()
    atEndOfLifecycle()
    {
        tokenReward.transferAdmin(creator);
        selfdestruct(msg.sender);
    }

    function () payable { contribute(); }
}
