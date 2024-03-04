# [OAO Limerick](https://github.com/Tokenseller-Leezi/OAOLimerick) [![License: AGPL-3.0-only](https://img.shields.io/badge/License-AGPL-black.svg)](https://opensource.org/license/agpl-v3/) [![solidity](https://img.shields.io/badge/solidity-%5E0.8.24-black)](https://docs.soliditylang.org/en/v0.8.24/) ![tests](https://github.com/z0r0z/zenplate/actions/workflows/ci.yml/badge.svg)

**Onchain AI Oracle Limerick** (OAOLimerick): A Limerick NFT based on [OAO](https://github.com/hyperoracle/OAO).

## Overview

Generate a Limerick based on the user-input keywords. And mint an NFT based on it.

With the help of [opML](https://arxiv.org/pdf/2401.17555.pdf). The automatic generation process of limericks is completely on-chain.

prompt: `Generate a limerick about 'flower' without mentioning 'flower'`

## Dev Guide

### Quick Start

```sh
git clone https://github.com/Tokenseller-Leezi/OAOLimerick.git
cd OAOLimerick && npm install
cp .env.example .env && vim .env # PRIVATE_KEY is required.
WORD="flower" npx hardhat run scripts/requestLimerick.js
```

The results are as follows.

```
There once was a bloom in the trees,
So delicate, it would make you freeze,
With petals of pink and white,
It danced in the light of the night,
And brought joy to all who would please.
```

## Examples
1. Moon

```
There once was a night so serene,
The stars shone bright, the sky was clean.
A glowing orb in the distance,
Cast shadows of wonder and distance,
A sight to behold, pure and keen.
```

2. duck

```
There once was a bird with feathers so bright,
Whose quacks were as loud as the morning light.
It swam in the pond,
With a wiggle and a bound,
And chased after fish with delight.
```

3. Sun

```
There once was a glowing sphere of light,
That brought warmth and joy to the sight.
It rose each day with grace,
And filled the world with its embrace,
Bringing brightness to the morning light.
```

4. Milky Way

```
There once was a galaxy so bright,
Whose stars shone with a lovely sight.
It twinkled and glimmered,
With a beauty so slimmer,
And filled the night with pure delight.
```

## Disclaimer

_These smart contracts and testing suite are being provided as is. No guarantee, representation or warranty is being made, express or implied, as to the safety or correctness of anything provided herein or through related user interfaces. This repository and related code have not been audited and as such there can be no assurance anything will work as intended, and users may experience delays, failures, errors, omissions, loss of transmitted information or loss of funds. The creators are not liable for any of the foregoing. Users should proceed with caution and use at their own risk._

## License

See [LICENSE](./LICENSE) for more details.

## Thanks

- [Idea from hunter](https://twitter.com/ownsacomputer/status/1762885117012254987)
