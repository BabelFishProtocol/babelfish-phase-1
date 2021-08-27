pragma solidity ^0.5.16;
import { Table } from "../Table.sol";

contract Table_41 is Table {
    address[] public addresses = [
        0xf4a1B0496ba5135d3cA7C4DBDDC8d76C7BFc1E8c,
0xF4a547A224e152f90Ab1760Cd3F7fB792de6f697,
0xF4b9E164A61bF9FabdaE21Ae1AD27dD035d6Db3D,
0xf4BdF7aD48073B8457F6cBEc12890b75ed0289c4,
0xf4f40F8314f84A3e356992e4c3100841743756Ec,
0xf4FCa18Db3398289d114d1F4F5A8273C3153e96a,
0xf51F65c9bdaa5a5c015757f48a22811aF8c5795B,
0xf52fe56bf4eDf5aBd56232b927641f014d2D515b,
0xF5366a3445Adf491311a6e86443bfb5392f08265,
0xf549987AD19D170f655952FF66e37901abF0f60a,
0xF55184cb18303B2BA247536Dd6E7a541b5ca6D87,
0xf55c3145057f3F3c4f7Af9d371078b27245Ee869,
0xF5708334514050871Db35f4f74BF404EF18dC6ed,
0xF57621427E8857BFF45883ea651d72409e151248,
0xf5AC187Da273c2c645a2e8327c9c3D2bb51f7a88,
0xF5af80F3929f9f0F407b610DA47583C42c2019A7,
0xF5cB5A52A7A74883f288068E1a1286E82B4589F8,
0xf5d676bB3D17e76b197dC0E2ae79Ab5123188Dd5,
0xf5dfC20577794e86ab8A92E399895d22A31b2450,
0xF5F5606BC67c82d5BD1E3FB344B6362078742A6C,
0xf6164703079311bC87177115FCeAc63Ac281C394,
0xF61d06E97126bE3C872ee62C601Cce0805188a61,
0xF624C52Ff68E8a2bE33d1C4b1dC6127E725E2Ef8,
0xf6256a4EaBd24C34B4774CbE1d930B5F5634f24F,
0xf626deE5FFFf1397aaa9c5B5C772CaC97d29c118,
0xf63a521ad77803a3b5f92EDdb4613D719d32448a,
0xF64e0161806eECB20a82c86C7E6D81a8642b6F5a,
0xf658F0c23333a8cdc79789B1D26956fD78111243,
0xF66b6c6C03A4DC146b8689A184DBd0374A14167F,
0xF66FC4BcA38a392A27111bcF97342e22B98516CB,
0xF696d24331d1Bb34C39ba344DDef0e8C33adD3BD,
0xf6B6B5466f88266F4937e1306f8De051c2d5113D,
0xf6D07C3c18d05B80c140ED35e80a67667e87b606,
0xf6E167A0dc136b6C7617c0dA97C05d8AA41ccA4F,
0xF6E36b892D4eE77AE7fBba7cD30fa34D45d905E7,
0xF6ed6743F7165A6695F41909426bf39fA9D9094f,
0xF70Fd6db670ebEB6EaB79433Fa9d7460246139a9,
0xf7381EE789e6eB40e45128eb08c1fAc679dB33Dd,
0xF75c16cEf11AE4C179f4AC8bd735295f63C50ED9,
0xf75F71B3fdC5cbe8756da9FDb1f90a2CB3F78538,
0xf768fBB98A4dcc9D242cE53A9000AD21F9D1897d,
0xf76c8BacC09a793D3efa6593F855761ab77E5cd2,
0xF7705b18d2071D0C5c39f46C07CA6F524B1578A6,
0xF78ef18e85E55646AA6b53210ef61b3d34281E71,
0xF7bE78F0e21Ea511d6164ea8bEf1d05af24ca418,
0xf7d9Df605AF63C7d7e77EddbcA11eFAB6119CeA6,
0xf7f9Ee814f4A939C242F5029E9C01C7c38f4c40B,
0xF7Fa2b9ccEE29d6d760377d040e6Ef92bf9b09Ff,
0xf7Fd89744B378a43C49674180d7Ac15441d91Ba8,
0xf80B742199f1CF8670A249dA00cef663baBf9A3f,
0xf829a6F5DEF7F40f85Bc9E208234CFB892e31343,
0xF82b539a97Bb98282e871D3ceFa9Ceb420e07CE2,
0xF83A28D52c1b8dE089943e467B5c8B066A32Bf3f,
0xf84c354F39a7F43d3e7114ee26FcB7d59B4C7fA5,
0xF8521Ce31a22EB22488b7A15A595f912a1EF4e0a,
0xF852Da2733684F4F30722dae0216D502053d8aE1,
0xF87C50A3Db0F09b94142936E0716b839B5a65C1D,
0xF883932A1A6b4953b8b0f829c0E3654AcE9a85Cd,
0xF8bf8Eb2aF1936f0B4781e99Bb1cF27B08315084,
0xf8d094C4006c060964A1Ad759b7faD2190e5EB89,
0xf8dAf5A60FD7982542478146d23c3b66b902B49D,
0xF8f4051abCf1e8a18263c6989457bc6F3c8409C5,
0xf902bde9dD9812E9CC436D7A1736bFA0a606EDA5,
0xF90535857F2Fa4D7C961C8C49C67224B38D211cB,
0xF922629BFCaA0C3593FA86CbC1F8815A8cbF0B30,
0xf956E531cEDBfbE2Ea37036fA4a29AADc2e0b580,
0xf96f5e7aB5d25155AE1B5C860e799C9976961d6c,
0xf97157aaEF6F3755628B30d05FAA5CF3D62981Fc,
0xf9752AcCAaDA78F10e47Cd3dB2B63D94E14B5ffE,
0xf99FD93e4aB30159ADb8C66b5905baFa66eD4198,
0xf9A0c6eEa16E4F4c5ef40D835Eb1A2Fc489F4ACD,
0xf9A5f9b90B8a970a3E2974A8EeffE41cA1714249,
0xf9B28DBF964df866c20b2B33d7d0D50b944D5dD8,
0xF9c229512B62434eB5dE37823C9c899c100B9050,
0xF9C5d2F166B91515A6514aF18D6Fda98C2bc55E9,
0xF9CE93e6De0D6Ce5bD5cC7Af7b086D749E8F4590,
0xF9D4a6F4ed394dafE51D86e598f153E4335c44Bb,
0xf9Eb08bA9d1C2d1C3872de2F5c08e3314AbEE59e,
0xFa1a866CC0C10759c660209eD28aFc6dd42A4c4E,
0xfa2Fa8447E8be110B9d71103c658E5cF181741CC,
0xFA3980A1808639e02251cC76897bc4b45AA7D96C,
0xfA3ef8687313b7AB4eeD34e2E8e45e496bF2Fba4,
0xfa49e2eDF0E49848fC054d5BfAd9c3702bEaB2c8,
0xfa5Ded495f9E027dEdB9Fa3FffbF3e1e27bE5b4D,
0xFA94665853992b08a57b91e86D56BD9626044aC6,
0xFaA40D454B19f73Ebe3B9927Bdc30De6c6947B4D,
0xfAADdAdC3196bE8783f1383cf80E3974544f3a93,
0xfaC774800ADE7bFA859f7ec7CCe6B5f831cEc024,
0xfacE4fd4D23E197a3132F402B8C9c00D29673377,
0xfae8A9E9F1606470afeE23CBaF17800C27c53774,
0xFAf05c84dc72Ca29756DA16C5fEa5f701195cDf7,
0xfaf89943CFd1772A4a28AeD14277aD73e10f26dC,
0xFb0b2A958AB8135c9655c255bCFe6faa9b3664a2,
0xfb15339d187A76AF62698F73D700E1F8536f03BD,
0xFB1Cb7035f337179DB9e14A74bdaE6E35b0498A1,
0xfB1E828b6054539517f16c3aEcD6dF2AbF024851,
0xFB235432569213A1572cAc885cd83178459b8b00,
0xFB5B840a85D41bF28081a31b186Fce24EFf5AB5F,
0xfB5E46299C3e778Da94D811c5684eFe00C3e783b,
0xFB616827B4c9900Af186AbE09cA325772bd006e2
    ];

    uint256[] public amounts = [
        13980527768494637440,
9200000000000000000,
1904611774402703139000,
221595834401485148722,
76006573541495473500,
8800000000000000000,
9380000000000000000,
31000000000000000000,
4073837028718957691992,
68246000000000000000,
1308835111350498300000,
355947724805947087456,
15443964011576678000,
15875935618651792145742,
3389100000000000000000,
140250000000000000000,
412500000000000000000,
7581125822577215953,
16315692848469966900416,
16478893182670598697360,
1375595765706646424952,
40346127207638573559,
25899299286826517226846,
530000000000000000,
6205427033450483633,
3176383914021857034994,
2018383508627772980000,
6845824345958535863420,
9200000000000000000,
40494483323086193066,
268974000000000000000,
58140100126582403597072,
1550000000000000000000,
265626000000000000000,
185000000000000000000,
54713506984387840000,
209120000000000000000,
55452403127980782929,
27573777161151600865,
1156645706465532351525,
83372608918511268421,
2086005085194043214110,
134000000000000000000,
62464626561472426305,
55382699066620125400,
8800000000000000000,
19089021743683320420,
167799220186009864996,
627440000000000000000,
168117861571233562296,
33214711974606606493,
160687165549019615758,
118498769788703762945805,
3500000000000000000,
431138093598584701904,
132000000000000000,
89830432104950422177,
310900000000000000000,
6262290139640432955,
21240647222678718450000,
3369806653607127084630,
879855569510957405692,
9696974659497360388681,
81246804881808814500,
13495856101068200550000,
3230000000000000000,
398329927680665494912,
14327845992000000000000,
771910022982833235237,
13610267495132880600,
12007867581509114960,
474299833339549386856,
23000000000000000000,
23196176252348595622,
4623973452752185450259,
8932951127432464788852,
9200000000000000000,
110083802834048470133,
504724732949876760000,
207176812144437391200,
8153799141064950977326,
892190040262941665000,
2818794000000000000000,
3389482333607228100000,
9200000000000000000,
3973299940895943504364,
679722727220100598787,
724614000000000000000,
547154897644297389100,
13473,
1051848000000000000000,
43000000000000000000,
4620000000000000000,
95931489178561398343,
66000000000000000,
7023581459463370644415,
91036207429048901669,
63681183237469180500,
726299050514412471974,
307200000000000000000
    ];

    function totalAmount() public view returns(uint256 total) {
        for (uint256 index = 0; index < amounts.length; index ++) {
            total += amounts[index];
        }
    }

    function getSize() public view returns(uint256 size) {
        return addresses.length;
    }
}