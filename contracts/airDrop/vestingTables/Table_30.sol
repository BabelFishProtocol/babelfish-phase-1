pragma solidity ^0.5.16;
    
import { Table } from "../Table.sol";

contract Table_30 is Table {
    address[] public addresses = [
        0xA97578DD7ad20Ba12D42cB4100616f7d3797a72F,
0xA97E3D39843c3454A4EC576165d6Ec1D9EF5E1bB,
0xa99Bed15Cc0AFd4fa13b0c89bc3D639E420c4Bf9,
0xA99C3e0e1D47Cd2fb62485A41CAb8Ca8F997E35D,
0xA9b0c16b23F036e5a5CAA249C301f1FF431E2A60,
0xa9B66050b923856E74c7868D266187b852729049,
0xA9bA9393e85106D708Ada13Cf12c5eBE3f6a7746,
0xa9dbA1DEf83d92Bd2CA313DD449B514663a6e4e4,
0xA9De539a8965BAf21A19B95F802Fa59C19455015,
0xa9E3Cb8c8496d0ed9c7ADD3375D32FCF20fD70dd,
0xA9e8A657487C0A234F1dd79e52b53d9810f84baf,
0xA9F3830D57906C78EB5Da90bD8EB442b041aD1aE,
0xAa06274aB962c7fE31CD3244b85486ba02294844,
0xaa26cB9e66eDBAf69FeFC3F0847493fcec923734,
0xaa3C2fFDE0A2EAD16cd17DD820Aa0cF4A5a308CD,
0xAA45c7C94d3Dbf09e156906d606d8BdCce5c40e7,
0xaa4C3E1991e3663FF90CA978A3F5034b1ADeBfD1,
0xaA52B36fB3a94Ae776322f71273875DFef409D2b,
0xaa613983FE3B8f56FfEe62b0B5eeE298Ec411b74,
0xaA63442D1a0054CA5AA5fa56ed5e4dEe87b504cF,
0xAa6A3899fF70eb5FA5A299E782C40d04Bb19436a,
0xAa6Dc278F8798De8Fb00c43388428A8b756411C4,
0xaa74bB2847f69444Ad3F00Cfe86856Dda3F2F2F0,
0xaA7530686b5b9144D56b47d058Dc0330CE1EC95b,
0xAa788Ff2F5EB331F82a30dA69a2B3a18F61725F0,
0xAA80fA46977A32FE8f69F0e3765CD9197c1e288E,
0xaa861C33741A092F57d8b4a2145aBd2dfeE53540,
0xAaa3bDc6563c144eCC0222a7eFBE88aB9Da54C28,
0xAAa66e612582d5B43da71c16F33A3024207FEB35,
0xaAB94954c6cb8750578E77BBD2Ce603a9ab35A25,
0xAABd24Aeb217E872F8A58968b550E2DC945388f2,
0xaAD4A4a165Ac449b59Ea68d81B97f1Eaf314D501,
0xAaD859940475f3c088477b59fd09C614ceeB57b6,
0xaADFC3502754DeCAf651F21f716aCedc25b0C133,
0xaaFdd768fA83EF7af0e19707F2BE9d1DB1924766,
0xAB020AB81d5d190A83880C0F24De769be58928B4,
0xAB03ce49e033Ec1a8107c99460AAEB61864B8022,
0xAB068b99E95c96aAfCB007b36C919d653aB5046f,
0xAb268E90200c9E899feA24E34512aD3D64ECda6e,
0xab33bbB308BDfF807f2Ae3Cba8eA4df1563B9415,
0xaB4a94857367AA0df7818b9f52ebf514289906DF,
0xAB65F166635FC971fb0E8Aa9d0204EC21Cb67B80,
0xaB6c2F14cd845bc9E5CF71497Ab41569Ef1d8029,
0xab8A59Bd6fe60a70ff5d7b102C1F7cc3B1e9aF32,
0xaB983528f2A152A01385d67111499aBb7166C488,
0xABa0fe9F63f5b1899bEEf22046E3C04C604CBFA9,
0xAbb98eE5c3dcCbCE63Cac4fcE83b55889d8344dD,
0xABBDB0624d25BD1CB49b1c3bfB0d2e4ea5c30cE0,
0xABBF8a9D5B5BfB455890c6c79C139fe1f6e95D42,
0xabcA46C0Ceb48C9dF280B20D8D097D45290D1C9b,
0xaBD64F6F5E91D42379F0d2F53606B98597AA1721,
0xaBd9Ccebd132d2D99ac97cfb95156bFf9acFFbDf,
0xAbf66b500B1C8027eFB51910dBda297A88d35972,
0xac05bc19982a305f158DBb0855B163f949548811,
0xAC0D2c5CF6022AAEE4Cb41baD89f5463843eE7dE,
0xac111E501BF5540E2E9339E20BF5f42B910C3213,
0xAC17C6F9a345950D8b5Bf3eeb6DcBf7B112113dc,
0xAc186B1Fd840Aa1CA0936f834Af77017F5F4ECAC,
0xac228599C6acB688525d71b8e458DBDfCc7A2D64,
0xAc3205a6073212cE3F8BD00c3c7A77108645f2c3,
0xaC3D3D613C7A5d093a27864dfa243a4c6229C08D,
0xAC4BA08898213273B62045d4031F1273E33F4163,
0xac84B87E80670c1cdd88d177F1AF9AE0beEF4914,
0xAc875D8D94167e273044BD2295434B971a126617,
0xaC890236A54D783CD5967059d28eb0991416bAE1,
0xAC988B93303bdB8b16B4971b089a36bDB2F6e127,
0xACACeeBd6F6f224e9A9f0A62702AaAa0a4385fbf,
0xACacf1Ddc60e7d8f7952d1469879D510cE2d25F6,
0xaCb43F6FF53e3C20857EE47e78c3E20006c2CD1E,
0xAcc5c59d3644477de86337B820E3eA58f9977E9c,
0xaCcE16Bb49fFe0450AA8ffd4FA7c24b0af2D83ca,
0xaCeB022968D5351275d7380CEEFA7211764A5376,
0xad098B92AF9a7347cbedd3Cf02819A35A76076f4,
0xAD0A733AE4618c460b4fC646D574E5022Bf2D08E,
0xad100035981D80cc09aC8C3a3D393c2745F1e24e,
0xaD1Beecf6987824223385B610bde05c4Ca2c601F,
0xAD1F2CdFB1d3d596ECB7fc869d37c02954fc672F,
0xAD32Bc446Cc906BfD5f74914F5Bd9cbD1443bcd6,
0xaD334dFA23A2b06d31d53092b9E429BB2EeE99A6,
0xAD4166C6204025cE9676c7b0c9b9Fe7eb8E946c4,
0xaD5205fc6ec6656bfB1d5Eaab8A6813F962e5FFb,
0xaD94821279599cf33B13f598c385f85cD98daA8b,
0xad9C31757aB2F8C4247fa3Bb578946DbFAdb1c3a,
0xad9ECc0ef0FE1f1b68B9b496cf5f8A93D47fA1AB,
0xADaB2B23467E90b6e7168a5b3B2F6e825b96C9e7,
0xaDb8F994bBce44db218Dab4972f669643A6BdD6F,
0xADB9C4D8c481e2174A76Fb3DE55226Bf40CafBBb,
0xAE30d834bE2Dc2f67d809DDe43eeEc346BbA892a,
0xAe3509F122e05cDBa014b3DbA497153795cdD18D,
0xAe45B6A176971eA41F3047dDD1333aEf2Ec9f8ef,
0xAE4a1F18F2461BA512231D0a4198DA419b23EDB3,
0xAe59e3bfFF77E84B6acE014e3200510F874437E8,
0xae7ED921892C0c1B7B6ef95f4B1cA84E70a0f6Db,
0xAe8C5C72b63f7b060058E222a159Fcfd9c5Cf5F7,
0xaE99D2D0ac7ae577968900F744153f19021999Db,
0xAea3230827a775F14553c1Ef254bE8f7c37b59B6,
0xaEC034d155CCab7f710fae87E00EdC929A16E60D,
0xaEcae42516E36B15c57BaFfD2Ab54E68c591e459,
0xAEf687879dafF0372FE9a77d734CB39C3a4D8f3F,
0xaF1B75568c5649ae543694109fBf93f65263e19D
    ];

    uint256[] public amounts = [
        1081966142044530000000,
236181399675931000000,
30320890023323300000,
361389730785871000,
634317979373945000000,
5109045991986030000000,
278313948497216000000,
92498681368330400000,
2190195178828120000000,
4826234062620630000,
1862039516383200000,
413866882076915000000,
4538493980326150000,
357047421937825000000,
5267898916842680000,
3656391895039490000,
1065711653034630000000,
0,
7541881766688340000,
1204046240634210000,
653829146163672000000,
48089866889814600000,
328277634499955000000,
5079612467808320000,
2861642472821830000,
170271005157473000000,
352356688841056000000,
101974062020303000000,
40057770345542900000,
46359287005074400000,
6397053535312320000,
319013090003259000000,
0,
793679762275637000000,
47116524611811600000,
4720136150996660000,
1852045709847580000,
3941205424793360000,
3325214326918500000000,
74505257613679800000,
1054444213054090000000,
9895145178136550000,
45759746854617400000,
86259973566159100000,
96468554438910300000,
222006727107390000000,
7141092220833360000,
1129342908705850000,
370457206169217000000,
27084679430810800000,
0,
137328097698631000000,
66342872063294700000,
2453244044614740000,
1925516601360950000000,
371189123650237000000,
457762727512467000000,
9383204250317000000,
196821787108179000000,
38533404410835900000,
2148439802121060000000,
7968501019317350000,
4745173162745920000,
10331694489951500000,
322633935809751000000,
2951727850423830000000,
49479843804546200000,
125912102962341000000,
2510022282413830000,
15810800721881900000,
597104243071846000,
1538041712742110000,
43347957564398900000,
1147238989465820000,
54293898787592100000,
231993202281396000000,
19667107777504100000,
503594629982685000000,
81208724811650200000,
156861685871767000000,
3479057083936560000,
436941757461875000000,
146876886729370000000,
901087624039756000000,
517605587671603000000,
123751353447440000000,
9678182168358140000,
1288487885688660000000,
618452901572985000000,
56925229554836400000,
2203348749999480000,
66586443383740000000,
348136350405444000000,
10442330777730500000000,
107165172765830000000,
0,
16568080195573600000,
1352093874172590000000,
6409891711374150000,
400669068881369000000
    ];

    function getRecipentInfo(uint256 index) public view returns(address recipient, uint256 amount, bool finished) {
        return (addresses[index], amounts[index], index >= addresses.length - 1);
    }

    function getSize() public view returns(uint256 size) {
        return addresses.length;
    }
}