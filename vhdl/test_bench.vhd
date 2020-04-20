LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.ALL;

ENTITY test_bench IS
    PORT (
        ---- INPUTS
        CLOCK_50 : IN std_logic;
        SW       : IN std_logic_vector(17 DOWNTO 0);
        KEY      : IN std_logic_vector(3 DOWNTO 0);
        ---- OUTPUTS
        HEX0 : OUT std_logic_vector(6 DOWNTO 0);
        HEX1 : OUT std_logic_vector(6 DOWNTO 0);
        HEX2 : OUT std_logic_vector(6 DOWNTO 0);
        HEX3 : OUT std_logic_vector(6 DOWNTO 0);
        HEX4 : OUT std_logic_vector(6 DOWNTO 0);
        HEX5 : OUT std_logic_vector(6 DOWNTO 0);
        HEX6 : OUT std_logic_vector(6 DOWNTO 0);
        HEX7 : OUT std_logic_vector(6 DOWNTO 0);
        LEDR : OUT std_logic_vector(6 DOWNTO 0)
    );
END;

ARCHITECTURE TestBench OF test_bench IS

BEGIN

    -- Turn off HEX (Active low...)
    HEX0 <= ("1111111");
    HEX1 <= ("1111111");
    -- HEX2 <= ("1111111");
    -- HEX3 <= ("1111111");
    -- HEX4 <= ("1111111");
    -- HEX5 <= ("1111111");
    -- HEX6 <= ("1111111");
    -- HEX7 <= ("1111111");
    --------------------------------------------------

    -- oneDigitClockTester : ENTITY one_digit_clock_tester
    --     PORT MAP
    --     (
    --         ---- Input
    --         clkIn   => CLOCK_50,
    --         speedIn => key(0),
    --         resetIn => key(3),
    --         modeIn  => SW(17 DOWNTO 16),
    --         ---- Output
    --         coutOut => LEDR(0),
    --         segOut  => HEX0
    --     );
    -- --------------------------------------------------
    watchTester : ENTITY watch
        PORT MAP
        (
            ---- Input
            clk   => CLOCK_50,
            speed => key(0),
            reset => key(3),
            ---- Output
            sec_1  => HEX2,
            sec_10 => HEX3,
            min_1  => HEX4,
            min_10 => HEX5,
            hrs_1  => HEX6,
            hrs_10 => HEX7,
            tm     => OPEN
        );
    --------------------------------------------------

END;