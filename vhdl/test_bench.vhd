LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.ALL;

ENTITY test_bench IS
    PORT
    (
        ---- INPUTS
        CLOCK_50 : IN std_logic;
        SW   : IN std_logic_vector(17 DOWNTO 0);
        KEY  : IN std_logic_vector(3 DOWNTO 0);
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
    HEX1 <= ("1111111");
    HEX2 <= ("1111111");
    HEX3 <= ("1111111");
    HEX4 <= ("1111111");
    HEX5 <= ("1111111");
    HEX6 <= ("1111111");
    HEX7 <= ("1111111");
    --------------------------------------------------
<<<<<<< HEAD

    -- MultiCounterTester : ENTITY multi_counter_tester
    --     PORT MAP
    --     (
    --         cout  => LEDR(0),
    --         seg   => HEX0,
    --         clk   => KEY(0),
    --         reset => key(3),
    --         mode  => SW(17 DOWNTO 16)
    --     );

    oneDigitClockTester : ENTITY one_digit_clock_tester
=======
    MultiCounterTester : ENTITY multi_counter_tester
>>>>>>> 92a25a657b90d9ffc96607127e596f75c8508a11
        PORT MAP
        (
            cout  => LEDR(0),
            seg   => HEX0,
            clk   => CLOCK_50,
            speed => key(0),
            reset => key(3),
            mode  => SW(17 DOWNTO 16)
        );
    --------------------------------------------------

    -- --------------------------------------------------
    -- oneDigitClockTester : ENTITY one_digit_clock_tester
    --     PORT
    --     MAP
    --     (
    --     cout  => LEDR(0),
    --     seg   => HEX0,
    --     clk   => KEY(0),
    --     reset => key(3),
    --     mode  => SW(17 DOWNTO 16)
    --     );
    -- --------------------------------------------------

END;