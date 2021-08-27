pragma solidity ^0.5.16;
import { Table } from "../Table.sol";

contract Table_27 is Table {
    address[] public addresses = [
        0x9D8385f270e7F709E64Fb6467b94373D9c4FBc52,
0x9d9436456a55505Df3d131981cbb73A9672cC774,
0x9d9fea68244CE53A80A84aE97f145A4BCf29BBcB,
0x9dAbf324EDf9337Ce25DFaF69bF9Fe62F17037cf,
0x9db7a795C6e3EE2e9EB278FFd804fb09F2ff417B,
0x9dD9EF77Bd909B6386E9cCC8aC38D75a0E6965EE,
0x9E05fa03318a1Db76455b53b76EDECA76BaAB9f5,
0x9E0dB78968F9aECa2fB82A59601D0465510CB98A,
0x9E11A9a6ac48A3a6ad32B749aE6BeD738188793B,
0x9e23B76733704cC301B6D15766F33607C1c37A02,
0x9E23CF319129b005d3cd9773D625896124232602,
0x9E29E005238A006D664ad032cc81b0edE99f96aF,
0x9e321aecb32C2aA81c8465A01f2581Cd3FF76b2e,
0x9E5BaD26FF3Be024aCb056004C98ee888e5c6233,
0x9e6084518448162987C20f4Abf2BED9f271e6e55,
0x9E75248768428ad52D6935BAdaC8F60C00b95935,
0x9e7D354B9c413C9bEDb348955C1B2e29D5e916AA,
0x9E7E418DBFc17bd0Ace9475C7b3b6F6605436d17,
0x9E85Ad74585CCb4441f09124f8A3Ac11eFc49372,
0x9E926F58821AA86F9aD6cA4c3624A7bB48e25910,
0x9eb03e00759071A0171689f8a357527f2BfBE81a,
0x9eB6A31E97554bE3627AD6aa650a435f07a99835,
0x9Ec48C2F1B671964cF2D41E216227482159E8362,
0x9eC7c9cF7403D13aeEE05d9f5F4EA56FC4F96315,
0x9F01898B30bd20BdC0A9A9FEE0eC3783917c4770,
0x9f14191165B346B836e76a88f0DD780b95AB6663,
0x9F37191DBFA8160815c0FAaEfEC4c0553f31A7e3,
0x9F373885888F4D7f9e845c827093A4a3Dd4e7929,
0x9F4cb6ee90A4b473bAaeAdEc34B68714Dc7e81c8,
0x9f4ec6e9b1358697DD79E7ef05C6DBB8f71D59Df,
0x9F5BFF4F6fadc655e9F3B0803B69B2D4536Bf095,
0x9F67C78F84EA9E5A2B5a143EF4b6afDeaE884981,
0x9F7D98Fc341deAd8F8705e5d175fc7cE576Ca4A7,
0x9F861b023B82079b78335976628F6Ad01a0c1286,
0x9fb96c6556562E660811c99da2351d99DbFDB188,
0x9fcEC253B5A040689c766F1aD61Ea62cA0Bb104A,
0x9fE5829435eB70d4a3C51f8Df130f6AAD3475Efa,
0x9Ffcd637B20604570932a075D1112417287bBFA3,
0x9ffEF12b090e0Ba6FccbeF868103a5bAab1bA700,
0x9FFf14F3A495d90566621AD876ccDBc82AAEdA18,
0xA0074715b46CEc3663745b8CC8937b49323CCec9,
0xA010546844924d144152cdA7F27939F21341ab5B,
0xa0123637A7e253f40B775965DC30F91D305afDE5,
0xA018D46a77aDC0D4beE01689c32f37F671b8e96F,
0xa05F4F2D15f7e4518E62A21228b79427406Af910,
0xA06C2B6F1975228ab2C448cba0f2DDFd986f46c0,
0xA073c8f36947bF5799cb39BD05c0905F3d4d9C7c,
0xA0768Eb6105Ea16E844c5b761c92ACF1B2cEdABe,
0xA07840094cbc319fd44f648555101B5f3D725240,
0xA081F87D8b45F26562f54DAF28478b150C44EE8A,
0xa09fc3bEb9e8Cb810d94a9813cF806ce98521994,
0xA0c78baaCEFce683Fcf503274df19e9097a56B1f,
0xA0cD89ebDD3c422925696Bb1baefb6c3eD21D8F1,
0xA0EB4BEA36F8C53489C171Bf9a2190E0315db61b,
0xa0f319087FbAFabe45231F1543d8e98FDAC50ADe,
0xa1066668E85a72671e75Da6A0202156b2DD11f02,
0xA11a4E11c1D78FEdb761632C1fDEfcDa98C9f96c,
0xA126226148d30A9B76Fe1733b565AD4b5BE771fC,
0xa12b1Add4be03f9308F27e1241be9A3a97565fD0,
0xa12Ec54c173c9b89D5c9674229D8be387FdB65F5,
0xa14173A78902D92431336389DbF9Ef0cF74e3321,
0xa14Dfde21488C3bb665f3f742B5d2b70801782Be,
0xa151Fd9376B7F00095b336cA2ba4F0B0748515c4,
0xA152eB75Aa843F5B3ed32BB21991F740EfB97e36,
0xa157e860930B705e9a84A84B75Ea8b078Aeda9eb,
0xa15C279b9EeE7660cFfA33da62814159d9dD0B55,
0xA17b2B66d02e49056F7F94F9cF9aF09a8dBccb4c,
0xa193DE0e7a4EcF1103e05995c83bC107a0Dfb802,
0xA197fA58C643A7C70fdf6b1008D02742E51fa91A,
0xA19d373842d47F8f6411336112Cb94237Bd7dbcb,
0xA1cce40CE16F9A81616fFAf49CECCfF425279bE2,
0xA1D2254306f4E40669A26Cb9C7f48C3aFa83C1Fd,
0xa1Fd71f1d707F6191A1D6442aA3DaC32495f71A6,
0xa22540654C5F966FBD3b0e8337BfE57d4582dd61,
0xA22800d34b90A3BbB9399845d256029181F54519,
0xa25570fb4A9B443c272C445789Cbc8699435854f,
0xa258bd1Fb6257fe1A33C3F56646338e1349db184,
0xa281421BB76D1abA00D307A641C576fe15C57B47,
0xa29609810A7516BDA18781197E083BA20489B458,
0xa2A528458172C38c7114A24a36e441ed7bb9d8b7,
0xA2Ae72D425eD43f9648a3a7c9896c9C2E0308DE7,
0xA2Cb34D5D167579132726D8922A7df5A044A73DE,
0xA2d2A5a210Fe3C33e42A5B21AA920b3F975B38b9,
0xA2db5Ff56bedF38B1da7b971f7d5BC043D1e7947,
0xa2fC51D158aA907A53897D37E0b785F712164036,
0xA300BB09e4e0E8f73aF042c801a573B4029e6e21,
0xa3080a0A2d6F2D71311b3840D07d641f0aC7E7ac,
0xa30F30f100D9e4dd294c8475316D3e982e87880d,
0xA315be16a1FBE0beBEb771035d44DD362fBb1AA8,
0xa31978A297a8e78E7c8AeF86eEC055786d65804D,
0xa31a23773795bA268c737eff36f8f27aDd00Ab65,
0xA32d657a155B10ee638773D8DFb804a294720687,
0xa34A497C2BaC0fA523E751A86Cf39a8A3B456d60,
0xa3509250cBd5F40597eFa82cbe99A72A39d51b55,
0xA35eA7A8CBB584821Ecd40D58f1cb7059037E4Df,
0xA3687E68EB2038556bCA01C50CD982aD87b86F42,
0xa3690506Bbd48eEA3c8E76836afd7974af2c6282,
0xa380D05dDD16f2A8fB67CAc535FE0B2E400f0133,
0xA3C49Dd4eD71737969da11eE8E1692803A9ce21f,
0xA3C5C8B6E5BEb9D32cf14593D85a3F3305C6be89
    ];

    uint256[] public amounts = [
        1602672000000000000000,
114571209742950012000,
810072286077767513753,
282570666924088014727,
574664253684492322850,
93008100000000000000,
7860943706999562492261,
33000,
298541622173072911437,
5658267222678718273978,
4171789035452074185200,
13660742946937501778467,
102152797024909731400,
5800000000000000000,
10057078798685292150000,
165430031362458335046,
121057211291169994151,
122437559508698417341,
24361313072872354655277,
62000639359079725000,
2500000000000000000,
2956645795750842977,
4350000000000000000,
11495000000000000000000,
9756500000000000000000,
55770000000000000000,
1419724283673305970654,
38676875055619376997382,
10040740356524174290,
494260370588153505083,
25000000000000000000,
603964982954723168479,
1950000000000000000000,
275121697033093522865,
13164375739900936619001,
11518143919024319954,
576506337697065484,
1833595614854319859890,
15403246444896358808,
856317976639088634,
9200000000000000000,
69383033772432474651,
24838290879211175290000,
125693303204601473000,
2871257284417554592489,
192500000000000000000,
2018270282713972484478,
10123280058708412611,
1141450000000000000000,
24703097185890684280,
683435811660127040000,
659576832102289838937,
57729425785241578940,
206070000000000000000,
6279954117042348590,
577582069817078108659,
2912183993794324579,
100097492777488179712,
71403800520367768728,
849392078130875093502,
798141368986001396896,
2700000000000000000,
3396000000000000000000,
254532000000000015613,
543401772875001189055,
9200000000000000000,
2500000000000000000,
8576601400666556649,
144925000000000000000,
9453509569648999605668,
10840000000000000000000,
18000000000000000000,
77730047796657657751,
5310000000000000000000,
1580318162287540529369,
756984387838948212000,
68267246570214728400,
547485400000000000000,
32547339869304906845,
193980000000000000000,
108300554117882812179,
210805734489923952047,
54999787923160918200,
113423096667620016183,
234821127103503992534,
2500000000000000000,
9765600000000000000000,
5358055840000000000000,
258437267612775275735,
22436691893309745026,
371779043433410448944,
54867758230594420800,
1794924735741602203530,
5703573015612161350000,
433508243605611215428,
14210384645094229815129,
197260085132102864441,
96667690191321785825209,
447763357519356332472,
75077247217887493291
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