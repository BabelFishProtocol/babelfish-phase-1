pragma solidity ^0.5.16;
import { Table } from "../Table.sol";

contract Table_36 is Table {
    address[] public addresses = [
        0xD4F0A5aa83f51D3AbF4136FfC70438A43eeACDB8,
0xD4Fd74321fFd1889C54657F5103a655fb5C280ca,
0xd507D4Af71088BAfbf2eA0CdB6962694F850DE01,
0xD50A3715E21f4560C424F14c2e8DD532d0C4Fcbf,
0xd52AA86678aF8346674097a36b29d3008bE5A77a,
0xD52D0b8ebb9268A6170c83C35bE398194ea4108e,
0xD547d6eaf4a9213a36A54167E83BC3aBd8DE6B8E,
0xD5614A5E78b0E5e6A643E4bd00a3d142223257e2,
0xD56CCcbf630aF93ed43a43149D23D415ab9729E2,
0xd56E7cD98d0d6c359AdAAAfaf05B0dFF4fB18A7C,
0xd59626578506A6E51e74b63818Afe164A7Fe37C9,
0xD5983E85701368A42f555d471c3497e28c99ca86,
0xd59A9e2e71710b91A9E5f7f2347C4e243125ca0E,
0xd5cFce4B005d17FcD4507E1401a4de74aB62546a,
0xD5d452cb6c742feF66d1739AeF5084735ca0Af75,
0xd5e703f03283bDdDeC4df2c91C75076ef9475aCC,
0xD5F0311B8c9A7b58Dd2F28C6115F1BD4fa01e408,
0xD6009b6A5F9dBeeA3CdaC73af649C662a5d9bdE3,
0xD63541d2872c26A7B867a78a95A093D7e7E51E98,
0xd65E9141306F55a4Df6beAE1F60a39563E01C2Bc,
0xd65F03Da860dDf3cc46D12Ee9498949E20958Cb2,
0xd675FD52F270F0EE71F472Ab206f9D498aB48531,
0xd67ab2338f3bf0B7c10172d5Fb78129ad0d19E8f,
0xd67D00aB2D1594446b68b6E42FA723232AE8e5b0,
0xD6aDd201E829cbF99C3ae8Dad0ae8C7FDCd8dA1c,
0xd6b265454Fa6250727f9F0C760D1dD96D3724851,
0xD6B29aB62Bbf428615f7d091017cCC0145d705f8,
0xd6bB291C5cF2AdD7Af7b7069a6C2b09afeAdB679,
0xD6bD12dca22b7f335766330b8fB1dfC232dd9279,
0xD6DA9024B0c645d513C6992F25Bc0D9CD09A5fde,
0xD6E4CabeD8F49524E26577f27720b9c069B091f9,
0xd6fD02aC334588b97852Aa5a4593172472ad96A4,
0xD6Ff0Dc2aFB480a920dd22dd1F9aCba253E41eA1,
0xD715a37dC7198BB9B470C3d0dCda639D69782eE1,
0xD72B09be800CCADC82cD94E3420aBd780db0823E,
0xd72F9B0450aeEe25Cd5F5382B10057054f998280,
0xD745259432406E22686fBcb88b19d82432e6007e,
0xD762A0E88A5edD6A1d2A49084acF3d04C4D434E2,
0xD7655258d3f1F2b229f8324baBE49452b05F85E4,
0xD76F126E3464921Cb30209f87Fb17625d2179443,
0xD7831ff16c32B21D9f79975b3473f74Cd4998407,
0xD78988EA51207B1597231ec275Dfd86ad2CF35C9,
0xD78f6BE297445bef3291dc6E7e5A1eBB9c7D4AeB,
0xD79584543889B4BD66A4323cC4a097304ABAAAc5,
0xD7Af90D4aF6e16aBEd51A6BcCbA16701A4D5E775,
0xD7c01CB09870c3E810a56F0f75BD7a0D995A8d8c,
0xD7C9A8592015aE56e5537AA7d98c5D2A929B2E95,
0xd7E062D512DB46b514239b443AF6BFD80F475a3a,
0xd7Fb9F1faFE2B73FEb42f401154f1e66Db41dc06,
0xd801DAf9CD5B7b50A4A596C65c397F948703D480,
0xd81404711B0050F9bbF9684f468B6DA5C0F50Fc2,
0xD81DfBA46f294CE8b36c2B63990b83E1c7e1221b,
0xd8210B56558C489134632401695b0e2D9e77F832,
0xd8280EEd7F6f14593cCA5ADF79368BEf87e8f177,
0xD8299952344E5CB99AaB259342137F3C275844f0,
0xD83F3cf22B608d29D5738cf249f5Ab5fab4d6845,
0xD84d5586ED39a98b3C574105Ab103472cbce7685,
0xD852b0c99Ffdb9ac7342c08240a8629a0a58a01C,
0xd86076A23c589B5288a65F570BCfD925C972F266,
0xD865bc9E78077201bdfa2a086C159b921972c7ae,
0xD86bE49f59d3D4bC5E22F296f8Fa0a1861Ddcb8d,
0xd87FC6e603ffAe66E65a6b9ca413bCF60c472618,
0xd89286a0cab5A740E664c7A4656bFF3aA08A9C4A,
0xD8A36c37e6bE7192e34734794dF53285637773aD,
0xd8b38E06bBF64aED51ea1537732B922e94cAcF02,
0xD8CdF918F6BBCf18b6D5E711Cf6a0F8cB349a54B,
0xD8cE6E865C4625A838854E6F7febc15ec9183457,
0xd8eaAe469a91040056BeB754dfB6929c15f489E9,
0xD8fBfB7973BE97d27Ba61bdFf2d706195fCD4928,
0xD901a184c28d2cC9837764d88f2e117FB215F564,
0xD906A59641a33B5D1c7D84767C78a381643997A0,
0xD908Ce2ccB2c2eC1E7bA91B29D331ECaa4AFD9E6,
0xd90c6f6D37716b1Cc4dd2B116be42e8683550F45,
0xd92666e60e31F221988a529a8F375ABDE78f9815,
0xd92b951d6BEEBF5F57C09d4DCE0f9FbA120733a1,
0xD94ADBa59069Bd4A4fCaA381F8dc2453B7e465d9,
0xD95434bF83F34253152704DD0E61cc81BcC6C2d3,
0xD962A9eb2f23028066e59f086b46D9D197484019,
0xd965bB53475CEa7589fAD24765485F19C9c4463B,
0xD97527053170FEB1bd5db25594F9A49CF5d34181,
0xD98dF6d516E45C3d1579F7f7Be5Ad3442F73A604,
0xd9Bb2DBF16262A5E3fAd7811602251E1a93f873C,
0xd9E1872866D657Bc011594C7a04854E3E5078D13,
0xd9f11a7904fD51c246a4e24B7E59695E09C4dD77,
0xd9F153Db848D8165E855Af26C9BE7304D3ADC2E9,
0xda00fcb4c3C1E0d4B233701b6B7e95672b069BD9,
0xDA14D6c27C022794Cd12d11072ccfa3415750DB4,
0xda3af25692463B9f29BdB1d83D5032f37Fc6ea19,
0xDA3cFd1B3Ed7b471F66C97fd34C8267D5818a138,
0xDa43e8D0fc4EA3e1C278C7f81B26cb26287B1D6b,
0xDA455d3fc97071069839946048aaaA6E24824e71,
0xDA4716309b638E0B11c194a50BE3C382f29dF4d5,
0xDA4CA837470CDD439be6D6b078b1710e2D1f345C,
0xdA51506F8Dc03D30E86D6ae8e2c799CE4deB25cF,
0xdA5c6D3B1C585DB86681e3582dd93827acB674F3,
0xDA6E8b0d86836f6291655F94a6219B98A643b31F,
0xda732a552681619432B6C62a804a668f12De13a5,
0xda77a5ac1Bc424d89Aec3ec5581C71A0F578D5cF,
0xdA8f46C5f3f37e2A71E359Db2383E72e72Fdd15f,
0xdA9b355dCE6C399A160Eb76e3F472320FB77C1d2
    ];

    uint256[] public amounts = [
        400935,
3068514050944946870000,
2422535922299977541203,
31909450226627734675,
31264978798239850503,
208340520921425144739,
451,
2455263840386195800000,
116800000000000000000,
185953596249506599616,
1283894823336072300000,
52833669609316936000,
8800000000000000000,
82968635990139692400,
12655,
10238737000821692220000,
99000000000000000000,
20986470000000000000000,
7615975710764174180000,
30965485824044705743,
915788471027458390744,
108617182725064099473,
16799891229342765228329,
596219791454176165399,
16440000000000000000000,
4664000000000000000,
290000000000000000000,
23930808032976540768,
26015765490662408502,
320989172756975635569,
2500000000000000000,
2182516000000000000000,
484680702425051115769,
181401065747650455531,
3324000000000000000000,
575904188941192521925,
414431769845788944337,
6572800000000000000000,
2869808789106674230000,
114392619854719613583,
741254905332501949564,
516826144673850587829,
1327407408826015434198,
1258932310764875126608,
324548356614626130000,
599721386660975700000,
110000000000000000000,
12771578744425805192417,
4350000000000000000,
142435917455359239477,
439303043862409105179,
547061001136512841835,
77496543755135579200,
61578286632229672663,
729600000000000000000,
4553124000000000000000,
301954653550480908275,
9829300000000000000000,
27872000000000000000000,
277321281840591633000,
169711345777954493657,
1301999081468375080730,
4310999707532215015991,
2900000000000000000,
967914589975349268000,
633973231504673170335,
20360000000000000000000,
20680498476482808974,
4350000000000000000,
93000000000000000000,
396915519196371103266,
5500000000000000000,
6072000000000000000,
2079463769159879270,
293260000000000000000,
1771794106922760656000,
8414369076391597200000,
347914394427055011546,
46500000000000000000,
35294122407210821700,
80347614706358202175,
492814913451120621819,
2500000000000000000,
694369393591590445000,
1679792165396500057500,
379900000000000000000,
34418113787386581500,
127332268108620574000,
288286105966972230776,
13398061716391320009598,
16702823287738826627769,
98294987674609699000,
33500000000000000000,
3712998192276088970000,
60589119352479799284,
290902512740802002721,
164374640163981693836,
3135085807299661112511,
2016163814373994124740,
9225350000000000418491
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