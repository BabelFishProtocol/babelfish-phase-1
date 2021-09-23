pragma solidity ^0.5.16;
    
import { Table } from "../Table.sol";

contract Table_24 is Table {
    address[] public addresses = [
        0x868583C4E8214FF0185Aa75bda382Eafb01EB489,
0x86A89e5E700c8f2cA9c2B938EbF56bdbc22693d9,
0x86d00bEaaF6f2FC9703066b6A8FF39D179D4c86b,
0x86F11dC1207c5CF01700449b7dfa435940Abfb9A,
0x86f7Eec5be3daBDccD012becB4A4A573D33467b8,
0x870fC44f3170cfe10D27D1871c05299632300a78,
0x8712DEf6F509B197553480a7a5d27f2FeB631626,
0x8716465A61664BfC3FA980AA2bB6498f7782159C,
0x8717Dd2A363E7D6cc60F9d0849f3afBD7d8aF967,
0x872B39Ac5F6472Ad8f1c6B70bc86f933bD9a8bc4,
0x874C7Fb38C621C38922cAA7AA03EDfff781cf158,
0x87711795890ea632E3c8851F6B47BA1c6b2CF0Ee,
0x877488841506d69Ef04D7844bC06AA39Ac33A045,
0x877cCE772AE09080417C571eB9ce1f3Ca814f4f2,
0x878c4Aa937b5C064F3B2DE6F0A1F067C10cB3379,
0x878dE53f391e83Fd70ae3cA0B9cd28817EbDD82a,
0x8791f550AFacCdB38d0e19a78149898820122567,
0x87998F33b86a34fB1f56B5254Ae5e122f5939dba,
0x87a5C3Fa07b0046e4b0813D40d01e2f2C301D0B4,
0x87b9bC7B275E17a18ED0B388844B8fFE14ef798b,
0x87bE84F86D81eD96f157293c9E91a2f50A5F3634,
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
0x88baa8E1555A3CfeB125eF3da3d5E88E633F865D,
0x88baF72dd5539B3da71BFce86c486a6cF89836f5,
0x88ede20d971E7ce2d4Fd4f9C3744d28c028855d3,
0x890E68421A6E1a3ff329F9bA920B9A1275e6cC18,
0x89107822912A4fb64d4C40A18c0700d4F7Cc86E2,
0x89328fDEE7B43BBd2B4fbE4A13DC04dd8d87C195,
0x893816e814ACEcb58301c73585d97493D76f928e,
0x893872a463D44121118323c12A5bB69bC1161330,
0x895090D2534D7F4A077a5D44870B519817e6b56e,
0x89599afb39836eDbD069A7980b98429655af7B8c,
0x8963d56e247ba12C5FEb7812AC9C247F4757eB95,
0x897CEb4a514f7D4D9e0f4cE3347D44966554376B,
0x8982A7B1690DeFe310896768F0852d33B1663382,
0x898E24a611881ABE1f5Ca50E1AB586e6C4313e2B,
0x8991eEFBAaC9AE7100085555a3F30ff174aeC257,
0x89B6D742372A686573950Da4F0FD2C49751Cb32D,
0x89C25Fd642B855DBeC3B3C2A6c2675c6f08A8f68,
0x89C3fAd61bBF889E3f56d4193bf91948978dB3E4,
0x89c56532C8daE704F292952019F6652eB6Cf42b6,
0x89C56adfd2f193e5a5c9534BA6E82B9575957338,
0x89C9491635e2bE5a773665b495D87a23287ac3ce,
0x89cA9d4C4Fb17Fae2943791cC9A534f6F7c48949,
0x89D4E55592947d79AEeD5e2787f9Df93C90bD991,
0x89dA62b9a45b7f752336AEE39D1c4D00Fa5926E7,
0x89eBa635ED585A9bbDef25E22F8625bf18f5b13b,
0x89fd1226a3d619E2c2941B6A174d371Bb3Cc2990,
0x8A06834e2eA22b9BE7775EaC6785A1C964Bd4E11,
0x8a0b3defA7824e76F250B5d2B2De19113D96cEDc,
0x8A212f9ea3a625A0348d2b7662F375DE4bb37627,
0x8a2895767D27620C264b030973d6A2cEE159ff31,
0x8A30A3C6Df49dd4C83201dE34350B3a8a1c57843,
0x8a43e8F99ac07BcD68BF79bdCBD193757fdE65Ec,
0x8a5187A77d3896C18dFE48C4B34Dac0a9eEEb89D,
0x8a556b640E6D4Cb16882c39B3b205FD36dd54DdB,
0x8A625E14D716B929C539887041462Ee8a64cC927,
0x8a81A44103D8FdEC75eBE730bF53aC7Bd30cdf48,
0x8A85EFB08cEEB7Fa94bb3322763bBBFbBA154aEd,
0x8A90a67374Ced66b6698033869C19b32597FcB34,
0x8aa4785E233167e16F94676c38491B1391d40fa7,
0x8aa6E3140dF81b7b965775D7af3c466362644eFa,
0x8ABA7233799382Ce127C8B1e5731DA4d11F5b3A2,
0x8Ad34e8e5d9eeC5132E64430b072938f7Fea4bac,
0x8AE7070950FC8B4e7d7Ec4c7FC030988b5c02ff2,
0x8aeB5835d92cfE93EDe77faD7C93CB17b2d9231b,
0x8AEc22bc8db042c376Ed219bc36Ae1aF17FdfEeC,
0x8aF137D3cEf3Feb21A0D0b38dafdE168605Bc9ee,
0x8afc577d35929bE04945BF44993B2e66C3aEb332,
0x8b0fD6484Dc29691f1c9216E256945925092aC15,
0x8b13aEE492A857982a3A78a3543650E8C53ad221,
0x8b1634f5Eb88CF249feBf0d266d2689A7f1AA342,
0x8B3CB96f798a9ac37B46f2432257d454afA77397,
0x8b44D5Cc61750e94255E14C1c39F41256210646c,
0x8b46924A0d6D610A46CAf0a5D13DAbdD25B68645,
0x8B4D1F7cA7a7C2987398AfeA49f0D1Df6dE9d2aC,
0x8B7604BdBB8fFA111bfa7014aC7D3698D6A901E8,
0x8b765a02a7F7D5D659e0328e66A65E8877be5fBa,
0x8B7cac4855C767a12E92Db2cC5b656c0a72Df72F,
0x8b9E1a49A4Ba4a6051f1DD185abb176884A8E8dF,
0x8BA00BE74561cF87aD4B7d69E52D4bBD5b83C7b6,
0x8Bb9f9a10559B0ec544fdB86F4357af7B21ADA36,
0x8bbC0882B98a403983b4144314a97bd94C484657,
0x8bc3491E7D5AE64ebb59f6A1D2d19d89b166021d
    ];

    uint256[] public amounts = [
        7225596182207690000,
2258685817411690000,
70802022298957200000,
0,
3116837600348250000,
2222601775915940000000,
970798859192764000000,
6247172439616640000,
225868581741169000,
6303313772700460000000,
2914861760843950000000,
74046688568836200000,
1168684020303710000000,
991877077523003000,
4597162760325650000,
19571477618668900000,
245090580992973000000,
0,
130041467954903000000,
31989932062409400000,
224569419808393000000,
10861023250425100000,
1712303340635550000000,
5248015283444850000000,
54941745346161300000,
355041292996895000000,
398348081727463000000,
560167015774444000000,
46955899052133900000,
581701440525328000000,
45792261212476000000,
2258685817411690000,
13154941868912400000,
25081539888702900000,
249758452241639000000,
242958537302061000000,
2173440469069390000000,
27474085419573200000,
245359463232020000000,
184666589015993000000,
1734466912514490000000,
8311963808075030000,
11845816811421100000,
43563074203327000000,
413100415942103000000,
30623102701144500000,
38289723995224500000,
2559843307660920000000,
720128946094382000,
402732036663066000000,
2267263827447210000000,
0,
208347313698323000000,
5448471477241030000,
20157512077709000000,
350665858238208000,
55081160323574800000,
2247270883074060000000,
1855381106770660000000,
13419917863039700000,
6565161590131000000000,
484320433240506000000,
236572701105066000000,
1806399045551920000,
10576733530050400000,
2478550771682740000000,
1445558923143480000,
55640757322829000000,
989319787797082000000,
389010089384380000,
155305342190207000000,
1005605060683880000000,
64545840199192900000,
13807802897645700000,
2075254733106630000000,
1911283186207340000,
1124599668489280000000,
242303876065560000000,
80979748333626300000,
114679409265005000000,
150332093337768000000,
2951694889586320000000,
44873396485133300000,
91104077571086200000,
34063112527002800000,
790535008752541000000,
36138973078587100000,
1290364865504630000,
677482591167212000000,
3340586842920680000,
6797876594166370000000,
127187816791929000000,
10309832420750200000,
901006415230053000000,
5109467679961910000,
49568531287680200000,
1911283186207340000,
1636096324150570000,
5007500989235520000,
239066203911971000000
    ];

    function getRecipentInfo(uint256 index) public view returns(address recipient, uint256 amount, bool finished) {
        return (addresses[index], amounts[index], index >= addresses.length - 1);
    }

    function getSize() public view returns(uint256 size) {
        return addresses.length;
    }
}