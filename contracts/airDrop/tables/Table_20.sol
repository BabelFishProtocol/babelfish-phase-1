pragma solidity ^0.5.16;
import { Table } from "../Table.sol";

contract Table_20 is Table {
    address[] public addresses = [
        0x7274dFD423b826fB274A8F579062a8a14CDbD381,
0x7276F8b3a8EB15679F572973F5296b8cC4c08Fc5,
0x727B6FC2d3089d2cED631bbED8e738Fb1DAdBAF9,
0x7298c8B33d8C93faEDcFfE0478684C12791C458F,
0x729B7674311fd8238801c5aC615E52B88b8f149c,
0x72a4e83A1253F62c05a689f2A990E97F965403eB,
0x72a5f05f307df02ba8CBB7e2db5561173FceDf3a,
0x72b572eE3b0825b2b08B4c7a4744138BaF8C9746,
0x72b58B06AEd8cFf8b5f424F55f7dD6edc955d749,
0x72BCa10a70932fC032DfBB8F3f0b7A60ce7a375B,
0x72c98c2738370fBCaBFFbcd2F1684197d8610FdF,
0x72FE860cb95C2550EB2CaE47567cb31FA2350b04,
0x73162A6f5Dd603152506080af350a58d349997C2,
0x73258b80638CD79e168C638a997F90052051d7BE,
0x732eae5C88E2E637F11175E9CDecd36F94C5193d,
0x734485427F887CdD1b7dC0E4E73CA9D09A85d7Af,
0x735134d3b21ebC940FF1436d85CcfcBD7c42cDB6,
0x7393bd7FA4E0F1ff8B246D38655787a8afA17bc9,
0x73A80179e07aB1c9231eB5A0921A9Db3ab612e06,
0x73b6a7A6E39A2E405087164d7F407A0Bd2c86dcc,
0x73c3Efe353c9b3c60BF236e6502953F51CB121E3,
0x73d38D824fb2a24d1D888DA0E582A850CB34343b,
0x73D4D8a079152c01426Edfb32397b605108998D7,
0x73D9ff0bcacba526a4f019B593eaC5Bc7149e2f2,
0x73DEdA6d1E765339BFABfF4fb4d77b97CB0B7A08,
0x73DFAf265eDcdafba31dB916ef06E58B924b14b8,
0x73Ef86Ea7f3E372BA000ff4e24899b0D5963e821,
0x740ECBa3aeebF6D21d779d7b2aE9673Fe795Ec92,
0x741A704647FB24DA9988be03219b55e485704Fc5,
0x74270f5FCB9d6055E94ef0f23b01dc4d6E2407ac,
0x742B0Bbb806712bA546908F4b9fAFe819f2Cda2B,
0x742C95602D7f67b8a5B48a513bcE27B844Bd87A0,
0x743A69a1235E1E296Cc044581a7Ecb19328716aC,
0x743f45FFC7578f8982313Ac4bcB01e611A376EB5,
0x744aAd2dfadeAAbfa07035eEDbbc7428d43124c8,
0x74575c155cc11354B3292ceaEaD29E1c71dcF9D6,
0x7457667ee63BCa3c134f246af687091e7E259Bc2,
0x7464020d5655C7614497410eF1438a527e8BD3D6,
0x74931A63f678581234ebC535724517778084fDdD,
0x74Acaa22Afa3cc93769AF2567FAb987DDecFaad0,
0x74D584565DcA4Bc3a026C1cA65722e6E0097f162,
0x74D5aa1C3e1D75C46946f3e549795D0189a2919C,
0x74Ec3f1a9Ed462869F1c322370Ba288c60Ce9f5c,
0x7510b6292aC70AaC3D17CdD323A03cf9382D5C31,
0x7525e5dE814599B2EEa19774946454bd4a93395F,
0x75352403b0355bF8C7b92bbd27fBE09d25f099c4,
0x753FCDCC2E0aDDbfa702145976B220CE6fEa9Aa2,
0x75519EeB2064A501Fda4d174E1DcFF011ECed4B2,
0x7557ceC42700B1f5a7173B63cBb4EFA5E4E3865b,
0x75644ba6a7d73938F7053af1c179D16510025915,
0x7565151B304F6CddA18A744587adE2F339C4ECC3,
0x75786e168f520d3565667d966c89A00703f839Ed,
0x75d53Cc46045d5bF25Eadd70b33E9d949d45b132,
0x75F3CB1e4d9d1de8A9a5a6FEDD95B83Cb696A88e,
0x75fB18158fe867958e24DD16a22d94a1Bb58c0bA,
0x762022Af1310A1b51BEa80d0AF26428C3c9E9Dd4,
0x7620Fe388F24F2999fAaF5b54F5C8d7CfdC9c62B,
0x7645B3f957B74A4062d2e7c6ae69ddbA65E2F5F5,
0x7647FB3B14f80Ab59D9159bc42FBcfBe56EE5D1e,
0x764af40e98Ef40A26b53b81C62353Aa21d07B527,
0x7656Cda6b63109A037Ad006851b975aBdC173E71,
0x76742dd34b063396D405905C8d533A19169a7AB1,
0x7678A3324cf6254f832753Af67efb76610FF2B1C,
0x7678bDe82a8fbdE658244116e9bA77473BB8a86A,
0x768c3C340aa5f0DE946647391FFf30A3D1f5DEcF,
0x769a1482E52d28225E6A71Ec56b58FF6BB0DaF63,
0x769a1ef6FBfa918d685ba02F3c2E45CFB902EBF7,
0x76A58331D9C56d6173cc2C6Be3428A1331708f39,
0x76C09e96725343B697dD6780D802c67C2678AdB0,
0x76c2728425223E2eE39B9Ad709Dc74C8A086Bf0d,
0x76C977f7f1EAFf1F11D99533a6a7b58eb6EE43bC,
0x76ccA216cEf6869926f20303e8B27A2344285DC7,
0x76eb030f7E524CFfC7Cb4933ffb591a0F20194CA,
0x76f794E349d1Ad52F1aC2504D543Ad2D544B7BB2,
0x76Fe006F5A82968089cCb0cA39D35290daeFad8D,
0x7709D1a22DAAc67f25632327ACCB9679cccf7012,
0x77208B583835136B7C91bA0f79ceB759D670d1C4,
0x772544c2aEDA57535ed9143916E20e55449AB949,
0x7746085f5302CdFc46FAb65Efa3CafdBf3edf3Fc,
0x774B7716afED9F09fd4223ab013d61699b316dD1,
0x77577573c2ef8b78e660F0c8D66d22F6696E4314,
0x7757CccF1b3871f610DfCb4CAa184ac749044b5D,
0x7768E84Eae70800Fb873C1e585a5d2Edf7561986,
0x776Bf0Ab7c3B2589866247a3E319C3376f29C8c8,
0x777C878Ee35c576d470405D7BC8e102649A95f21,
0x77953ec6021A72fAC5565b8C40C6aB2370e3E146,
0x779Ac2007760eeC5B810291162F68Cb1360f1F5d,
0x779b2F454Cf95Fa735C146092A41d43dB37Dd3F1,
0x77a170485f570aF862241A231aCCF34B7630ec34,
0x77b7DE8518Cf6DEbd4517A5f3C8C6d27db3443A7,
0x77C16A7D18F7E917a2699C81e4702bEf2b522522,
0x77C81eF316a6c7523CAecAd895D5AeAa55069709,
0x77d179D9120c7D500fD9D50381E34eE1FD2ee25C,
0x77D95A0c5dD76cd64CAf13a1B73a22F322957e80,
0x77E0Aa03f37873241497B2Bc13c63F69Dac3FC4d,
0x77E7DC1a29921d1F8Ce58e2588073E1b243c275e,
0x77eC8AF099Ab65866BF804ff7Ab097587ABA9D0D,
0x78224fB36032ae4f80aC3236d403e60f80b07a6F,
0x782449b608D23729f916f26B960A7FE3a9206256,
0x784032565a78a8588D3C2C06e840C15C09A0A42a
    ];

    uint256[] public amounts = [
        114450000000000000000,
386216124869766263255,
77728471612428844699,
292270000000000000000,
410041000000000000000,
62195049000000000000,
3100000000000000000,
6192000000000000000000,
4472831321358787193,
47797848956748440258,
8939200000000000000,
1592029578873456700000,
7933560587329837556,
6074100977870812704463,
1253623380696430250207,
11780926580038757048553,
52,
9962330442804594691341,
28297314626622358329,
2344147185330382324,
372876781209608897,
18918618749028180507,
218319310314704345747,
10000000000000000000,
1032191793705878278196,
56331681663869541600,
997951848808555227,
4350000000000000000,
58027028289125557840,
10012500000000000000000,
13500000000000000000,
684764078968255554919,
2741595000000000000000,
198000000000000000000,
63443882972555739925,
1052359056533188613812,
16758296709014713380,
161566338080878681770,
904478225143796240000,
40002774538677550909,
52,
257097000000000000000,
291332440427280170000,
4128133826519247966757,
1106416146261298190000,
94000000000000000000,
132837577820186248190,
3296220000000000000000,
728829428512863459328,
13419720322291364487613,
24966632316834114815,
406357407966201561878,
660000000000000000,
495000000000000000000,
617136928027482596957,
56000000000000000,
785515033752160236711,
50000000000000000000,
50000000000000000000,
594278418390164142300,
331564486213164095645,
85442171597923767168,
252131290605697877560,
16983149189889989795906,
3109900000000000000000,
171127410344329741385,
49050005578803788720,
86092851273623667000,
398518325965857533322,
31000000000000000000,
3812620008976394314107,
348281468256693934173,
23000000000000000000,
2700000000000000000,
15898543278952628999,
450500000000000000000,
4100000000000000000,
2136000000000000021211,
69467680417445722236,
500000000000000000000,
23551910362111897247,
912628221861066146615,
35904000000000000000,
194753103927093007627,
425460682700913997,
226306131881676275000,
475820810188989344000,
10949649862882151546220,
7761212508062272976,
97240000000000000000,
1685152612753922331782,
6926700000000000114285,
17663438245034778320772,
302109809443647702812,
23000000000000000000,
106481985502428406562,
48000000000000000000,
9900000000000000000,
2978635990139687881000,
70000000000000000000
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