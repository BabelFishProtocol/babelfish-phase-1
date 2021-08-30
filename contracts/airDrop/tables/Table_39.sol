pragma solidity ^0.5.16;
import { Table } from "../Table.sol";

contract Table_39 is Table {
    address[] public addresses = [
        0xe7452D832aE9fc194CE6f9a020c8C76C8b1144b4,
0xE74Acf3B57d092dB0E2f71F0435Bab6eD95c3A72,
0xE75E79d3C82Cb5F0A0Cda0F5dcf692823EfaE579,
0xE7a4B8F1A428Ef9756926B3E325A849f391F8EC6,
0xE7b968d86Dac4820Fc964A6D5d400DB2b0Af8D20,
0xE7BDA79b418c9f25A7FDa66058C3a7F0E0966FFA,
0xE7Cca2d05637e9a1B6A54De03bbA89D166043528,
0xe7cF3D6c298B374afFc3990732b1D63e95d1C983,
0xE7dc50061D3885fdDc48eDBd73442B884e8D6d98,
0xE7E0a14b952aba722a515D7d872e50ebDd24e2c2,
0xe7f068E16ca29457F3414D5A70e42df59792FC80,
0xE7f78FCA43c129010635043903D08806AEB0CdCB,
0xE803FC190ab41181B596817563589598c6CE4ab6,
0xe8131168eA95ecb00fD0233Ef47A1890238ED26e,
0xE8142190989d38ec80001860a2d83Bd15b931947,
0xE816c2932724655782A81009CAb64BC45446afB0,
0xe827f38ac363BcDb3865b23d0eBE2ac8e28B45d1,
0xE82af191FBf0DA8361197fe948541b32a86deA51,
0xE82d37AA7D437597209794D07831a5953266D3F2,
0xe840B3E844b36186513220A3E5BF30cFA73001Ca,
0xe85A2b9b6e5458B65ceDA669d58e2c3d970e07E4,
0xE85Ef47Ff9D5BF9C36eE0Bf71c5607cB67A92b03,
0xE879b90aCA1019c9caD2403AD16F4b5eB96cC687,
0xe884398213A3433aFA41DF65369E72850CF66164,
0xE887EaA07fD2f3D30Bca17dB03bD24e40d5E24f5,
0xe89735a0a24B8ceAc687C4bFc76aA3843C1DCEb8,
0xE899b76618F150dcCfeabeeF20Dd091A6e20411d,
0xe89BB00F75B0D8096Ec6fb40BA404b534E8E9fec,
0xE8b32556ee5884056d9BF4f52E269a2ab190C67B,
0xE8c3A3F1eB0a4f845aE1f2115d18Db37Ab55f51F,
0xe8cF2f9fFb1967CdE68c70463b2256D1FfF97c14,
0xe8DCb2366dDa2D482C2A754916706C41252AE93A,
0xe8E593B5a90EA9B46c9b0225e1337C34D34D57D1,
0xE903F24C39c1Ac0B464Da980B0e6018FBc5f5d71,
0xE93709A5d4AFA46ed6A2D1B4D93dd13137bAbcB9,
0xE9496E089A3684F91Cec2f985f386879B8caD4B8,
0xE94c71b53bAe76730a6c52AFbDD9937D9E1E8bE5,
0xe95852c468E08438f1c2E1B33D5d12979fa3ee7E,
0xe99e48a4F8e383bD0903030A0545d63a6f34AcC0,
0xe9afacF0E574EC964392245a2190E8Fe92C6ABbE,
0xe9BD5642374e97bc0E3cd7DE365F8Df52BEE9A57,
0xe9d7219B7Fd6fE5F30c83A076a66490D1E324766,
0xE9Dfecf6f3cAec6F1f6e6e31B6671eEb68daFb05,
0xE9e7f145A3768c0b462a569e87C16f846A530F57,
0xe9f2159941BE08c6B0219AA0f8eEE259104Ff393,
0xEa125a2745043D9647980F0E93caEBC22dC085cA,
0xeA263fDBF61FcE84678203e4dDf649BDd798aF87,
0xea3DE348C0Af52Bdc2848227996D807A05437131,
0xea40EDc0c204aB238F0B7117f3f2a4278EaA91F0,
0xEA46EEc6CA891223FA581Be42d52F9f8477dA2CF,
0xea483b1DcafBD2676EB90408115ec46cAFD8893a,
0xeA4bFb817f45E8DfB7eFaEc407Ea5728443097DE,
0xeA52c9715b9D6B39b2A8B5E0797230a87e6b00f7,
0xeA5EE88F918456066bE1B44f6e51E5fe612B37A2,
0xea713bF6e1351cA3878CF5181f9E84A5A2C2C1D1,
0xEA71d0C2ebBe1CB1B1fa3269b8851FF30e0Ef695,
0xeA9FEb124d29641d0275dC93f93De2dC24e0e299,
0xEAAEb34102451C1BaB05bB51D895dabeeb598774,
0xeAc5f9b3cd48123a69FE69CE93A7F58100A56552,
0xEACA45fEEaf4930bAee8EF68B268E9E4E718bA11,
0xEAD3B6578c71117526A9C972c0932C446320CFb0,
0xEad8135927D33322652BCD0031DD0374484Bd4c7,
0xEadEcC8F104aeF869BE89e98FCBCbCaA610Dd495,
0xeae0DDAd0Ad7d62119d4cb4B8f8973A4D77D9407,
0xeAF696707270c85e948Fe841E0710F434c73d2F0,
0xEb148D59e639355671565C11ceeC6f481F4c24A3,
0xeb2A536252a9FdcFbfd5F6634506d0C468FF965c,
0xEB473B5e6D607afF39238304B4Dba169783c9101,
0xEb5d41932e4ea73F7DA9648C257DA1F270A5c199,
0xeb8Ce05c00D87f58fD47647faf21D44b0D4EE869,
0xeB8F7b8C27732e00beF318441422000D8CCd1e54,
0xEBB3Bd3621520f6738cC8C16A78b8154c9855bc2,
0xEBC54a9BC67FA676e0240d5327676EB9f30920Da,
0xEbc901Ae0b59bF7532AeCEc6709E82F52C230C60,
0xebDFd3C04C70e01b645DE35778dA4194f8d98B86,
0xebea63F22998D2Dcc433435cd74e3d8555B6E0A7,
0xebF2689470669FA464cCC160fd73d7D8d3Ce80A7,
0xEC00FbfDe8a394E14614b4d9CcbbFa4DF6aa3ca7,
0xec0A29247849976F8a2aB8E8dB772f56DBA46326,
0xEc0E8DD35F4021D03746491f6410Ac47c0b3Ff5D,
0xEC3455fDA448eD47C1F3Ff5C89006645a39ff964,
0xeC41b27F11e200F24ffEc611A36176f2727F5d8D,
0xEc41f4c3CCB033B71DfBB0249AC94E2447a97015,
0xec833A3C6eaDD36aA551a26796D4666d1260E902,
0xEc8DF57cDf4E12B2F0f5f8c22cB659FA47199C46,
0xec8e5C7b2e715439AA0B613649b0465248905dF3,
0xEc8f9Ed4772B268518a3a585fD4f8905CeE114C5,
0xEc920A633f86e1865eDEC98205e7CF6D682BA36e,
0xEcb0ab3355f1715439ee7353C565A857a169f269,
0xEcc03538d9Af264725dABd36417441F7971c91F6,
0xECED4D0BC8ac880d135215d497C848Bc48d03D18,
0xeCFD1f9cCbAAbA8DBE19F386b171Ee3e0211017C,
0xEd09c53f4c6EE0adDf39cD40FF8f236810bAc7DD,
0xED1500366Eca6b0311313Bc1E566cCDddC4c7931,
0xEd166155e4f7c9256Fb04b065a4ECdfc035982ff,
0xed36e9d644C5175074b54660f4807151DcD12Eb6,
0xeD3b4F92c73e8Ff1Fc1AaF2382483D18b5809Fac,
0xed3ffA7e8f2994E37c6fB1Ee523C3F2571fD711D,
0xEd4447F02911B3eE43bF6975e6Dc589a85187BD2,
0xEd44F1d2622C8C9aCD4edc631Dd57384fa72A6ab
    ];

    uint256[] public amounts = [
        28800000000000000000,
209812479330559166650,
17500000000000000000,
92203475585461841405,
23318290879211175290000,
227210402208024207376,
50763738699042067995,
262664048182047589000,
4820387631879828500,
14000000000000000000,
3253102954806902070000,
83998065000000000000,
208724457654384661550,
600000000000000000000,
750820345110928442000,
15363962911087492407800,
1059404938373048520000,
173521170035678630940,
9200000000000000000,
26867013715170256433,
2326272145708437344000,
38172847741860535299233,
165116635171680043146,
3486682838940784670000,
731642694139484205746,
3829055823746918847000,
1215843144515763352081,
6300000000000000000,
374000000000000000000,
554400000000000000000,
2739692307692307692149,
2860000000000001515,
10540000000000000000000,
130319867111669294345,
1800,
3955373617613502180703,
370242653866629342308,
10840000000000000000000,
187611226358617807816,
4490734956311061598846,
41096885137634640404,
1320000000000000000000,
831317344512686618741,
2934063236598977982431,
37000000000000000000,
3641159947647592403628,
8439015303765200980,
163935638271027610619,
1517265068717257691000,
1417165241786541464179,
34937521559704452257,
24745817279146232166385,
351459733370776748251,
326503201278846410543,
382896786271901968000,
316670376471670223330,
20640249502340854384,
2667,
2546173981665521001078,
5556967060005167885057,
3618533263781448335,
903861955628594952000,
4198489359079703920000,
24571791316349298059936,
806815318067193410729,
318405916187345949000,
425270000000000000000,
19040000000000000000000,
22770000000000000000,
147060000000000000000,
3538724609244452692,
24420000000000000000,
419472540092699656200,
389950147600871211629,
1280963321818078433134,
389004605587510231000,
3388407853317102744793,
4731779722862179786950,
1259510271158586680000,
40524000000000000000,
205438537255106170902,
620965981813591673493,
38457524679432218549,
3996600284562180120,
15374571077059381652561,
2682138099224750676317,
124666546259173550406,
517885929806878626000,
14950628247838012054,
390451848808545810000,
535251209655319797643,
90379689132863613620,
6332429020134681066994,
10051258750000000210600,
20328242076283857300,
46000000000000000000,
278114340677946712794,
1469013294502059562105,
425610000000000000000,
266424886721990069180
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