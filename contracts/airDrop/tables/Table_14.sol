pragma solidity ^0.5.16;
import { Table } from "../Table.sol";

contract Table_14 is Table {
    address[] public addresses = [
        0x4f256D98Ffe70362Da43b2eE407891679Fa7E77E,
0x4F27F4C6E66718676C0Ab646aAeCE16DC38E5a9C,
0x4F327FE9d11e89F482397273FE8A207AcE7A8411,
0x4f428525b96C7e8Fb0B8F7E3e7064743d0b3c661,
0x4F5EA134FD2D445e446a418abc679425371BDf90,
0x4F5EA307a5f2AE2B213B0f38B6baf39c53EC9fD1,
0x4F66b17A1E1da5ACE2E6bB307992f4DBabAe3959,
0x4f6ccCA58bf222F1edEC87757a302C0ba14e6B1f,
0x4f750503C11563D6e1e6431700B2a40F8Ce9A7a3,
0x4f7e8446231Fe14656F0e543741F584f9281D55c,
0x4F8b4ceab0081CE6f0fD3449BD948F917099649B,
0x4f8EbB9A9e347054B22fD4E8D3b4F3092B9362E7,
0x4F9476A750Aa3dEbcd3e72340A53c590AeA288a4,
0x4fb36692C7066c2b46E48958f9EeBEA8d6D8EF8F,
0x4fCd4fd4c1B8d8809c12abfA6E081B199A57a6Bf,
0x4fd1553713a551283D6533EEEccE37e0Bc684460,
0x4fDA03DD0e4eAf958F48862E1E8019E02c064D9F,
0x4FDB6CB4cc65c7Cc24a928F1aca37807f589F8b6,
0x4fdf422AeCe95aE4bC05f24bbFf03038Da6BC823,
0x4FED422AB6B4a9Ac2BDaA9B86b7e356a7832D611,
0x4FFbDAC8F9f4759a420CD392e9B5bC919fF45F81,
0x50072AA47D80A291B57607AA3f458007a41312D4,
0x501C91f1d44177c84b9964a64c76F4036080E260,
0x50250bBE7eed8f679b184f53a8F7D9a73A29474e,
0x50375458dAEb8ad0A3022FCC56F40c8Ea93D9117,
0x503820442505327B2388fb6808f1dfC503cfDe12,
0x5039B7c1B929cb5c9dA62C2b45574a47463e406a,
0x50693E63A0Abb825B1Ba99564954D45B6e45A632,
0x5072D9e034b97d32af8f14176F3Abe111aC39Ffe,
0x507382FeC4DA4aa326B46dF753bB836920500585,
0x50755c470B12593f9a552d56ABE097200b4ff76b,
0x507c28eB3806cf36Fc8336f7Bfcc5428F518706a,
0x5085246b958763Ef49CD2134CEe105386dB79342,
0x509AB85bD9eFADfA3DEa8F2305f5d8CbC8c70B1B,
0x50A4C42B49F430B6b7E4779d7495B49Fc5761Cf8,
0x50B4300644f525540975C9F1acaE4404d0451b18,
0x50C26556fafB9D86f671071837d507209D0abaf8,
0x50CFfCEb3405090127d85aa9EB04D4EA12A3D9Ea,
0x50e20d00f4d6d0203a3a4c50EAc893FA8c1097bB,
0x50e3DbE9A80e61f33963523116517cD7B172a73B,
0x51025035DfEcDe3754595162cC8Ff75a2Cc0Ea7F,
0x510b900F7C34B9b259E36F9C7cF63166bAd15301,
0x511BD1Dd6c984B824c44349f0B24657D55A33821,
0x512355e6ED4497509C4dEA0e2dca6DFd0bFA494e,
0x513dB75aF7e4A710eF67BcC593b586426F21EFd5,
0x5146B4078418A30730aa6627AE5af69EB8b675fE,
0x515390458a0822D94c50C66e60a401F84b01072f,
0x515f24428dFdbf7Da062Ca7f1F7AaE27c4F9E00a,
0x516a84c75A73a0e99fC0a87A28a9cf879F246DE3,
0x51aAC2E17f97Bb9F98D7Bea8Ad202Fe3C7035E7e,
0x51AD60777E4bcce79A410A76454671af38637d3d,
0x51bA6A3a23507A0C05C373c95B076aB3D3b50144,
0x51baE886bAc73A8B2B8D71DC9090573ddB6f0760,
0x51c209099D392939e4686098F36cf98aC50d1135,
0x51caBF7D215c566c93939f261AE35A69c5465fa9,
0x51dc722A2f6241eCed0dB952EA6054D58E1784E5,
0x51E1D29DeD3e44f0f6266da4bC7F9167374eBF67,
0x52019A933CB2beaD77c72043B868317205cD5f7e,
0x520450D407acaAd269931A65d30aab3De324458a,
0x520CDF15FacaBb1952E5F76522Aa6B208D809B5E,
0x520e89E220793E19Faa90DfD27E27b97B945Ffb7,
0x52288335eEb0975a03256b1EaCa8B2f6ed7f8AEB,
0x522cFB2C4Ac7CD7ADA39DB6b6afd7AF543Ef0342,
0x522FB4058B0Bb43CCD1e40a80A1C03eC26a71825,
0x523633dCDadae78255aaf0adfCa83c0c6dAcad79,
0x523dF56481b1F7791492735ABe170F3E9Bd63a59,
0x523Fb6a39d873569b9D0Ef60Ac98Da8CF31F9e16,
0x52412203Bc64E79E7b15C0FBE58B31a82C338757,
0x524E20dBBFD6F0949Ec3Ac600aa6A382D25016aF,
0x5262b174582323812bC6976412281911b77d4D4A,
0x52879767BbB0b12928E2A2389aEfdB64B0772Ffe,
0x52CD05CA093c19088225843B237AD2C89c51EbA1,
0x52f636188B195164110dC238d9E810A18ae1f088,
0x5320E3e2a5A8061fe451d4243eBD716040Ae54e0,
0x5337e7E2E123a95fF4200ce7F32C8008882F50d3,
0x535a521401a24846187C3AF03A67C03B48025832,
0x535C27b49907fb4B0Ee445ED9A5242FcFdc0c8f5,
0x53b9D3e36F8cB068D1B1E1581C8f51a85f6B0aC0,
0x53BDB8b56dC69C1cf4AEA0e333354AE2FCB8f1d2,
0x53c96C0aBff344e117433b93244AB52e8A171721,
0x53D183E33EC1DF2e108BfC2c31D29dfD63A13d6C,
0x53d92b47B8e16966Aa65627D39C48bF717602391,
0x53Ef3834b7D3453923Ee18b8482d8d2f4e4233b5,
0x5410120618e3c843cBE59E9c7189FCEF9f5E766C,
0x541BEcFe06725cEDe767EEA21A2B194aBbE0DcE6,
0x5428c2e416bfD5493a3F2c5765C85Dd29aef02a7,
0x545A188F57E30397736fC56931fC187DBfcec139,
0x5465bF36f820577f4A568fdcFB96Eef9666a0A8A,
0x547EDDA4b92226df9837bF20C0BF7f7628c19c3e,
0x548741151477529240A4DccD3388F1F7d1F8FeE4,
0x54881c1b56e0E7a62a3f0752180036976435b891,
0x54938dd6A14b8464B03F43e01b1bd48fb1F50a92,
0x5498104A55F4C4d28FD850F89BaD7A9a1F0cAA5a,
0x549B69005C45B0d391BaE74713Cf7a8b09A8DD17,
0x54a3001e201Fc21Aa4a2C42457a77406c34a31a9,
0x54A5A62D34d3C55Cb35Bb8B4d4C958c820c5f322,
0x54b081e38113BcA9529C0335625549c90a49D887,
0x54D0aFd5884b7e22aCf78D0ddde2D44617ee5778,
0x54DD92e18a1360755da79e7A8383A38ed39F5229,
0x54DF52Fb3620dC2F248dd6c980E72986c25E15bC
    ];

    uint256[] public amounts = [
        2184000000000000000000,
1675760124857894297669,
63997665429613428695,
4109166230551926786000,
18675765804243842140,
105108166049227326000,
71653393646297114711,
5300000000000000000,
97950776145452280398,
7440594536144778784425,
26464592400645375900,
9128420341867183487165,
984092872069643321497,
378000000000000000000,
21054000000000000000,
3300000000000000000000,
455244083812654026000,
70000000000000000000,
62000000000000000000,
2517677893410273966,
3450000000000000000,
3012204640942422256232,
197677421718638009942,
600000000000000000000,
309969503440127269420,
130041807413468236902,
50000000000000000000,
36556768663556470537185,
877400000000000000000,
113906832946947254497,
152649695553683575897,
66022028847021188900,
72780000492216115533,
596070963998468101121,
6600000000000000000,
29700000000000000000,
328600000000000000000,
6300000000000000000,
310000000000000000000,
170700699433948099900,
1188000000000002500,
792000000000000000,
9900000000000000000,
59630435373762872248,
10000000000000000000,
39713163232107157883116,
57553278463574643755,
390000000000000000000,
3934474130168613248572,
6000000000000000000,
700000000000000000000,
58000000000000000000,
389339486947076702000,
67500000000000000000,
86634393119278088577,
3359901396877563000000,
70740000000000000000,
4350000000000000000,
55228156102621326360,
558879085282711788654,
13368055459174590540647,
578739491713683598420,
1220377025058778795073,
218953154525513063089,
790729379633656580000,
1000000000000000000,
9900000000000000000,
5487516151658125944,
54709448727100117070,
473865281242839682848,
165450000000000000000,
23562327365533969418,
20597352078617402142,
1806071660895310051556,
5800000000000000000,
9300000000000000000,
783196869170134031706,
255150000000000000000,
21400000000000000000,
213989293108403077800,
9900000000000000000,
1029194485381413174447,
4300000000000000000,
30850302883097878191,
2500000000000000000,
64675762385103850620,
100021945343759366670,
398583225193630704125,
195348147301918467252,
18235212710945792047923,
1763000000000000000000,
2700000000000000000,
823765901174196086455,
29000000000000000000,
837155245547282913547,
127132481926703364929,
922725937645387800836,
35358642076259470040,
1051848000000000000000,
1178908751027115888000
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