pragma solidity ^0.5.16;
import { Table } from "../Table.sol";

contract Table_6 is Table {
    address[] public addresses = [
        0x1dBC269994FcCf6dFe0A11a00C30062D86143fDF,
0x1dC122dB61D53A8E088d63Af743F4D4c713e8A20,
0x1DC22e51C13b6e2C33fE1c4601BC789DABD4B823,
0x1dc846C79b1Aa953846f59e44Ea0e94ea8FbBCD5,
0x1dd49b2f500F98150dC8A7ae914AE56AdC259B7a,
0x1DE4b95E50D38cCEabb9d613f59EacF092eFDe47,
0x1de6Cb84f2FB0116e62223e3291B1768659F3E31,
0x1Df9024E6B17Bb8fF91a387913240214D5e50D0C,
0x1dFf60777421eD07f4DDE33eF62AE54316e93C5E,
0x1e1A4c2BfCC7aDdB851D079C42eB314e1B237489,
0x1e38A491cb0d121dcCc740df8593b79C5F3C7580,
0x1E4642D9C9e10B847FEADA042d4Bd96Bb4a0A811,
0x1e4E7c29462e3dC4a6F565FDbefAD203F1c70243,
0x1E506425B51F5e79A7b6329D9AFa286284392B1d,
0x1E626cE67b917166c9b7e470DFBB583484051Ba5,
0x1e64268f1FdF6215bC094338aa135cCe75443ec1,
0x1E6CBAeDC1acC31f39209e39fa23F2991D7A0C1c,
0x1e7010eC7aF357b2422BcA420B3aE733F4049e25,
0x1E8918FA4D93c40431F4Cb1b41520158AFa27352,
0x1E9d2a1E57dE8f4f6B369bD036f208d3fCd371d4,
0x1EaCc4Ba269DE20477746673e3118661B7df05F3,
0x1eb109BbE8810F61795CBc3c014CDa7dfAA4DfD8,
0x1EC3E83C513BC16302251b81B3F35aED324acDb2,
0x1Ec59A83eA09f74FfB0c0bA6C36af7de478F6B39,
0x1EcA669aa2bcB7B1F03ffeEb4eD1034C86d77d7f,
0x1EEe213155050E6efE37103a82f3C8263ACb1425,
0x1ef47d1853C7Be7E4d6cce8db451E5FF5eF191c6,
0x1eF90916af00c72dB05dfA8Ec7a03f07a35410D0,
0x1EFB86e35fdAa66a847D0Bc5Ac6739dd0D5DF3c9,
0x1efDE6Df7Ee918C7ccE91193a7859712c21F531D,
0x1f00a65DaF2D0D31B62327291db4eb8b8C9e00FC,
0x1F0DbACFb5E4F6EC8eE548ED1618897c9Ce74aB4,
0x1F1451E422f5D15be909a85Cb0Be34f43b3Ad4F3,
0x1f186F97C437DA95b0EdcFA17bE7aC1fd69978f0,
0x1F2d724B2a3F1b83a41d39A19184dEAB7b247b2C,
0x1f391756122C08dF29a226f9c7803C3AE50544B2,
0x1F470895D81D6332cc0Ca6029191fa1302dA6B46,
0x1f47351b972c887ED26F61cD46357f8E843a7A50,
0x1f4CA01a51980d63e1e19E501D4EFD872C19AC46,
0x1F51221d0A6a2Fd1CA80712f941185BbcBc24e1E,
0x1F5E573878cf8261B8132B33ccbC1b17569CcE81,
0x1f78119beF2B5eB117FD537ceE5c2A564B37695D,
0x1f799B86C913445806456DB2429b365938f55ed5,
0x1Fa4823613Fb2424cbDab225FC1eEfe3Bd293c84,
0x1faA4096fD1238f914826979b6b1fF3C2661CFd2,
0x1fb85721A1277a7A587812c53B270A20E3c3982A,
0x1Fc4114c349629882185Ab7b03061C2De1B311DC,
0x1fCca7d206D3F9A0a8140C486aEBe074dC58047d,
0x1fcF4e16CE1f212dae04855fE02DCd74d8e7c993,
0x1fE408B8808cc08277EE2F1aA2D14aD73c3D0D31,
0x1Fe5C6ef742ff9CC800195D3dDdd4Ee4df1DD539,
0x20105ee6aD7cFaeBF726cc24Eb4ccaa38ceB7CbB,
0x2012b77565518621b577C81A3801Ed3c252bF634,
0x2018767F3F3e9794282fE622147D1138BCCDdf7f,
0x201CC7A40bCD5127B8722b3b25523A425F8137B6,
0x202F1c0d600E538ADcdC2C70A816eD54eFcE2823,
0x203F455686FEa9b191ff0dbF7288034E333aA35A,
0x20421C4F8669a2fc649ab679Ea4B9f8A410809E3,
0x207688d6e8e9E6Bf8AdcCC81044a0fc9C5B25AcA,
0x207808Ec35E56e55e8a777aEEbFd7AC9f99B6784,
0x20cc804d4c89faA3C743A6595868Fed57E8c5004,
0x20DBC085deb930D389fE399DEac9dB7A3448B198,
0x20E3233BBbD14459C8B17B142c8263Fb79fC4343,
0x20eCccf345aC8088833239b587039804E76e05a9,
0x20Ef8442A8FB517ca95EeB17f3CbE6aeAf6353CD,
0x20fb5D7FadE060264C7Dae99DBbe1f680066c281,
0x210b4b8fB424a66EAA78b1E41bEDb61B8B1D4eE2,
0x21124989782391deeD412bB8Aa78d9E20F55347e,
0x21477084Cf8EA92FBAB4C48878137592F2e5CCbA,
0x214A4357837f2bd80476F1B77A9EdDAeb8658343,
0x21606eE18fc1c9B398c25f56e98E6035ab434299,
0x21a2A1CeB744565e17D134d46dD825e9BDd25011,
0x21A4aC9884c42fa55Ba089E6066acc995cCdF771,
0x21B1c0E2E45c8dBd745b3Bc4ff8F5231E8Ada90B,
0x21debc45a505EE0B93f201D298A1b11c13D14B43,
0x21eC0410e14ff8dAdd1fC705495c15834Fe7a971,
0x21eDF3cBb5A80579adc3710A8FCE96Afd2F74884,
0x220955674D18843CCBF41d83e957c4C2875418cd,
0x22099fea1c3f88EC36ab56934B8A6b357d54b02C,
0x221aD01bF490849C1a13058a7079cbF7632a6cc6,
0x2228Bf30C5029A41409e59010Dd00501353AfB50,
0x223773eBc292Db5edaeB559a6dC6510ab71f7486,
0x227302ba39cC285a84FF9BBf515D317e5D69E996,
0x228E88A37a5c1A5451679F0eb355C758E677E820,
0x22991442F04A4214565A6b7bEb433Fc003a4e387,
0x22A6E4E831CD5e931102573F3B708c8868aE361a,
0x22b2f41167B60F8ce4C82fc094A5ceae1C269B1F,
0x22e2f326FE5A1d07E1214EB1C08346Fd816E8375,
0x22F79F80825696164a632429F6D54dAcB00dbB4C,
0x2304Fe57923d35d7CE97ce7cE1DAd7aAeA8EC1D5,
0x2308e9Dda8D20B2Fd029a209CB7F59C36FBEBfd6,
0x2319214907972B475284Aa335171174c22d73EDd,
0x232bC2C9b6e11a4FD3fA2a6531aF429AAA35913b,
0x23357FFA58CCAc2E3A8AD5E8E01Bde39EB27fBc1,
0x235d0ba518a18B43ce13A4EcE128a88703a02FD3,
0x2363E4cCdfb7EdFf5d0987CA786aaAf32ea46759,
0x23717381dc1c93b15592296b0d933302c46102cF,
0x23a83b5e21175616aD92fa819259B0AB2b11D50F,
0x23AF556DF9103A5e89d988536A5CC958059cC267,
0x23B1fb82c3F86c62473D7c2f5c46BB8bE3f0A4d3
    ];

    uint256[] public amounts = [
        2500000000000000000,
45938779315879754468,
234,
9698364754690830834,
15295579293344289000000,
16483895035494756813,
63093050641890488680,
20064990088590174475,
235634319082399425000,
692891709391938695735,
910087717200106663186,
99000000000000000000,
231677350364893396055,
4664000000000000000,
127055637069295172961,
4043500000000000000000,
990000000000000000000,
644758207117201022583,
17200000000000000000,
7075799144053257474187,
27232504474738791860,
25174833862707908314,
927300000000000000000,
23361061012574132169,
340000000000000000000,
245491637135653859817,
16169822229441629674,
12741071720430737416,
8803749907626500640,
2978635990139687330000,
660000000000000000000,
13379144240000000000000,
1992038825377955000000,
5537879492717587440245,
108389554754653844000,
21570478795674468800,
48087131265823137921,
100000000000000000000,
661616708398133249828,
588912431915940992950,
122110816938677374500,
57457435339350703165,
3182924212154528331393,
58000,
7733577626951520160000,
29128709721717816825,
98065805579233144000,
6130695248775738300,
17867206283180089323272,
14001720000000000000000,
13485025404583010861,
23470806238165338452,
5800000000000000000,
1565052403218637285,
239862293795640274327,
13240000000000000000000,
13440000000000000000000,
5115862770374362142411,
2500000000000000000,
875154040023789406972,
596869139870517202122,
1373438474632167878500,
1432600000000000000000,
8600000000000000000,
72689448624590562075,
865770312414996727712,
1292887404048898240796,
349600000000000000000,
3276595989260098133464,
34000000000000000000,
771247329498767440000,
31000000000000000000,
204894743632156641280,
98314497866441508557,
335626756975575400908,
9900000000000000000,
5600000000000000000,
147186225767390250000,
329374825591867871765,
112654000000000000000,
1100154516720583269455,
12281872555660735170,
15500000000000000000,
412500000000000000000,
227550324623875895111,
1182384449465899850000,
35000000000000000000,
1773292288555982806881,
1702116454396055745000,
268385373870172572000,
136107278072740382226,
166802000000000000000,
153461380443714051000,
86421978600867408234,
9765500000000000000000,
285952887226593771431,
22530157897198722579,
125000000000000000000,
1100468276398112303682,
330000000000000000000
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