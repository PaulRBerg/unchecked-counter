# Unchecked Counter [![Foundry][foundry-badge]][foundry] [![License: MIT][license-badge]][license]

[foundry]: https://getfoundry.sh/
[foundry-badge]: https://img.shields.io/badge/Built%20with-Foundry-FFDB1C.svg
[license]: https://opensource.org/licenses/MIT
[license-badge]: https://img.shields.io/badge/License-MIT-blue.svg

Solidity counter type that bypasses checked arithmetic, designed to be used in for loops.

## Background

User-defined value types (UDVTs) provide a means to create aliases for elementary Solidity types, resulting in a
zero-cost abstraction that enhances type safety and improves code readability. Solidity v0.8.19 onwards allows for the
binding of operators such as `+` to UDVTs, making the syntax even more concise and expressive.

Further recommended reading on this topic:

- [Solidity v0.8.8: User-Defined Value Types](https://blog.soliditylang.org/2021/09/27/user-defined-value-types/)
- [Solidity v0.8.19: User-Defined Operators](https://blog.soliditylang.org/2023/02/22/user-defined-operators/)

## Install

```sh
forge install PaulRBerg/unchecked-counter@v1
```

Your `.gitmodules` file should now contain the following entry:

```toml
[submodule "lib/unchecked-counter"]
  branch = "v1"
  path = "lib/unchecked-counter"
  url = "https://github.com/PaulRBerg/unchecked-counter"
```

## Usage

### With Casting Function

```solidity
// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.19;

import { UC, uc } from "unchecked-counter/UC.sol";

// Example that uses the `uc` casting function
function iterate(uint256[] memory arr) pure {
  for (UC i = uc(0); i < uc(arr.length); i = i + uc(1)) {
      uint256 element = arr[i.into()]; // or `i.unwrap()`
  }
}

```

### With Constants

```solidity
// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.19;

import { ONE, UC, ZERO } from "unchecked-counter/UC.sol";

// Example that uses the constants `ONE` and `ZERO`
function iterate(uint256[] memory arr) pure {
  uint256 counter;
  for (UC i = uc(0); i < uc(arr.length); i = i + uc(1)) {
      uint256 element = arr[i.into()]; // or `i.unwrap()`
  }
}
```

## Contributing

Feel free to dive in! [Open](https://github.com/PaulRBerg/unchecked-counter/issues/new) an issue,
[start](https://github.com/PaulRBerg/unchecked-counter/discussions/new) a discussion or submit a PR.

### Pre Requisites

You will need the following software on your machine:

- [Git](https://git-scm.com/downloads)
- [Foundry](https://github.com/foundry-rs/foundry)
- [Node.Js](https://nodejs.org/en/download/)
- [Yarn](https://yarnpkg.com/)

In addition, familiarity with [Solidity](https://soliditylang.org/) is requisite.

### Set Up

Clone this repository including submodules:

```sh
$ git clone --recurse-submodules -j8 git@github.com:PaulRBerg/unchecked-counter.git
```

Then, inside the project's directory, run this to install the Node.js dependencies:

```sh
$ yarn install
```

Now you can start making changes.

## License

[MIT](./LICENSE.md) © Paul Razvan Berg
