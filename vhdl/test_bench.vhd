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
        HEX0   : OUT std_logic_vector(6 DOWNTO 0);
        HEX1   : OUT std_logic_vector(6 DOWNTO 0);
        HEX2   : OUT std_logic_vector(6 DOWNTO 0);
        HEX3   : OUT std_logic_vector(6 DOWNTO 0);
        HEX4   : OUT std_logic_vector(6 DOWNTO 0);
        HEX5   : OUT std_logic_vector(6 DOWNTO 0);
        HEX6   : OUT std_logic_vector(6 DOWNTO 0);
        HEX7   : OUT std_logic_vector(6 DOWNTO 0);
        LEDR   : OUT std_logic_vector(6 DOWNTO 0);
        GPIO_0 : OUT std_logic_vector(35 DOWNTO 0)
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

    -- watchTester : ENTITY watch
    --     PORT MAP
    --     (
    --         ---- Input
    --         clk    => CLOCK_50,
    --         speed  => key(0),
    --         reset  => key(3),
    --         ---- Output
    --         sec_1  => HEX2,
    --         sec_10 => HEX3,
    --         min_1  => HEX4,
    --         min_10 => HEX5,
    --         hrs_1  => HEX6,
    --         hrs_10 => HEX7,
    --         tm     => OPEN
    --     );
    -- --------------------------------------------------

    --------------------------------------------------
    AlarmWatch : ENTITY alarm_watch_tester
        PORT MAP
        (
            -- inputs
            bin_min1  => SW(3 DOWNTO 0),
            bin_min10 => SW(7 DOWNTO 4),
            bin_hrs1  => SW(11 DOWNTO 8),
            bin_hrs10 => SW(15 DOWNTO 12),
            clk       => CLOCK_50,
            speed     => KEY(0),
            reset     => KEY(3),
            view      => KEY(2),
            --outputs
            alarm  => LEDR(0),
            buzzer => GPIO_0(0),
            HEX02  => HEX2,
            HEX03  => HEX3,
            HEX04  => HEX4,
            HEX05  => HEX5,
            HEX06  => HEX6,
            HEX07  => HEX7
        );
    --------------------------------------------------

END;