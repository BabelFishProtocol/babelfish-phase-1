export default {
    rskTestnet: {
        bassets: [
            // ETH->RSK
            '0xcb92c8d49ec01b92f2a766c7c3c9c501c45271e0', // DAIes
            '0xcc8eec21ae75f1a2de4ac7b32a7de888a45cf859', // USDCes
            '0x10c5a7930fc417e728574e334b1488b7895c4b81', // USDTes

            // BSC->RSK
            '0x407ff7d4760d3a81b4740d268eb04490c7dfe7f2', // bsDAI
            '0x3e2cf87e7ff4048a57f9cdde9368c9f4bfb43adf', // bsUSDC
            '0x43bc3f0ffff6c9bbf3c2eafe464c314d43f561de', // bsUSDT
            '0x8c9abb6c9d8d15ddb7ada2e50086e1050ab32688' // bsBUSD
        ],
        bridges: [
            // ETH->RSK
            '0xc0e7a7fff4aba5e7286d5d67dd016b719dcc9156',
            '0xc0e7a7fff4aba5e7286d5d67dd016b719dcc9156',
            '0xc0e7a7fff4aba5e7286d5d67dd016b719dcc9156',

            // BSC->RSK
            '0x2b2bcad081fa773dc655361d1bb30577caa556f8',
            '0x2b2bcad081fa773dc655361d1bb30577caa556f8',
            '0x2b2bcad081fa773dc655361d1bb30577caa556f8',
            '0x2b2bcad081fa773dc655361d1bb30577caa556f8'
        ],
        factors: [1, 1, 1, 1, 1, 1, 1]
    },
    rsk: {
        bassets: [
            // ETH->RSK
            '0x1a37c482465e78e6dabe1ec77b9a24d4236d2a11', // DAIes
            '0x8d1f7cbc6391d95e2774380e80a666febf655d6b', // USDCes
            '0xd9665ea8f5ff70cf97e1b1cd1b4cd0317b0976e8', // USDTes

            // BSC->RSK
            '0x6a42ff12215a90f50866a5ce43a9c9c870116e76', // DAIbs
            '0x91edcee9567cd5612c9dedeaae24d5e574820af1', // USDCbs
            '0xff4299bca0313c20a61dc5ed597739743bef3f6d', // USDTbs
            '0x61e9604e31a736129d7f5c58964c75935b2d80d6', // BUSDbs

            // non bridge
            '0xef213441a85df4d7acbdae0cf78004e1e486bb96' // RUSDT
        ],
        bridges: [
            // ETH->RSK
            '0x1ccad820b6d031b41c54f1f3da11c0d48b399581',
            '0x1ccad820b6d031b41c54f1f3da11c0d48b399581',
            '0x1ccad820b6d031b41c54f1f3da11c0d48b399581',

            // BSC->RSK
            '0x971b97c8cc82e7d27bc467c2dc3f219c6ee2e350',
            '0x971b97c8cc82e7d27bc467c2dc3f219c6ee2e350',
            '0x971b97c8cc82e7d27bc467c2dc3f219c6ee2e350',
            '0x971b97c8cc82e7d27bc467c2dc3f219c6ee2e350',

            // non bridge
            '0x0000000000000000000000000000000000000000'
        ],
        factors: [1, 1, 1, 1, 1, 1, 1, 1],
        multisig: '0x37a706259f5201c03f6cb556a960f30f86842d01'
    },
    development: {
        bassets: [
            '0xc064a7d5741dfDdAe7C6792972a5337845e180E3' // bogus
        ],
        bridges: [
            '0x0000000000000000000000000000000000000000',
        ],
        factors: [1]
    },
    btestnet: {
            bassets: [
                // RSK->BSC
                '0xc41d41cb7a31c80662ac2d8ab7a7e5f5841eebc3', // bRBTC

            ],
            bridges: [
                // RSK -> BSC
                '0x862e8aff917319594cc7faaae5350d21196c086f',

            ],
            factors: [1]
    },
    bmainnet: {
            bassets: [
                // RSK->BSC
                '', // bRBTC

            ],
            bridges: [
                // RSK -> BSC
                '0xdfc7127593c8af1a17146893f10e08528f4c2aa7',

            ],
        factors: [1]
    }
};
