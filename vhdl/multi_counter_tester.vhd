LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE work.ALL;
<<<<<<< HEAD
ENTITY multi_counter_tester IS
    PORT
    (
        -- inputs
        clkIn   : IN std_logic;                     -- Clockinput
        modeIn  : IN std_logic_vector(1 DOWNTO 0);  -- Mode select
        resetIn : IN std_logic;                     -- Reset in // Active low
        -- outputs
        segOut  : OUT std_logic_vector(6 DOWNTO 0); -- Display output
        coutOut : OUT std_logic                     -- Carry out
=======
>>>>>>> d6e6a630536b92128e2274364bc6eb0a4ec06fdf

ENTITY multi_counter_tester IS
    PORT (
        SW   : IN std_logic_vector(17 DOWNTO 16);
        KEY  : IN std_logic_vector(3 DOWNTO 0);
        HEX0 : OUT std_logic_vector(6 DOWNTO 0);
        LEDR : OUT std_logic_vector(3 DOWNTO 0)
    );
END ENTITY multi_counter_tester;

ARCHITECTURE testbench OF multi_counter_tester IS
    SIGNAL countOut : std_logic_vector(3 DOWNTO 0);
BEGIN
    uut0 : ENTITY multi_counter
        PORT MAP
        (
            clk   => KEY(0),
            mode  => SW,
            reset => KEY(3),
            count => countOut,
            cout  => LEDR(0)
        );
    uut1 : ENTITY bin2sevenseg
        PORT MAP
        (
            bin => countOut,
            seg => HEX0
        );
END ARCHITECTURE;