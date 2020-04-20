LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ALL;
ENTITY one_digit_clock_tester IS
    PORT (
        -- INPUTS
        CLOCK_50 : IN std_logic;                      -- Clock
        SW       : IN std_logic_vector(17 DOWNTO 16); -- Mode select
        KEY      : IN std_logic_vector(3 DOWNTO 0);   -- Speed select and reset
        -- OUTPUTS
        HEX0 : OUT std_logic_vector(6 DOWNTO 0); -- Display output
        LEDR : OUT std_logic_vector(3 DOWNTO 0)  -- Carry out
    );
END ENTITY one_digit_clock_tester;

ARCHITECTURE testbench OF one_digit_clock_tester IS

    SIGNAL MultiCounterOutput : std_logic_vector(3 DOWNTO 0);
    SIGNAL ClkOut_internal    : std_logic;

BEGIN

    ClockGenerator : ENTITY clock_gen
        PORT MAP
        (
            clk     => CLOCK_50,
            reset   => KEY(3),
            speed   => KEY(0),
            clk_Out => ClkOut_internal
        );

    MultiCounter : ENTITY multi_counter
        PORT MAP
        (
            clk   => ClkOut_internal,
            reset => KEY(3),
            mode  => SW,
            count => MultiCounterOutput,
            cout  => LEDR(0)
        );

    Hexdisplay : ENTITY bin2hex
        PORT MAP
        (
            bin => MultiCounterOutput,
            seg => HEX0
        );

END ARCHITECTURE testbench;