pragma solidity ^0.5.16;
    
import { Table } from "../Table.sol";

contract Table_4 is Table {
    address[] public addresses = [
        0x1063E23Cb14960f8890Fa9Ae0f6C0cBD7177a19D,
0x106D5bcD38f25e584150E1915687675C36D28eA8,
0x10819B17e4B4CE365A632658F7754F5B5cE147c0,
0x1081AbF242bdf1bFfCb307Cab2ffBE2570339c3F,
0x1085025f18d090f24d2aAF282c75001a4699eA17,
0x1091dC01903892aBf38d3CAC98CB24721D51CB99,
0x10b0661981F970746158aE4B50E5c6D3b6867975,
0x10B545F4760dF6C97e5DAF568Eb6090ADbc83273,
0x10c54575977D4c654aa8DC254cE949737928A828,
0x10cb5a31Fd79310d2Bb73E66530F849A6CFB2e9b,
0x10e409A5F3d2EcC162D689BcbB0ef887406B317b,
0x10E52Ec81735f8c7185EAae4A86a9504C5673C6D,
0x10E6dAD4bB48ae5F8B73D140d61dc2057Df25a5f,
0x10E7e4224800087bd5473B0876c638b68bA3bfCe,
0x10eA790037C0391CE8AfE2861E9b1Ba9045A1EcA,
0x11231493E0a72449F73Eb2aA4c68261556BeFa5A,
0x1128f7ED12B305E2f02ACcca3E3c76F806E3cdB0,
0x112DFc333E0531f6E133D7701632BfF835AA734d,
0x113f7F28F6Eefbb9a9D168ab17F3b91Db7736b6E,
0x1140AA0ebCF7683097ED354dF5C458D6982A537e,
0x116A8080b2472F47C9acF09B9E1E31148295d477,
0x1170893535187EA6B8aDEd5f2dB9bEaD9A8E6ac0,
0x118cC8bA47636B369048d81Ca6fa8Efb4AE3E88c,
0x1197d134a29A1BD2dDf038bdd4028B86ffC88A5e,
0x11aBA5138A07E075A1C4CAc6a5fD6Cb02523C2B0,
0x11B55e2d3CFcDB8Ca89f718A8f27ce303C77deCd,
0x11bBbEb5b243999500d9d4a3F982A24F5d503049,
0x11C39816fD0BbFfC1CbbB5DD488f7526c25a5BA9,
0x11D0315bb83b5F297A707a7A0719AB007288533d,
0x11D94CB13F57939BA304b591ac8aC56A63EAdaf6,
0x11De56e45b04478bCCFDB00Bd9077A9FdCd83f53,
0x11e18D60c4a10905dc50123d949DABC9EE383752,
0x11E7806eA79CcF0BB5Ec9f5F00ba474087B5CA98,
0x11F22509947faA978D020b74b342ef1E169B1b28,
0x1206d26Bb21757C91d8EF3832D9C2246c9D67A29,
0x120784d6b4be27dfB90bF3AFd39DB3cd27652d4a,
0x1207f435d842F06f28C686824CC2Db1825309851,
0x12159C26E8b554Fd8F42f5120F89509F274f497B,
0x121E01A218D2eB991584caF2dAf8B25b5b27a12f,
0x121E75588FbB738CC08000204691771945eD71b6,
0x1229366ca766cc7eABc1Bd50D683712141c94BBF,
0x12392c37c346d1D05795ae4118e788337B73832e,
0x124e41aE25d98B73a881cd213fb63089a80728b8,
0x125A310f4d6Dd1e37345c5B55688DDdDbe0AfeC2,
0x125F643CF2147f8C625828B010C360AdD8bA62dA,
0x1261E919EB61A3Cf41B68B65192ba1A4491C53d7,
0x129C0B9581495d46087c9b04df06652691E93CBA,
0x12b73269787f985B014174840E5232bB4e089562,
0x12cCd882ac5035F1fEA80c29E70dd3AEFb71BacD,
0x12d0Be9875E08C2D3e47747AE2645AcF52112d02,
0x12Dd7FA017B4438B2968085B62482d8D589028b8,
0x12E1f57a00320Be1e5cfB410E5f3454D3fbEFa00,
0x12ebd80Ba3d7C0624F340A8493E332159157b3D4,
0x1351597bB9b8f07E3803d314b6a51F24f975d20d,
0x135df8445fFb50A6C3D1c416e88B0F48F04627EF,
0x13773F12FbC4a673E2C1aEA71A1DcF959b608aaa,
0x1386DE1E84bB10248BaDf884A4D25E3Eee4329C5,
0x13881d4b27c55D5c2Ff8ef145AE6692BBfe29DE5,
0x138d2eAa9014E8F675b3a4B17e3cea3c0EBF17e0,
0x1396D36F1d89f0aeb2C64eE3e8f1B90B1F4e60Ae,
0x13aB968db75AaBf5c4d5BB9b4D423D5c1B8D25d2,
0x13aC3DC53D5Fbf87727a111509151234a6a322e4,
0x13e576194B51f9A268E5978D2B9b56680fd429d9,
0x13F15a7a3a924702e9C146f68f562d423f993299,
0x13f2042b4Eaf9b971B5FdC80Baad5dd6565D30bD,
0x13fa246bba8721a0bC426D7374DF03C96867fD0B,
0x13Fc5d70892Dfa109b2e8AfA19eC9d1f14F29737,
0x13fe47FD0F4295BA5ea1923a7bA378A902dF0202,
0x1405926895600265260fe89fee8d1Cbd2c1a43f2,
0x140CEe91461cCd2E0c8EAAe1580f9C0c5438511C,
0x14129eC44A32b57D929F3D2FddceEEe7D653Bae7,
0x1447FDdc34680E82891D3193A6Dba9219BdfF5D4,
0x144F44ECAF98335BA59bE903B26572126da6A84A,
0x1455c0eB0739d6c4Aee84170958C7F2E88DC9dAd,
0x14627acd7E1873f061f40093685489D80A242DBc,
0x1486947a7a32631B15dAB6a092e460be03FB5c5f,
0x14a4dB95774aC0546dBf8708D58061fA5D0EE497,
0x14B6875440c4013e6007EE003674C8EFB1b19058,
0x14C2cd72E38Ee9C7Dc0589727530df7D2B513d15,
0x14cdf8F84AB910190C86bCCC704f792081b34da8,
0x14D481bfc75Ace2Ac9B6B2B50e9D0F84893ec7b7,
0x14D768309F02E9770482205Fc6eBd3C22dF4f1cf,
0x14F6c2F5859A75456BCa1728D8aeCd74A4c9fE2a,
0x14FC3CB47E826Ca8E6DE396587280a5D82ecfCc2,
0x14fe2292A4D5B051f9181adC67F068eE93550930,
0x1501bC4CCf9faF086526F40Ab314Cc3161B668A0,
0x15036961A24849847d1AD399406ED178618caE6D,
0x150c826D4992f815aBB2C8548B0BdB51801489d7,
0x15109A4498e5BC5f9aA3e4b43F4a58C86A0a1619,
0x15165274C75FAaedB1011CCC1B497B814C295576,
0x153625AC017C28D8e09ec9289A3a04C22aCE62eA,
0x153B1053eC81Bc645c4e4FdD016FC709872AFF08,
0x153ebb12EB4f22e0964512302E3d35AabEA9f0e7,
0x1543c3446f436576417490a647987199685e0b8d,
0x1547E39F8360332E2786c6608b9C50b1de53865E,
0x1548d45fEB353Bcf89b6e9d82155c2C2EB19E235,
0x1574A47822DC67D7ffD5e9DE7b9fa85dbE98ac5f,
0x157a4DaACa6301D5D14701F6B5e99f1e228f0491,
0x157cA9dCC26be365D9b4639520008f1933349871,
0x159b526C722976c2CE228474Ed51d89103c89DCA
    ];

    uint256[] public amounts = [
        365,
103327666615067000000,
4194182016645500000,
739957367614464000000,
40409985995368000000,
2655374788269120000000,
31928514188675500000,
1806399045551920000,
9187575467452370000,
530068027699937000,
1147238989465820000,
149276060767962000000,
22450043832871000000,
367094492293965000000,
4433499004808460000,
306256338916101000000,
25237665416899200000,
88908280992857500000,
8589464652098130000,
178160296599319000,
63608532775854400000,
188485980306595000000,
1911283186207340000,
1364752672078170000000,
17184434165313400000,
2563956684549660000,
128474303468825000000,
32743802671236300000,
14917466235856700000,
152160183573926000000,
6055555798423350000000,
1574404585033450000000,
3526311251405570000000,
44022987874426100000,
0,
128072179346790000000,
13283803510209400000,
212669727253043000000,
1665173134999130000,
234910672770683000000,
15085920708033800000,
11402370811056700000,
361279809110384000000,
166477371361519000000,
93908259319917700000,
2754784042561370000,
987399444988563000000,
8300354451547730000000,
179890206955698000000,
188312147451745000000,
5300833589273050000,
2892314320266140000,
6406828372411470000,
2832890178792620000000,
4179729701502920000,
26276684837333600000,
194348949185976000000,
16256081601365000000,
193246281115721000000,
0,
1716320175684230000,
6082556452052500000,
15669380683941500000,
5699801359516580000,
5079612467808320000,
347488852508685000000,
14178574486896800000,
3416784721516270000,
198064330838924000000,
112488190914770000000,
26619776127529900000,
855066404822051000000,
460299568896388000000,
69597420631486800000,
7347112104691800000000,
260428579900879000000,
6724837344139520000,
40055019707115500000,
409889631761088000000,
14738373570118600000,
32288921708769800000,
987288918528308000000,
7225596182207690000,
1142131229892690000000,
89880252316391500000,
81948512682818800000,
1738364036492690000000,
73832297588079400000,
309296408581828000000,
221137160519825000000,
21625082039372000000,
116315538802577000000,
5247423307320890000000,
321330537842143000,
40968963360397400000,
0,
0,
8201726545270220000,
12810236090516100000,
0
    ];

    function getRecipentInfo(uint256 index) public view returns(address recipient, uint256 amount, bool finished) {
        return (addresses[index], amounts[index], index >= addresses.length - 1);
    }

    function getSize() public view returns(uint256 size) {
        return addresses.length;
    }
}