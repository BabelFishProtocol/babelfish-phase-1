pragma solidity ^0.5.16;
    
import { Table } from "../Table.sol";

contract Table_20 is Table {
    address[] public addresses = [
        0x6eE542368dD6eC349Ef72127A718eED46f3cA215,
0x6eE7fe8d2fB35268D73aD9fF5607393aF0001363,
0x6f17905EA7a74e8C2592B4486526aB5dE6413081,
0x6f2E5527DA62F1d785e460e824664d859BBB05a7,
0x6f3f1fd2d22CF926299EFcf058737B71458632F4,
0x6F50591A8A3C81FFFaA96fc2713dF209efB846B8,
0x6F658FbA57E9D826Af17018Abb38b47Eb4c197DB,
0x6f6634B2AAb01df7F47F615fb4E2b876Bd3aE5EA,
0x6F6C35B133645D39316B4C8Aab466515EebECBfa,
0x6F73F0171326e440DaBb8EEd9998935ADFc56D34,
0x6f7d991841CeFF8cEdFF91CfFc913a2CB4560d71,
0x6FA2145acDF691ED49c9C6000c0415B9cf6b7Be3,
0x6fA429c79eF39e10C4D2bE7f10aB43a1Dd715B27,
0x6Fb381669d62143f1E990912CBa6B9c8Cf6E5Eb5,
0x6fB9966c429eCC1ebF3ecCE4bF01DB258DA7eD0D,
0x6FbCa76fBC317b115C858487509EC1cAbfb644bB,
0x6ff0e6902fafd14c8e318F3eCC54fB63F4997845,
0x6FfDe9a758a68a29af3D9354a9b69dafbe96723b,
0x70093fF5e7F6227fe2BB63608CF23e598A940E32,
0x70151C4d46E7D39688DF974Cc1619F4D1023DE85,
0x7026c310fC989Dfd3be9F086348fdA0C1F9f91C1,
0x702FE637e120042A1b80e9AB97242462Fea30850,
0x7042cA0C2B96D4Fb57308Bf48BD59c511C3442a9,
0x704a7e5395f736ECe6ae83faB8b34E08527d73aA,
0x7068F35e53e33aB5c6393A50eaDd57EE89C5FB80,
0x7090211Cd50293280e1B33B84e6874B57978025b,
0x70977057a29F6dB16cA0EFda628EFC8b3814B8a1,
0x70c25bc57Ba1F582075893D50De804d407FE68ea,
0x70cc547Fb45f09d8D0F1736151675edeD909278B,
0x70Da3E340e7A082F4a2F2cb87EDea66DC3922f81,
0x70Dc1E66a2E52ccd7569725860Bba22139706e22,
0x70dc8aC25adbfa6DD88B7e55D455fEb427CC7FF7,
0x70e82f7830a04832997e7c82f3A27C0704De4D02,
0x70EC3DcE0CB4d88dce2dcFB312BF63cc09C2dE1B,
0x70EeEFFdc3f071aF34415eB4a7d1Dc87F8d769F7,
0x70F946D149e62eaA199cc2fd331374F81F2A777E,
0x71059bfC9D3753223AF51559B222FDa84A2f2507,
0x7115B7C9dE77E0D00a8a1bC610a4FB058bAc21b6,
0x711DdB4EDBd48062cAfc9A61914F512fD4fBb63F,
0x7126D9Dd3fD2Bfd759d817b3149731B8EB6CA5F9,
0x714E5C411BeA681aFbd1db903CdB901D6b884Bda,
0x7164a7E6775Ee108b52a500E440914F2e87bAFdF,
0x716cF8527Dd500B1e56aFbF26a2a17f83632e6ef,
0x717f8eCbE2eF5720F2d05e43950886D993AE74D0,
0x71857dB1f975866E63E1501a31F95B41Be8d56AF,
0x719470762c45C9eA2351F273322bdC78c6eDC94D,
0x71A32bCA820Eb0EC1c259341b517098f718aEaDC,
0x71A6a6Cbde61413c77F75e40f91C71f5A027F4F2,
0x71B2a052F110F1fA2C25CFE8a1F934c2F6Af1097,
0x71cE27e564eF18eB811139FdD877E8f5b90892D2,
0x71D2c00a1a6c11145c2B54883b1995F3439e1088,
0x71eAAbAcbdb99217d70E3A8D32e08690e5304254,
0x71f485490D0DC33F774073F0CF0e1DACFcBd6d71,
0x71f8e7f830B3AF30f6CdfbD6095f8169d04590D4,
0x71fdd558180fc5aA28C8cf12c7dE7A7E9Fb832ff,
0x7209Be7BB9B49f72E78bA65e82F838DbD3be20aA,
0x72119674EB3900b1A0d0163c8860C9aA04e8593C,
0x7213cEe753Eb2E5a80772E7fb598f90c38989A0a,
0x72172aF1BFEFB4b64f81787E6Fa538cf765dc871,
0x722781Db748cC00A944D113db22Cd9cf0986e1D8,
0x722FEAb91c7484C66DA25251b40E63254ccC4663,
0x723256525E84d78f97D6c21AC69d5B185e99B27B,
0x7235e7c2B191c6D0dc328BF19f4A1B211f0C9d1f,
0x7245d8E01Fe091077aC0338e7d99998057Aca77E,
0x724D282C4190C662C6E9D9B21c5Fb6CecB2D064f,
0x7252116b5844dFa5C40d415576F6ae66f5887183,
0x72574f1767C5B6730be391d6328e7aA617C4e7D7,
0x725b1bB3e1EEDea06FF702f454142Dc63766A9aE,
0x725e9e3344259471988e8D492D37207b05C7f8c5,
0x726C75D29820D60eC524FDE644CD76Fa82AF2741,
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
0x733E766A6388C178DFe2D047256814959322D9e4,
0x734485427F887CdD1b7dC0E4E73CA9D09A85d7Af,
0x737c996E6004dB6534A7C77b6E1AF166b79A3A26,
0x7393bd7FA4E0F1ff8B246D38655787a8afA17bc9,
0x73A382055345BA0496260f0f95A02734FF53b2B8,
0x73A80179e07aB1c9231eB5A0921A9Db3ab612e06,
0x73b6a7A6E39A2E405087164d7F407A0Bd2c86dcc,
0x73c3Efe353c9b3c60BF236e6502953F51CB121E3,
0x73d2f0ca4304DB9C9be7fF0c9C3523AD6adC41aB,
0x73d38D824fb2a24d1D888DA0E582A850CB34343b,
0x73D4D8a079152c01426Edfb32397b605108998D7,
0x73D9ff0bcacba526a4f019B593eaC5Bc7149e2f2,
0x73DEdA6d1E765339BFABfF4fb4d77b97CB0B7A08,
0x73DFAf265eDcdafba31dB916ef06E58B924b14b8,
0x73edcD0F5cF8DF7a3e1d11ef5d696c266d996F9D
    ];

    uint256[] public amounts = [
        2273533382357680000000,
1142463417722780000000,
9556415931036700000,
1629061115765690000000,
1264864057750550000,
34655473327757100000,
435599007690950000000,
4983917243936240000,
1023017496050210000000,
20054844126191100000,
330387944027912000000,
11796659065868900000,
2563956684549660000,
9739917931494110000,
3478376158814010000,
5109467679961910000,
6409891711374150000,
140494858419648000000,
0,
11711783971506600000,
2275516088157810000,
12968648321746500000,
571631075311802000000,
0,
218233382143740000,
924616587053709000000,
1676901625369350000000,
367977142402532000000,
26450924122313300000,
854681070006313000000,
2100454224554360000000,
1026652647234910000000,
55792359514999500,
929958137111330000000,
105,
310336294539013000000,
2577940724991430000000,
180639904555192000000,
1527270917833860000000,
5449346113074780000,
149024582341497000000,
11517769757197300000,
1116841229294630000000,
25009360325024600000,
237162010828228000000,
0,
561059704575124000000,
130472316163056000000,
3805300602711970000,
855162867193423000000,
5109467679961910000,
0,
320583640226371000000,
14482763415707600000,
75516581271901300000,
1021891350141930000000,
110394245311011000000,
562758513694281000000,
79573658600980200000,
2703458075284160000000,
37532843338923300000,
15592001483027800000,
61319630223508700000,
15154843792542000000,
0,
35255778433501400000,
52957270458732200000,
24510892691866300000,
48674976222841900000,
379122501853174000000,
24253083505621900000,
365870117580123000000,
35211939537908200000,
9496637891286160000000,
93756445522579700000,
6421900575521160000,
271042298089403000,
687864088018767000000,
145205022735525000000,
18337560872692000000,
1703559213906790000,
139195921188441000000,
3062236342623490000,
2486618622128650000000,
105706496254867000000,
7861620268236510000,
2984948693486940000000,
5238097866440710000,
1653041523795710000000,
7798360731588190000,
1906678926309150000,
875991097325330000,
8593275948698420,
13960112008236400000,
9764047580573780000,
107298821279200000000,
5109467679961910000,
90319952277596100000,
5397872685551070000,
435153864384709000
    ];

    function getRecipentInfo(uint256 index) public view returns(address recipient, uint256 amount, bool finished) {
        return (addresses[index], amounts[index], index >= addresses.length - 1);
    }

    function getSize() public view returns(uint256 size) {
        return addresses.length;
    }
}