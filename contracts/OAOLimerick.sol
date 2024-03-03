// SPDX-License-Identifier: MIT

// .____    .__                     .__        __    
// |    |   |__| _____   ___________|__| ____ |  | __
// |    |   |  |/     \_/ __ \_  __ \  |/ ___\|  |/ /
// |    |___|  |  Y Y  \  ___/|  | \/  \  \___|    < 
// |_______ \__|__|_|  /\___  >__|  |__|\___  >__|_ \
//         \/        \/     \/              \/     \/
 
// @author: LiRiu (@liriu)
// @dev: Generate a limerick with keywords using OAO. eg. Generate a limerick about “flower” without mentioning “flower”

// @notice: use mintLimerick as the main logic entry.
// @security: unaudited and simple proof of concept, use at your own risk. Author not responsible for losses.

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./AIOracleCallbackReceiver.sol";
import "./IAIOracle.sol";

contract OAOLimerick is AIOracleCallbackReceiver, ERC721URIStorage, Ownable {
    /// =========================== CONSTANTS =========================== ///
    
    uint256 private _limerickId;

    // mint price: 0.005 ether per limerick
    uint256 public mintPrice = 0.005 ether;

    uint64 private constant AIORACLE_CALLBACK_GAS_LIMIT = 5000000;

    uint256 public currentId;

    /// =========================== STRUCTS =========================== ///
    
    struct Limerick {
        uint256 id;
        address author;
        string word;
        string content;
    }

    /// =========================== MAPPINGS =========================== ///
    
    mapping(uint256 => Limerick) public limericks;
    mapping(string => uint256) public idOfWord;

    /// =========================== EVENTS =========================== ///

    event CallbackOperationResult(
        uint256 modelId,
        uint256 limerickId,
        bytes input,
        bytes output
    );

    /// ======================== CONSTRUCTOR ======================== ///
    
    constructor(IAIOracle _aiOracle) ERC721("OAO Limerick", "LMRK") AIOracleCallbackReceiver(_aiOracle) Ownable(msg.sender) {}

    /// ======================= INTERNAL ======================== ///

    function _mintLimerick(string memory content) internal {
        Limerick storage op = limericks[currentId];
        op.content = content;
        
        // mint limerick
        _mint(op.author, currentId);

        string memory tokenURI = _prepareTokenURI(content);
        _setTokenURI(currentId, tokenURI);
    }

    function _strConcat(string memory _a, string memory _b) internal pure returns (string memory){
        bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        string memory ret = new string(_ba.length + _bb.length);
        bytes memory bret = bytes(ret);
        uint k = 0;
        for (uint i = 0; i < _ba.length; i++) bret[k++] = _ba[i];
        for (uint i = 0; i < _bb.length; i++) bret[k++] = _bb[i];
        return string(ret);
    }

    function _preparePrompt(string memory word) internal pure returns (string memory) {
        string memory temp1 = "Generate a limerick about '";
        string memory temp2 = "' without mentioning '";
        string memory temp3 = "'";
        return _strConcat(_strConcat(_strConcat(temp1, word), _strConcat(temp2, word)), temp3);
    }

    function _prepareTokenURI(string memory content) internal pure returns(string memory) {
        string memory temp1 = "javascript:document.write(%22";
        string memory temp2 = "%22)";
        return _strConcat(_strConcat(temp1, content), temp2);
    }

    /// ======================= PUBLIC ======================== ///

    function requestLimerick(string memory word) public payable {
        require(msg.value >= mintPrice, "Insufficient funds.");
        require(idOfWord[word] == 0, "Word has already been requested.");

        string memory prompt = _preparePrompt(word);
        bytes memory promptBytes = bytes(prompt);

        Limerick storage op = limericks[_limerickId];
        op.id = _limerickId;
        op.author = msg.sender;
        op.word = word;
        op.content = "";

        idOfWord[word] = _limerickId;
        currentId = _limerickId;

        _limerickId++;
        aiOracle.requestCallback(
            0, promptBytes, address(this), this.OAOCallback.selector, AIORACLE_CALLBACK_GAS_LIMIT
        );
    }

    /// ===================== OAO CALLBACK EXECUTION ===================== ///

    function OAOCallback(
        uint256 modelId,
        bytes calldata input,
        bytes calldata output
    ) external onlyAIOracleCallback {
        string calldata content = string(output);
        _mintLimerick(content);

        emit CallbackOperationResult(
            modelId,
            currentId,
            input,
            output
        );
    }

    /// ===================== ADMIN FUNCTIONS ===================== ///

    function withdraw() public onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}