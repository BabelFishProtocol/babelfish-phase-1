pragma solidity ^0.5.16;
import { Table } from "../Table.sol";

contract Table_23 is Table {
    address[] public addresses = [
        0x84750c20B857b0032CC7e4DBa357013748C0E57d,
0x84889affc24Edc65DA221C7b34A2C5606DF082be,
0x848a6CfA846D827f4cA0980B6d4036FB2d463F15,
0x84aa82Cbf4a4f1dE52c6bF911b0E5cB241B5CDB4,
0x84D9c13793eeEcD37Fa82482110bcB0c5e42116C,
0x84e4123CDA48C6cd1Cd1640D2c33922f6B545609,
0x84fe17b9b5E2aC84386efCd0cD78912bFd2d4c82,
0x85122291330859D6F61e84FD5aD9D506979712Cb,
0x8525B969c183dE53F67D0b723d1aa9448E630044,
0x85399353400C5B67fD6eE53B1d2cd183bAE7dDdb,
0x853cEa7ff3D568c66614d1CB37b7d6d75B81d573,
0x854eEb4c715e3d1Ebacf35Ec3190fF25f2725218,
0x85924aA0B2cb5a0BbeC583Dd090bF7CEdBa5D2Ea,
0x85A8b2A0a38D4697574172972c404C2FAa4348F7,
0x85AFFd777EEB7d52B8Eae4fBbEe03446850a5266,
0x85b0B3d2509a192DF74DCdA01B579bC0998ba497,
0x85bb01CA1384e6275Cb794d10D5559B4D94359a9,
0x85D10d3c539bC4bbE13fd1631Fa09D14e742Eb71,
0x85DDB2eAF21a242B838f664Dab6AfD120aC652E4,
0x85e3AeF164E5cbCDc9b7F12e97bf5237CF48D40A,
0x85e4CD6442702B9B84392091a8FaEB73815E501B,
0x86110E90F700CCf00cA0F737F085fa42c5A4b45F,
0x8614003dCA3cA71e3fa372BF2e3b96005F055EFD,
0x8615c1Dd12D9b24005BF2ef2a7E67B65B3C90998,
0x863A86F74C84F626c81Ad335bDD195C56426D49D,
0x863e2ff213D50655b2652bF5e683B0B4D701d2Ee,
0x8641AaC514D6A99cBf00660b6ee0694F7877e283,
0x8664E763266054F57fAA8E62F7FBDa16722178A6,
0x866eFE130047c54D7C906aFB80830c5427B1B92E,
0x867341857eE0CdF6Cb484A1a80EA3E1713e170a9,
0x868583C4E8214FF0185Aa75bda382Eafb01EB489,
0x86A89e5E700c8f2cA9c2B938EbF56bdbc22693d9,
0x86bF06a62dbeBA8C9461f528A7D1b0cACd292D24,
0x86d00bEaaF6f2FC9703066b6A8FF39D179D4c86b,
0x86e1906755cE875D105bD11155E5E6ccD76687eF,
0x86F11dC1207c5CF01700449b7dfa435940Abfb9A,
0x86f7Eec5be3daBDccD012becB4A4A573D33467b8,
0x870fC44f3170cfe10D27D1871c05299632300a78,
0x8712DEf6F509B197553480a7a5d27f2FeB631626,
0x8716465A61664BfC3FA980AA2bB6498f7782159C,
0x8717Dd2A363E7D6cc60F9d0849f3afBD7d8aF967,
0x874c7eA7A0C1955f242E8DE28eEf3db2FF2FD801,
0x874C7Fb38C621C38922cAA7AA03EDfff781cf158,
0x876E72F3B83B85D35568602DD27346c7994Cdd56,
0x87711795890ea632E3c8851F6B47BA1c6b2CF0Ee,
0x877488841506d69Ef04D7844bC06AA39Ac33A045,
0x877cCE772AE09080417C571eB9ce1f3Ca814f4f2,
0x87860a355E06e69d40d6F7131765cC8643b96038,
0x878c4Aa937b5C064F3B2DE6F0A1F067C10cB3379,
0x878dE53f391e83Fd70ae3cA0B9cd28817EbDD82a,
0x8791f550AFacCdB38d0e19a78149898820122567,
0x87998F33b86a34fB1f56B5254Ae5e122f5939dba,
0x87a5C3Fa07b0046e4b0813D40d01e2f2C301D0B4,
0x87b9bC7B275E17a18ED0B388844B8fFE14ef798b,
0x87bE84F86D81eD96f157293c9E91a2f50A5F3634,
0x87c684f7Dcb4749643Cc5c71148b8Eb3749C9D21,
0x87d5b669f09BcC12eED6B6d92f1347ecD6e7308a,
0x87Db38f66eD01050E638AA1E23407Be6b6FcaD45,
0x87eD7650724e75B02E1f7B65638a6c8bC985a155,
0x880FBb859A443067bAbFA4e7fb5a7cA51720E042,
0x881115f9f8f8741A9f72f6215E29B9C6014aE271,
0x88122D927057F27c971B15661Ddf409753EeccaC,
0x8813df602362df425a5e5107a899Db02bFCBF371,
0x881e0a267DD8FFA68F540d83Da58109B4De96f3b,
0x882FE4822eF3cFbB352409B45d33d60979629e56,
0x88366EFa29326b48C7F769aDB206007889178438,
0x885aB3900b921958C85a18619B8562C8E0Ea1c84,
0x885d526C5196870B396F9CF7596622A8562b296c,
0x88603E74577F3064B4460a505adaD7c8473DAE72,
0x886F6Ab61294E7650De300E0D026b1408f1e160F,
0x88815CeE9D678B6e288fb48DA3abbD4514Ff06C3,
0x8893f47C763B85FBd874AAA4dF22A219dB05E80A,
0x88a02111708505f6497f2Db9970580F95254330C,
0x88BA836F4323E40A195fDdfC17E6938F30978aeC,
0x88baF72dd5539B3da71BFce86c486a6cF89836f5,
0x88c36Bf652de29f307f183433fd092893aC41e79,
0x890E68421A6E1a3ff329F9bA920B9A1275e6cC18,
0x89107822912A4fb64d4C40A18c0700d4F7Cc86E2,
0x89328fDEE7B43BBd2B4fbE4A13DC04dd8d87C195,
0x893816e814ACEcb58301c73585d97493D76f928e,
0x893872a463D44121118323c12A5bB69bC1161330,
0x895090D2534D7F4A077a5D44870B519817e6b56e,
0x89599afb39836eDbD069A7980b98429655af7B8c,
0x8963d56e247ba12C5FEb7812AC9C247F4757eB95,
0x897CEb4a514f7D4D9e0f4cE3347D44966554376B,
0x898148CB0f3e591b44Dfc8Ae0C931E186FbDDe85,
0x8982A7B1690DeFe310896768F0852d33B1663382,
0x8991eEFBAaC9AE7100085555a3F30ff174aeC257,
0x89C25Fd642B855DBeC3B3C2A6c2675c6f08A8f68,
0x89c56532C8daE704F292952019F6652eB6Cf42b6,
0x89C56adfd2f193e5a5c9534BA6E82B9575957338,
0x89C9491635e2bE5a773665b495D87a23287ac3ce,
0x89D4E55592947d79AEeD5e2787f9Df93C90bD991,
0x89dA62b9a45b7f752336AEE39D1c4D00Fa5926E7,
0x89eBa635ED585A9bbDef25E22F8625bf18f5b13b,
0x89fd1226a3d619E2c2941B6A174d371Bb3Cc2990,
0x8A06834e2eA22b9BE7775EaC6785A1C964Bd4E11,
0x8a0b3defA7824e76F250B5d2B2De19113D96cEDc,
0x8A212f9ea3a625A0348d2b7662F375DE4bb37627,
0x8A30A3C6Df49dd4C83201dE34350B3a8a1c57843
    ];

    uint256[] public amounts = [
        17131077351496043947,
4653248016455423352000,
2900000000000000000,
2850246507806080580000,
2203477555545303130,
9760000000000000000000,
25260622831796397308,
47964897688891278229,
393763038788021973370,
5149568611339358950000,
829542000000000000000,
396683997534921921000,
9852288122757794199758,
7271959909613804560000,
10271158586688579000000,
94911492700408549100,
15478920804112506368918,
202370353327855401700,
31422121768870404262,
68853122615410991345,
29642767437567099202909,
863719055443142315801,
16972370035564168608,
138082281942854764250,
134445018137528899505,
214570314344465270024,
618694516828154757414,
3246,
30630018282553532700,
122007755878523671977,
22000000000000000000,
29000000000000000000,
1771774856203779820000,
64785406550757587332,
13463453463772297151,
9765600000000000000000,
9132236754818978757,
6545380126210290762505,
2231409818972153833773,
80209473735700740539,
2900000000000000000,
2500000000000000000,
6470829909613804560000,
19360000000000000000,
230645907529504458000,
2332010575184880898000,
2906168836838329204,
2549099459739733102,
44522763904084007500,
59589893588429081179,
195867501494999029361,
196900093858159052987,
736946580613945192531,
111719005132197298209,
1355792933442892320000,
7856800000000000000000,
51855946186907289358,
4308000000000000000000,
10654508586688579000000,
538937137103062303825,
1585034270193687625108,
3450800000000000000000,
1705558134757600475000,
246394824072022921466,
14944000000000000000000,
214500000000000000000,
29000000000000000000,
127403444588950502115,
76366553518476552853,
1310574201385303312615,
2353013403861955450000,
17753802535689994371891,
128694044942530044092,
2700000000000000000,
1788465488907148660000,
5635950232788684540,
80500000000000000000,
37838219763330080198,
611830853212220080419,
44588972816137863590,
173541495480690560000,
99200000000000000000,
15683302000000000000000,
9245969171873801520,
2470347227633498094895,
11320000000000000000000,
5000000000000000000000,
2547941559736817041368,
48435463869381468476,
533451962548265102821,
6260861507779887322929,
5649137222678718267944,
40188008802900675591070,
4793891950811153775518,
5649479951307684659200,
5500000000000000000,
55500000000000000000,
6573541495480689920000,
14000000000000000000,
2262756299311651770000
    ];

    uint256 public totalValue;
    uint256 public totalLength;

    constructor () public {
        totalLength = addresses.length;

        uint256 total = 0;
        for (uint256 i = 0; i < totalLength; i ++) {
            total += amounts[i];
        }

        totalValue = total;
    }

    function getRecipentInfo(uint256 index) public view returns(address, uint256, bool) {
        return (addresses[index], amounts[index], index == totalLength -1);
    } 

    function totalAmount() public view returns(uint256 total) {
        return totalValue;
    }

    function getSize() public view returns(uint256 size) {
        return totalLength;
    }

    function destroy() public onlyOwner {
        selfdestruct(msg.sender);
    }
}