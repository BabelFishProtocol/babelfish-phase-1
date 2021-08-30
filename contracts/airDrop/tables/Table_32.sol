pragma solidity ^0.5.16;
import { Table } from "../Table.sol";

contract Table_32 is Table {
    address[] public addresses = [
        0xbBa417402Aa7c85c57F57725AD88aA8AcAF6eda6,
0xBba738A1A98a3F2E7312Ca71896416f69F9e7bf2,
0xBba9FE2F664Ac631f4eeDBA1d6D7094fe7759351,
0xbbACcEaf5525C9e709ebC52B6D522EE02930Bb4C,
0xbbc786c26cd9B7724317163a55Eb84fC0f3bb404,
0xbBca2C1bA7639ca405bD1A001341a5fF47b9295E,
0xbBe306b2438C693494f515aD3A8d3c004400190E,
0xbBe87bEE102A6e111Bf3295ebE4c9Ca5932Cf8dD,
0xbbee7Dda7013061E027cC00B265d98f592553D98,
0xbBf80d1e1865817c77bE60cD1C66ef0B54EDB4E2,
0xBc03ef097Deb76C88149720a2a477f67427Bc6d2,
0xBc159B71c296c21a1895a8dDf0aa45969c5F17c2,
0xbC4893641A49c811feC0238A68199cabbD2F00d8,
0xBc4d531548A2dc3E43a851b1a15261780d8B8177,
0xbc5a25114ce47FA33bc7669C61133493fF441F40,
0xbc6473d981c64cfd51bD4C0Ea0E1549b8e225F3e,
0xbc6a1FD0074b4A473b78Bb7A2b21dEd18A07B668,
0xbC6c3646Bce96108fFCa4a4Ca120FcBB4B1f8F17,
0xBC9df4218AD48212bdd6bF6a2E77fc67E1e40AA1,
0xbCB1c9373B1214ce96ce847160E33660aA293fC8,
0xbCc9b1Ba3374f4A65bbD1848C0db1C7f78f32a1A,
0xbCD4dF1bF55083EC3284B18b02f04b12C2725f2C,
0xBcF2A6D57e9F3BbC6B7b3B6C1d3AdaE1863cC98e,
0xBCf51404Efac260D683dC82D1e5CDC489AfD4Abf,
0xBCf6c336671ca29f2B769146372A2B2fba350e52,
0xBd29ab2B6FF3aD84696A01ad484e138f51203195,
0xBd312E40d629C631095764C13bADEFFbE7A01235,
0xbd531Bd6f31Deba8FD3B58D16B76E0df3954Ebcd,
0xbd5FDC115f7F6f884b035362B76cb8B60AB4b3Fd,
0xBD8B6ab018BC4d01d824992e303fC51273d5B5fD,
0xBD927ECBCeB7918589d9421BdEd79f9E557C5316,
0xBd97a7Eb76c33783A4Db7EA6Eda0687ABdDa101e,
0xbd9ADBa83D6c3595Ff1B2B1699EF4cEF3b95Db3A,
0xbd9b022838970Ddb3D126b2BD7FcF3B21A7321f7,
0xbd9B9A90F3735CB110Ec2bbed934e1e7a10468fD,
0xbD9Ec6112903abAf32bd692f947BC058fe928975,
0xbde734FaB9DaedC5a1c4E6DF35D28D26EBF67672,
0xBdeca9211FA80Ae67f3bE038b80C01649427905d,
0xBDF3B9C349b6A32EAE0dae36862aa11365fB3459,
0xBE1F86409dCCA3d772443Df70A77e37A059d2208,
0xbE1Fb0BbdF7A6cb37422B016151bA7FD51ed706C,
0xbe4798B2cCA75399C5FD242100611e514e37cd63,
0xBe577755eE6cc5f347860f51f320c411D04b6a07,
0xbE63F32bd5322ebCe85e322aD77394d48ecf26cF,
0xbE87d3d27d1706Ae8076F24459605C9545F61047,
0xBE8b2AC145cA4Ddf6Cb71695d7De3aF70c0ae44A,
0xBE8d7e6eFbD36984884b2E51a86dA8f1Dfe1D391,
0xbeae9553e0f6bBe9284E913f978dD8Eb424A2b06,
0xBeb2B94446468fB0eaCC2cA3B1D62b431948dd93,
0xBEbC38252dCA99907602873A36AAD7C972b900Eb,
0xbECC1Aa1bB565d487B93ECe573D72F05a812f9ec,
0xbeD732000F3EbdaA7C344ae53F5cD584D8D65e4F,
0xbeEBc0c769a24f94681d05751fCDa51Fb780931f,
0xbf0f2da2178355d029A634CED00b4de565d38C8c,
0xbf1000fB15cFB6305276bC3B85b1B0B79b4c31BC,
0xbF343e8a4cddBE6a305739C426EB485ba79E1f5c,
0xbF4Bf2b44ebF719eB72939DA8557d1792A8a6401,
0xBF5468F687B9aF43f647F561B674B79611e163D8,
0xBf7271798AE210eBDD6D26a7D2e944592E7c7e1b,
0xBF73e9ca571567A55CFffd0FbEB916f8ac34528f,
0xbF7f42A2be2c9E6722ea5b8043bDb19E10a548dB,
0xBf8e6FD743a2bF16667A5e4a7dFAe15BE71801B9,
0xbf94F430dbddaf8e50256994f3FF06b45c811936,
0xbfA56778F6c79724dA3c2090ADB59a7743aC5743,
0xBfA838fA5bF6B12a6F0Aad88DC22fd9a3e5899Cf,
0xBfbA3B3494E45bF8E2Cb871527CE314A6C860B2E,
0xBFcb8D211809c665B190bd14cE7356bCC1cA9CF5,
0xbFd7dE39db0edd0bB912de917E1553fe42400402,
0xBFE14af87B8E0f850403CE42f4Be19ce0b28c8E0,
0xC02bFC8c96477d82Ae78d3212b802C4bfC820F90,
0xc0389a5A20F3bC9F5BCf6f63821807539dA26f16,
0xC041a3786ca11CE4EA7384D5ac9D5DCCfa7a33Fc,
0xc054929B9cC240105D1E2a346D95c4a7B09709B5,
0xC07733E77F0d9cdE4208526c899200302a3Ca307,
0xC078cCE8517A2dcd65fDa7503a0F2EF3B39fb20c,
0xc07D1896574a55f4A447A8d2f2a9D00DF783A284,
0xC092D7Fee1A09257b69604eB698f672a656dCdbC,
0xC0bfdDEa4dd2F14A57E8512Dfa0546e001A9ec0a,
0xc0CaBFB85ACe357eb404e7735B969764A2C867ef,
0xc0D68f206961B745259B28157AbB2D640b25016c,
0xc0E3AF9aeffDd2042105e0838D2b7Bc699e72CC5,
0xc0E8486542C1Ee231b25915693C67235Ec0f34a0,
0xC0f6Cd374C281E0acF1Ac026c398E92d9E9932FA,
0xC0F9e8De7cE5ad40979de08b6b746BA47Ca608cC,
0xc0fC996423fa30e1ddB325dbaAFb356af2CAaeCe,
0xC102288F1aDF931C2D26c594b8E455B950744048,
0xc1098D3cB79FdF686f8E520B7449ba57b14D4E33,
0xc10Df72C5193bFB834E8008A82e83055B2E607Bb,
0xC15B2336797a5A7F3110453598462FbaF4205AB6,
0xC1612baFFd9aE385B5eaEB7f3e1f1B051c3c4816,
0xC1651DA5DE69Fb7ea4E7D27eBe6179DE372D0578,
0xc169Bbeb4C2297F93330267b48580DD9419f2D18,
0xC1926E9300aec5054657479D993491cb6751c187,
0xc1d06B80E6Ff081b1690cFF80ad0810c9fAad48B,
0xc1f3eBe56FE3a32ADAC585e7379882cf0e5a6D87,
0xc22dB8Ff332B8F553e9C9d22FCf60b615597cF56,
0xC248f76395A5971d6Add738dc3301241FBC844FB,
0xC25B9185447BD635BBDf3a46AB7cd079fC76f927,
0xc25CcA58b149ff5e1752042567648Ba5381e4349,
0xc27bDc0E8b8E3531CDe0a10d766108D0E9d8bD9d
    ];

    uint256[] public amounts = [
        27000000000000000000,
90654341680804113000,
214500000000000000000,
127096523486146372926,
39382000000000000000,
21000000000000000000,
480000000000000000000,
1646189400164338600000,
4206600000000000000000,
7557821225391413978837,
464712333944441635106,
2346868529170090250000,
283382561106432166395,
1328158079230138785070,
5133723697638050490,
12600000000000000000,
21411175020542317390000,
94000000000000000000,
6915436173974553300,
12395964528609990796,
2160350807177508634828,
9900000000000000000,
111310019177170106740,
5869092475887733629183,
145000000000000000000,
3427336731430387920,
10871579293344289500000,
50575312235750591180,
10110000000000000000000,
389702752316916826599,
23938535763147083667000,
152626795995955323990,
71478000000000000000,
492000000000000003799,
20300000000000000000000,
16,
33000000000000000000,
477991536035578635387,
5500000000000000000,
9900000000000000000,
94566909313836745744,
2612000000000000000000,
24126187416111367268,
204552523373949732494,
69439706980435757208,
227386345822743434317,
21783720135162187207872,
102866922147360114441,
534221568200492970000,
98871770990326173185,
6732,
2893567457221459920693,
16030000000000000000,
459916000000000000000,
460669297019725888025,
3735678410278272906865,
173439552000000000000,
1574644283483977250052,
173594615425120593618,
54252000000000000000,
275400000000000000000,
122500000000000000000,
440000000000000000000,
423000000000000000000,
2500000000000000000,
8800000000000000000,
2382500000000000000000,
5326458085930638136227,
5800000000000000000,
962447907064234369449,
425286702112278654000,
15500000000000000000,
1419126378807231521366,
2430429470750166531370,
1450992000000000000000,
13656920743893800049,
714003124682843677699,
436531244864420698000,
199623460600805886165,
88458187709541608875,
219224000000000000000,
10271158586688578500000,
13147997520556968013248,
75573631791294409287,
1284205394001643395000,
173684470175005472670,
89600000000000000000,
32253,
4074150819697503265882,
2907843325779416361669,
7864074830980094360,
14500000000000000000,
181757206296974813943869,
12294544138585229493,
13889005581471117975792,
10904000000000000000000,
2559498403804558996470,
36870355325890615498,
57629164120790445390,
246457470492417532418
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