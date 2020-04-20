LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ALL;
ENTITY one_digit_clock_tester IS
    PORT (
        ---- INPUTS
        clkIn   : IN std_logic;                    -- Clockinput
        modeIn  : IN std_logic_vector(1 DOWNTO 0); -- Mode select
        resetIn : IN std_logic;                    -- Reset in // Active low
        speedIn : IN std_logic;                    -- Speed selection // Active low

        segOut  : OUT std_logic_vector(6 DOWNTO 0); -- Display output
        coutOut : OUT std_logic                     -- Carry out -- / Sequence complete
    );
END ENTITY one_digit_clock_tester;

ARCHITECTURE testSetup OF one_digit_clock_tester IS

    SIGNAL MultiCounterOutput : std_logic_vector(3 DOWNTO 0);
    SIGNAL ClkOut_internal    : std_logic;

BEGIN

    ClockGenerator : ENTITY clock_gen
        PORT MAP
        (
            clk     => clkIn,
            reset   => resetIn,
            speed   => speedIn,
            clk_Out => ClkOut_internal
        );

    MultiCounter : ENTITY multi_counter
        PORT MAP
        (
            clk   => ClkOut_internal,
            reset => resetIn,
            mode  => modeIn,
            count => MultiCounterOutput,
            cout  => coutOut
        );

    Hexdisplay : ENTITY bin2hex
        PORT MAP
        (
            bin => MultiCounterOutput,
            seg => segOut
        );

END ARCHITECTURE TestSetup;