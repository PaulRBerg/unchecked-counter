// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.19 <0.9.0;

import { PRBTest } from "@prb/test/PRBTest.sol";
import { StdUtils } from "forge-std/StdUtils.sol";

import { ONE, UC, uc, unwrap, wrap, ZERO } from "../src/UC.sol";

contract UCTest is PRBTest, StdUtils {
    /*//////////////////////////////////////////////////////////////////////////
                                LOGIC FUNCTIONS
    //////////////////////////////////////////////////////////////////////////*/

    function testFuzz_Add_Sum(uint256 value0, uint256 value1) external {
        uint256 actualSum = UC.unwrap(uc(value0) + uc(value1));
        uint256 expectedSum;
        unchecked {
            expectedSum = value0 + value1;
        }
        assertEq(actualSum, expectedSum, "Sums does not match");
    }

    function testFuzz_Add_Iterations(uint256 iterations) external {
        iterations = bound(iterations, 0, 10_000);

        uint256 actualCounter;
        for (UC i = ZERO; i < uc(iterations); i = i + ONE) {
            ++actualCounter;
        }
        uint256 expectedCounter = iterations;
        assertEq(actualCounter, expectedCounter, "Counters do not match");
    }

    function testFuzz_Lt(uint256 x, uint256 y) external {
        vm.assume(x < y);
        bool result = uc(x) < uc(y);
        assertTrue(result, "x not lower than y");
    }

    function testFuzz_Lte(uint256 x, uint256 y) external {
        vm.assume(x <= y);
        bool result = uc(x) <= uc(y);
        assertTrue(result, "x not lower than or equal to y");
    }

    /*//////////////////////////////////////////////////////////////////////////
                                CASTING FUNCTIONS
    //////////////////////////////////////////////////////////////////////////*/

    function testFuzz_Into(UC x) external {
        uint256 actual = x.into();
        uint256 expected = UC.unwrap(x);
        assertEq(actual, expected, "into value does not match");
    }

    function testFuzz_Uc(uint256 x) external {
        uint256 actual = UC.unwrap(uc(x));
        uint256 expected = x;
        assertEq(actual, expected);
    }

    function testFuzz_Unwrap(UC x) external {
        uint256 actual = unwrap(x);
        uint256 expected = x.unwrap();
        assertEq(actual, expected, "unwrap value does not match");
    }

    function testFuzz_Wrap(uint256 x) external {
        uint256 actual = UC.unwrap(wrap(x));
        uint256 expected = x;
        assertEq(actual, expected, "wrap value does not match");
    }
}
