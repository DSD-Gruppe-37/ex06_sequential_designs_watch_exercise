LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ALL;
ENTITY multi_counter_tester IS
    PORT
    (
        clkIn   : IN std_logic;                     -- Clockinput
        modeIn  : IN std_logic_vector(1 DOWNTO 0);  -- Mode select
        resetIn : IN std_logic;                     -- Reset in // Active low

        segOut   : OUT std_logic_vector(6 DOWNTO 0); -- Display output
        coutOut  : OUT std_logic                     -- Carry out

    );
END ENTITY multi_counter_tester;

ARCHITECTURE testSetup OF multi_counter_tester IS

    SIGNAL MultiCounterOutput : std_logic_vector(3 DOWNTO 0);

BEGIN
    MultiCounter : ENTITY multi_counter
        PORT MAP
        (
            clk               => clkIn,
            reset             => resetIn,
            mode(1 DOWNTO 0)  => modeIn(1 DOWNTO 0),
            count(3 DOWNTO 0) => MultiCounterOutput(3 DOWNTO 0),
            cout              => coutOut
        );

    Hexdisplay : ENTITY bin2hex(Behavioral)
        PORT
        MAP
        (
        bin(3 DOWNTO 0)  => MultiCounterOutput(3 DOWNTO 0),
        sseg(6 DOWNTO 0) => segOut(6 DOWNTO 0)
        );

END ARCHITECTURE testsetup;